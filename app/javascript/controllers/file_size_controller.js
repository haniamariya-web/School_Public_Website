import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    max: Number
  }

  connect() {
    this.clearValidation()
  }

  validate() {
    const file = this.element.files[0]

    if (!file) {
      this.clearValidation()
      return
    }

    if (file.size > this.maxValue) {
      const message = `File too large. Maximum size is ${this.maxValue / 1_048_576} MB.`
      this.element.setCustomValidity(message)
      this.element.reportValidity()
      this.showMessage(message)
      this.element.value = ""
      return
    }

    this.clearValidation()
  }

  clearValidation() {
    this.element.setCustomValidity("")
    this.showMessage("")
  }

  showMessage(message) {
    const messageElement = this.element.closest(".file-upload-wrapper")?.querySelector(".file-size-message")
    if (messageElement) {
      messageElement.textContent = message
    }
  }
}
