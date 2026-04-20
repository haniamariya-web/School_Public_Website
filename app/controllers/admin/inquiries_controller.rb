class Admin::InquiriesController < Admin::BaseController
  def index
    @inquiries = Inquiry.order(created_at: :desc)
  end

  def mark_contacted
    @inquiry = Inquiry.find(params[:id])
    @inquiry.update(status: 1)  # 1 = contacted
    redirect_to admin_inquiries_path, notice: "Inquiry marked as contacted."
  end
end
