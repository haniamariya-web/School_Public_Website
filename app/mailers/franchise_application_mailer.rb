class FranchiseApplicationMailer < ApplicationMailer
  default from: "hanniafirdous@gmail.com" # Use the authenticated Gmail

  def payment_successful(application)
    @application = application
    mail(
      to: @application.email,
      subject: "Franchise Application Payment Successful - Britain International School"
    )
  end
end
