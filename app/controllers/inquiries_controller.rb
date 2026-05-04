class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.status = :pending

    if @inquiry.save
      # Enqueue background job to send email
      InquiryEmailJob.perform_later(@inquiry.id)
      redirect_to root_path, notice: t("flash.inquiries.thanks")
    else
      flash.now[:alert] = t("flash.inquiries.create_failed")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :phone, :grade_level, :preferred_call_time, :message)
  end
end
