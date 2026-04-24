class Admin::DashboardController < Admin::BaseController
  def index
    # Statistics
    @posts_count = Post.count rescue 0
    @campuses_count = Campu.count rescue 0
    @inquiries_count = Inquiry.where(status: 0).count rescue 0
    @news_count = News.count rescue 0
    @albums_count = Album.count rescue 0
    
    # Recent items
    @recent_posts = Post.order(created_at: :desc).limit(5) rescue []
    @recent_inquiries = Inquiry.where(status: 0).order(created_at: :desc).limit(5) rescue []
    @recent_news = News.order(created_at: :desc).limit(5) rescue []
    
    # Trends
    @total_contacts = Inquiry.count rescue 0
    @contacted_count = Inquiry.where(status: 1).count rescue 0
  end
end
