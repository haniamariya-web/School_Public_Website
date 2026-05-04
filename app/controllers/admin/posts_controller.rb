class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [ :edit, :update, :destroy, :remove_media ]
  before_action :authorize_post, only: [ :edit, :update, :destroy, :remove_media ]

  def index
    @posts = policy_scope(Post).includes(media_file: { file_attachment: :blob }).order(created_at: :desc)
    authorize Post
  end

  def new
    @post = Post.new
    @post.build_media_file
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    if @post.save
      redirect_to admin_posts_path, notice: "Post created successfully."
    else
      @post.build_media_file unless @post.media_file
      flash.now[:alert] = "Unable to create post. Fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post.build_media_file unless @post.media_file
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "Post updated successfully."
    else
      flash.now[:alert] = "Unable to update post. Fix the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to admin_posts_path, notice: "Post deleted."
  end

  def remove_media
    authorize @post
    if @post.media_file.present?
      @post.media_file.destroy
      notice_msg = "Media removed."
    else
      notice_msg = "No media found to remove."
    end
    redirect_to edit_admin_post_path(@post), notice: notice_msg
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize @post
  end

  def post_params
    params.require(:post).permit(
      :title, :content, :campus_id, :published_at,
      media_file_attributes: [ :id, :file, :_destroy ]
    )
  end
end
