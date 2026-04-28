import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    timeout: Number
  }

  connect() {
    const duration = this.timeoutValue || 5000
    this.timeoutId = window.setTimeout(() => this.dismiss(), duration)
  }

  disconnect() {
    window.clearTimeout(this.timeoutId)
  }

  dismiss() {
    this.element.classList.add("transition-opacity", "duration-300", "opacity-0")
    window.setTimeout(() => this.element.remove(), 300)
  }
}
