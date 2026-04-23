import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["navLink", "mobileNavLink", "section"]

  connect() {
    this.setupRevealAnimations()
    this.setupScrollSpy()
  }

  setupRevealAnimations() {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add("opacity-100", "translate-y-0")
          entry.target.classList.remove("opacity-0", "translate-y-10")
          observer.unobserve(entry.target)
        }
      })
    }, { threshold: 0.1 })

    this.element.querySelectorAll('.reveal').forEach(el => observer.observe(el))
  }

  setupScrollSpy() {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.setActiveLink(entry.target.id)
        }
      })
    }, { rootMargin: "-20% 0px -70% 0px" }) // trigger when section is in top half of viewport

    this.sectionTargets.forEach(section => observer.observe(section))
  }

  scrollToSection(event) {
    event.preventDefault()
    const targetId = event.currentTarget.getAttribute("href").substring(1)
    const targetSection = document.getElementById(targetId)
    
    if (targetSection) {
      targetSection.scrollIntoView({ behavior: "smooth" })
    }
  }

  setActiveLink(id) {
    // Desktop Nav
    this.navLinkTargets.forEach(link => {
      if (link.getAttribute("href") === `#${id}`) {
        link.classList.add("border-british-red", "text-british-red", "bg-red-50/50")
        link.classList.remove("border-transparent", "text-gray-500", "hover:text-navy", "hover:bg-gray-50")
      } else {
        link.classList.remove("border-british-red", "text-british-red", "bg-red-50/50")
        link.classList.add("border-transparent", "text-gray-500", "hover:text-navy", "hover:bg-gray-50")
      }
    })

    // Mobile Nav
    this.mobileNavLinkTargets.forEach(link => {
      if (link.getAttribute("href") === `#${id}`) {
        link.classList.add("border-british-red", "bg-british-red", "text-white")
        link.classList.remove("border-gray-200", "bg-white", "text-gray-600")
        
        // Ensure mobile active link is scrolled into view
        link.scrollIntoView({ behavior: "smooth", inline: "center", block: "nearest" })
      } else {
        link.classList.remove("border-british-red", "bg-british-red", "text-white")
        link.classList.add("border-gray-200", "bg-white", "text-gray-600")
      }
    })
  }
}
