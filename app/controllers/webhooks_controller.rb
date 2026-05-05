class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = STRIPE_WEBHOOK_SECRET

    event = StripePaymentService.construct_event(payload, sig_header, endpoint_secret)

    case event.type
    when "payment_intent.succeeded"
      payment_intent = event.data.object
      application = FranchiseApplication.find_by(stripe_payment_intent_id: payment_intent.id)
      if application
        payment = FranchisePayment.find_or_initialize_by(franchise_application_id: application.id)
        payment.update!(
          stripe_payment_intent_id: payment_intent.id,
          amount: payment_intent.amount,
          status: "succeeded",
          paid_at: Time.current
        )
      end
    when "payment_intent.payment_failed"
      payment_intent = event.data.object
      application = FranchiseApplication.find_by(stripe_payment_intent_id: payment_intent.id)
      if application
        payment = FranchisePayment.find_or_initialize_by(franchise_application_id: application.id)
        payment.update!(
          stripe_payment_intent_id: payment_intent.id,
          amount: payment_intent.amount,
          status: "failed"
        )
      end
    end

    Rails.logger.info "Webhook received: #{event.type}"

    render json: { received: true }
  rescue Stripe::SignatureVerificationError => e
    render json: { error: e.message }, status: 400
  end
end
