class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:edit, :update, :destroy, :remove_image, :remove_video]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    
    # Handle file attachments
    @post.image.attach(params[:post][:image]) if params[:post][:image].present?
    @post.video.attach(params[:post][:video]) if params[:post][:video].present?
    
    if @post.save
      redirect_to admin_posts_path, notice: "Post created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    # Handle file attachments
    @post.image.attach(params[:post][:image]) if params[:post][:image].present?
    @post.video.attach(params[:post][:video]) if params[:post][:video].present?
    
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "Post updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post deleted."
  end
  
  def remove_image
    @post.image.purge
    redirect_to edit_admin_post_path(@post), notice: "Image removed."
  end
  
  def remove_video
    @post.video.purge
    redirect_to edit_admin_post_path(@post), notice: "Video removed."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :campus_id, :published_at)
  end
end
