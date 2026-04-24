import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["number"]

  connect() {
    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.startCounting(entry.target)
          this.observer.unobserve(entry.target)
        }
      })
    }, { threshold: 0.5 })

    this.numberTargets.forEach(target => {
      this.observer.observe(target)
    })
  }

  startCounting(element) {
    const target = parseInt(element.dataset.counterTargetValue, 10)
    const suffix = element.dataset.counterSuffixValue || ""
    const prefix = element.dataset.counterPrefixValue || ""
    const duration = 2000 // ms
    const frames = 60
    const increment = target / (duration / (1000 / frames))
    let current = 0

    const updateCounter = () => {
      current += increment
      if (current < target) {
        element.innerText = `${prefix}${Math.ceil(current).toLocaleString()}${suffix}`
        requestAnimationFrame(updateCounter)
      } else {
        element.innerText = `${prefix}${target.toLocaleString()}${suffix}`
      }
    }

    requestAnimationFrame(updateCounter)
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect()
    }
  }
}
