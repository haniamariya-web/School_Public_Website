class InquiryMailer < ApplicationMailer
  default from: "hanniafirdous@gmail.com" # Your authenticated Gmail

  # 1. Notifies the school (You)
  def inquiry_received(inquiry)
    @inquiry = inquiry
    mail(
      to: "hanniaswork@gmail.com", 
      subject: "New Website Inquiry from #{inquiry.name}"
    )
  end

  # 2. Sends a confirmation to the User
  def confirmation_email(inquiry)
    @inquiry = inquiry
    mail(
      to: @inquiry.email, # This pulls the email the user entered in the form
      subject: "We've received your inquiry - Britain International School"
    )
  end
end