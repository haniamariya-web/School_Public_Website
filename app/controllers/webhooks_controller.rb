class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = STRIPE_WEBHOOK_SECRET

    event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)

    Rails.logger.info "Webhook received: #{event.type}"

    render json: { received: true }
  rescue Stripe::SignatureVerificationError => e
    render json: { error: e.message }, status: 400
  end
end
