# app/controllers/admin/news_controller.rb
class Admin::NewsController < Admin::BaseController
  before_action :set_news, only: [ :edit, :update, :destroy, :remove_media ]

  def index
    @news = policy_scope(News).includes(media_file: { file_attachment: :blob }).order(published_at: :desc)
    authorize News
  end

  def new
    authorize News
    @news = News.new
    @news.build_media_file
  end

  def create
    authorize News
    @news = News.new(news_params)

    if @news.save
      redirect_to admin_news_index_path, notice: t("flash.admin.news.created")
    else
      @news.build_media_file unless @news.media_file
      flash.now[:alert] = t("flash.admin.news.create_failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @news
    @news.build_media_file unless @news.media_file
  end

  def remove_media
    authorize @news
    if @news.media_file&.destroy
      flash[:notice] = t("flash.admin.news.media_removed")
    else
      flash[:alert] = t("flash.admin.news.media_remove_failed")
    end
    redirect_back fallback_location: edit_admin_news_path(@news)
  end

  def update
    authorize @news
    if @news.update(news_params)
      redirect_to admin_news_index_path, notice: t("flash.admin.news.updated")
    else
      flash.now[:alert] = t("flash.admin.news.update_failed")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @news
    @news.destroy
    redirect_to admin_news_index_path, notice: t("flash.admin.news.deleted")
  end

  private

  def set_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(
      :title, :content, :campus_id,
      media_file_attributes: [ :id, :file, :_destroy ]
    )
  end
end
