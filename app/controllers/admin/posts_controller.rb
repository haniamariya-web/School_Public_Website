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
      redirect_to admin_posts_path, notice: t("flash.admin.posts.created")
    else
      @post.build_media_file unless @post.media_file
      flash.now[:alert] = t("flash.admin.posts.create_failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post.build_media_file unless @post.media_file
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: t("flash.admin.posts.updated")
    else
      flash.now[:alert] = t("flash.admin.posts.update_failed")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to admin_posts_path, notice: t("flash.admin.posts.deleted")
  end

  def remove_media
    authorize @post
    if @post.media_file.present?
      @post.media_file.destroy
      notice_msg = t("flash.admin.posts.media_removed")
    else
      notice_msg = t("flash.admin.posts.no_media_found")
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
