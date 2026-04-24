class NewsController < ApplicationController
  def index
    @news = News.published
  end
end
