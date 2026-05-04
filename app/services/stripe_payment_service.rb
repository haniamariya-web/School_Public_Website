class StripePaymentService
  def self.create_franchise_payment_intent(application)
    Stripe::PaymentIntent.create(
      amount: FranchiseApplication::FRANCHISE_FEE,
      currency: "usd",
      metadata: {
        franchise_application_id: application.id,
        applicant_email: application.email,
        applicant_name: application.name
      }
    )
  end

  def self.construct_event(payload, sig_header, endpoint_secret)
    Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
  end
end
