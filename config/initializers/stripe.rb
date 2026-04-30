Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
STRIPE_WEBHOOK_SECRET = Rails.application.credentials.dig(:stripe, :webhook_secret)