class Admin::NewsController < Admin::BaseController
  before_action :set_news, only: [:edit, :update, :destroy]

  def index
    # Eager loading media_file and its blob to prevent N+1 queries
    @news = News.includes(media_file: { file_attachment: :blob }).order(published_at: :desc)
  end

  def new
    @news = News.new
    @news.build_media_file
  end

  def create
    @news = News.new(news_params)
    
    if @news.save
      redirect_to admin_news_index_path, notice: "News created successfully."
    else
      # Re-build media_file if it failed so the file field shows up again in the view
      @news.build_media_file unless @news.media_file
      flash.now[:alert] = "Unable to create news item. Fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @news.build_media_file unless @news.media_file
  end

  def remove_media
    @news = News.find(params[:id])
    if @news.media_file&.destroy
      flash[:notice] = "Media removed successfully."
    else
      flash[:alert] = "Failed to remove media."
    end
    redirect_back fallback_location: edit_admin_news_path(@news)
  end    

  def update
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
    # Added media_file_attributes to permit the nested file upload
    params.require(:news).permit(
      :title, :content, :campus_id,
      media_file_attributes: [:id, :file, :_destroy]
    )
  end
end