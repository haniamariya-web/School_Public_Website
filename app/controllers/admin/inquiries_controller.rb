class Admin::InquiriesController < Admin::BaseController
  def index
    @inquiries = Inquiry.order(created_at: :desc)
    @pending_count = Inquiry.pending.count
    @contacted_count = Inquiry.contacted.count
  end

  def mark_contacted
    @inquiry = Inquiry.find(params[:id])
    @inquiry.update(status: :contacted)
    redirect_to admin_inquiries_path, notice: "Inquiry marked as contacted."
  end
end
