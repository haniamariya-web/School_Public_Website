class NewsController < ApplicationController
  def index
    @campuses = Campu.all
    @news = News.published

    if params[:campus_id].present?
      @news = @news.where(campus_id: params[:campus_id])
    end

    if params[:query].present?
      @news = @news.where("title LIKE ? OR content LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end
  end
end
