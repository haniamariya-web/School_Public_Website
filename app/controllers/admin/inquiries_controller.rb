class Admin::InquiriesController < Admin::BaseController
  before_action :set_inquiry, only: [:mark_contacted]

  def index
    @inquiries = Inquiry.order(created_at: :desc)
    @pending_count = Inquiry.pending.count
    @contacted_count = Inquiry.contacted.count
  end

  def mark_contacted
    @inquiry.update(status: :contacted)
    redirect_to admin_inquiries_path, notice: "Inquiry marked as contacted."
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end
end
