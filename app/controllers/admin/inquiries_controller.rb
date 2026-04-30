# app/controllers/admin/inquiries_controller.rb
class Admin::InquiriesController < Admin::BaseController
  before_action :set_inquiry, only: [:mark_contacted]
  before_action :authorize_inquiry

  def index
    @inquiries = policy_scope(Inquiry).order(created_at: :desc)
    @pending_count = @inquiries.pending.count
    @contacted_count = @inquiries.contacted.count
    authorize Inquiry
  end

  def mark_contacted
    @inquiry.update(status: :contacted)
    redirect_to admin_inquiries_path, notice: "Inquiry marked as contacted."
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def authorize_inquiry
    authorize @inquiry if @inquiry
  end
end