import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide"]
  static values = { index: Number }

  connect() {
    this.indexValue = 0
    this.showCurrentSlide()
  }

  next() {
    this.indexValue = (this.indexValue + 1) % this.slideTargets.length
    this.showCurrentSlide()
  }

  previous() {
    this.indexValue = (this.indexValue - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showCurrentSlide()
  }

  goToSlide(event) {
    this.indexValue = parseInt(event.params.index)
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((slide, idx) => {
      slide.classList.toggle("hidden", idx !== this.indexValue)
    })
    this.updateDots()
  }

  updateDots() {
    const dots = document.querySelectorAll('[data-carousel-dot]')
    dots.forEach((dot, idx) => {
      if (idx === this.indexValue) {
        dot.classList.add('bg-british-red')
        dot.classList.remove('bg-white/50')
      } else {
        dot.classList.remove('bg-british-red')
        dot.classList.add('bg-white/50')
      }
    })
  }
}