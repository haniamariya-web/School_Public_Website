class Admin::NewsController < Admin::BaseController
  before_action :set_news, only: [ :edit, :update, :destroy, :remove_media ]

  def index
    @news = News.all.order(published_at: :desc)
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      redirect_to admin_news_index_path, notice: "News created successfully."
    else
      flash.now[:alert] = "Unable to create news item. Fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def remove_media
    authorize @news
    if @news.media_file&.destroy
      flash[:notice] = "Media removed successfully."
    else
      flash[:alert] = "Failed to remove media."
    end
    redirect_back fallback_location: edit_admin_news_path(@news)
  end

  def update
    @news.image.attach(params[:news][:image]) if params[:news][:image].present?
    @news.video.attach(params[:news][:video]) if params[:news][:video].present?
    
    if @news.update(news_params)
      redirect_to admin_news_index_path, notice: "News updated successfully."
    else
      flash.now[:alert] = "Unable to update news item. Fix the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @news.destroy
    redirect_to admin_news_index_path, notice: "News deleted."
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
