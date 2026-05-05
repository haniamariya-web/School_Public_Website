class FranchiseApplicationMailer < ApplicationMailer
  default from: "hanniafirdous@gmail.com" # Use the authenticated Gmail

  def payment_successful(application)
    @application = application
    mail(
      to: @application.email,
      subject: "Franchise Application Payment Successful - Britain International School"
    )
  end

  def application_approved(application)
    @application = application
    mail(
      to: @application.email,
      subject: "Franchise Application Approved - Britain International School"
    )
  end

  def application_rejected(application)
    @application = application
    mail(
      to: @application.email,
      subject: "Update on your Franchise Application - Britain International School"
    )
  end
end
