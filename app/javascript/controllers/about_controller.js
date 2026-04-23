import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  connect() {
    // Reveal animation on scroll
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add("opacity-100", "translate-y-0")
          entry.target.classList.remove("opacity-0", "translate-y-10")
        }
      })
    }, { threshold: 0.1 })

    document.querySelectorAll('.reveal').forEach(el => observer.observe(el))
  }

  switchTab(event) {
    const target = event.currentTarget.dataset.tab
    
    // Update Tab UI
    this.tabTargets.forEach(tab => {
      const isSelected = tab.dataset.tab === target
      
      if (isSelected) {
        tab.classList.add("border-british-red", "text-navy")
        tab.classList.remove("border-transparent", "text-gray-400")
      } else {
        tab.classList.remove("border-british-red", "text-navy")
        tab.classList.add("border-transparent", "text-gray-400")
      }
    })

    // Update Content
    this.contentTargets.forEach(content => {
      if (content.id === target) {
        content.classList.remove("hidden")
      } else {
        content.classList.add("hidden")
      }
    })
  }
}