class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [ :edit, :update, :destroy, :remove_media ]
  before_action :authorize_post, only: [ :edit, :update, :destroy, :remove_media ]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_posts_path, notice: "Post created successfully."
    else
      flash.discard
      flash.now[:alert] = "Unable to create post. Fix the errors below."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "Post updated successfully."
    else
      flash.discard
      flash.now[:alert] = "Unable to update post. Fix the errors below."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post deleted."
  end

  def remove_media
    if @post.media.attached?
      @post.media.purge
      puts "Media purged successfully"
    else
      puts "No media found"
    end
    redirect_to edit_admin_post_path(@post), notice: "Media removed."
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title, :content, :campus_id, :published_at,
      media_file_attributes: [ :id, :file, :_destroy ]
    )
  end
end
