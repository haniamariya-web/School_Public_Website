class GalleryController < ApplicationController
  def index
    @albums = Album.includes(:campus, :posts).with_attached_cover_image.order(event_date: :desc)
    @posts = Post.includes(:campus, media_file: { file_attachment: :blob }).order(created_at: :desc).limit(16)
    @posts = @posts.select { |p| p.media_file&.file&.attached? }
  end

  def show
    @album = Album.includes(posts: [ :campus, { media_file: { file_attachment: :blob } } ]).find(params[:id])
  end
end
