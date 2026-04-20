class Admin::DashboardController < Admin::BaseController
  def index
    @posts_count = Post.count rescue 0
    @campuses_count = Campu.count rescue 0
    @inquiries_count = Inquiry.where(status: 0).count rescue 0
  end
end
