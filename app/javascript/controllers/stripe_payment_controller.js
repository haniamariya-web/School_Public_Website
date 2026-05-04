import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    publicKey: String,
    clientSecret: String,
    returnUrl: String
  }
  static targets = ["paymentElement", "errorMessage"]

  async connect() {
    if (!window.Stripe) {
      await this.loadStripe()
    }
    this.initializeStripe()
  }

  loadStripe() {
    return new Promise((resolve, reject) => {
      const script = document.createElement("script")
      script.src = "https://js.stripe.com/v3/"
      script.onload = resolve
      script.onerror = reject
      document.head.appendChild(script)
    })
  }

  initializeStripe() {
    this.stripe = window.Stripe(this.publicKeyValue)
    this.elements = this.stripe.elements({ clientSecret: this.clientSecretValue })
    this.paymentElement = this.elements.create('payment')
    this.paymentElement.mount(this.paymentElementTarget)
  }

  async submit(event) {
    event.preventDefault()
    
    // Disable button to prevent double submission
    event.currentTarget.disabled = true
    
    const { error } = await this.stripe.confirmPayment({
      elements: this.elements,
      confirmParams: {
        return_url: this.returnUrlValue,
      },
    })

    if (error) {
      this.errorMessageTarget.textContent = error.message
      event.currentTarget.disabled = false
    }
  }
}
