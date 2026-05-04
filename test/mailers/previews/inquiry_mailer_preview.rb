class InquiryMailerPreview < ActionMailer::Preview
  def inquiry_received
    # Create a fake inquiry in memory to show in the preview
    inquiry = Inquiry.new(
      name: "Test User",
      email: "test@example.com",
      message: "Hello, I am interested in admission."
    )

    # Pass that fake inquiry to the mailer method
    InquiryMailer.inquiry_received(inquiry)
  end

  def confirmation_email
    inquiry = Inquiry.new(
      name: "Test User",
      email: "test@example.com",
      message: "Hello, I am interested in admission."
    )

    InquiryMailer.confirmation_email(inquiry)
  end
end
