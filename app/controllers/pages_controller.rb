class PagesController < ApplicationController
  def home
    @recent_news = News.published.includes(media_file: { file_attachment: :blob }).limit(3)
  end

  def about; end
end
