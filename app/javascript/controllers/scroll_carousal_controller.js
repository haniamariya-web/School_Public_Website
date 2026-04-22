import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  next() {
    this.containerTarget.scrollBy({
      left: 320,
      behavior: "smooth"
    })
  }

  prev() {
    this.containerTarget.scrollBy({
      left: -320,
      behavior: "smooth"
    })
  }
}