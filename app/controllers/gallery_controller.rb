class GalleryController < ApplicationController
  def index
    @albums = Album.includes(:campus, :posts).order(event_date: :desc)
    @posts = Post.includes(:campus).order(created_at: :desc).limit(16)
    @posts = @posts.select { |p| p.image.attached? || p.video.attached? }
  end
  
  def show
    @album = Album.includes(posts: :campus).find(params[:id])
  end
end
