class Admin::AlbumsController < Admin::BaseController
  before_action :set_album, only: [:edit, :update, :destroy, :add_post, :remove_post]

  def index
    @albums = Album.all.order(event_date: :desc)
  end

  def new
    @album = Album.new
    @available_posts = Post.all.order(created_at: :desc)
  end

  def create
    @album = Album.new(album_params)
    @album.cover_image.attach(params[:album][:cover_image]) if params[:album][:cover_image].present?
    
    if @album.save
      # Add selected posts after creation
      if params[:album][:post_ids].present?
        params[:album][:post_ids].each do |post_id|
          @album.posts << Post.find(post_id) unless post_id.blank?
        end
      end
      redirect_to admin_albums_path, notice: "Album created successfully."
    else
      @available_posts = Post.all.order(created_at: :desc)
      render :new
    end
  end

  def edit
    @available_posts = Post.where.not(id: @album.posts.pluck(:id)).order(created_at: :desc)
  end

  def update
    @album.cover_image.attach(params[:album][:cover_image]) if params[:album][:cover_image].present?
    
    # Add new posts if selected
    if params[:album][:post_ids].present?
      params[:album][:post_ids].each do |post_id|
        @album.posts << Post.find(post_id) unless post_id.blank? || @album.posts.pluck(:id).include?(post_id.to_i)
      end
    end
    
    if @album.update(album_params)
      redirect_to admin_albums_path, notice: "Album updated successfully."
    else
      @available_posts = Post.where.not(id: @album.posts.pluck(:id)).order(created_at: :desc)
      render :edit
    end
  end

  def destroy
    @album.destroy
    redirect_to admin_albums_path, notice: "Album deleted."
  end
  
  def add_post
    post = Post.find(params[:post_id])
    unless @album.posts.include?(post)
      @album.posts << post
      flash[:notice] = "Post added to album."
    else
      flash[:alert] = "Post already in album."
    end
    redirect_to edit_admin_album_path(@album)
  end
  
  def remove_post
    post = Post.find(params[:post_id])
    @album.posts.delete(post)
    redirect_to edit_admin_album_path(@album), notice: "Post removed from album."
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :description, :campus_id, :event_date)
  end
end
