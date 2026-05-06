class InquiryEmailJob < ApplicationJob
  queue_as :default

  def perform(inquiry_id)
    # error handling missing
    inquiry = Inquiry.find(inquiry_id)
    InquiryMailer.inquiry_received(inquiry).deliver_later
    InquiryMailer.confirmation_email(inquiry).deliver_later
  end
end
