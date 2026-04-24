class Admin::NewsController < Admin::BaseController
  before_action :set_news, only: [:edit, :update, :destroy]

  def index
    @news = News.all.order(published_at: :desc)
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    
    # Handle file attachments
    @news.image.attach(params[:news][:image]) if params[:news][:image].present?
    @news.video.attach(params[:news][:video]) if params[:news][:video].present?
    
    if @news.save
      redirect_to admin_news_index_path, notice: "News created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @news.image.attach(params[:news][:image]) if params[:news][:image].present?
    @news.video.attach(params[:news][:video]) if params[:news][:video].present?
    
    if @news.update(news_params)
      redirect_to admin_news_index_path, notice: "News updated successfully."
    else
      render :edit
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
    params.require(:news).permit(:title, :content, :published_at)
  end
end
