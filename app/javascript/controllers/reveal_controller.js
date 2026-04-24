import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add("opacity-100", "translate-y-0", "scale-100")
          entry.target.classList.remove("opacity-0", "translate-y-10", "translate-y-20", "scale-95")
          this.observer.unobserve(entry.target)
        }
      })
    }, { threshold: 0.1, rootMargin: "0px 0px -50px 0px" })

    // Observe all children with 'reveal' class
    this.element.querySelectorAll('.reveal').forEach(el => this.observer.observe(el))
    
    // Also observe the element itself if it has the class
    if (this.element.classList.contains('reveal')) {
      this.observer.observe(this.element)
    }
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect()
    }
  }
}
