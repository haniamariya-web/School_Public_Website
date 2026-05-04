# app/controllers/admin/inquiries_controller.rb
class Admin::InquiriesController < Admin::BaseController
  before_action :set_inquiry, only: [ :mark_contacted ]
  before_action :authorize_inquiry

  def index
    @inquiries = policy_scope(Inquiry).order(created_at: :desc)

    # Stats (always based on all accessible inquiries)
    @pending_count = @inquiries.pending.count
    @contacted_count = @inquiries.contacted.count

    # Filtering Logic
    if params[:status] == "all"
      # No filter applied, shows all
    elsif params[:status].present?
      @inquiries = @inquiries.where(status: params[:status])
    else
      @inquiries = @inquiries.pending
    end

    @inquiries = @inquiries.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    @inquiries = @inquiries.where(grade_level: params[:grade]) if params[:grade].present?

    if params[:date_range].present?
      case params[:date_range]
      when "yesterday"
        @inquiries = @inquiries.where(created_at: 1.day.ago.all_day)
      when "this_week"
        @inquiries = @inquiries.where(created_at: Time.current.all_week)
      when "this_month"
        @inquiries = @inquiries.where(created_at: Time.current.all_month)
      when "this_year"
        @inquiries = @inquiries.where(created_at: Time.current.all_year)
      end
    end

    @grades = Inquiry.distinct.pluck(:grade_level).compact.sort
    authorize Inquiry
  end

  def mark_contacted
    @inquiry.update(status: :contacted)
    redirect_to admin_inquiries_path, notice: t("flash.admin.inquiries.marked_contacted")
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def authorize_inquiry
    authorize @inquiry if @inquiry
  end
end
