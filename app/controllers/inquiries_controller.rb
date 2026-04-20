class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.status = :pending
    
    if @inquiry.save
      redirect_to root_path, notice: "Thank you! Our admissions team will contact you soon."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :phone, :grade_level, :preferred_call_time, :message)
  end
end