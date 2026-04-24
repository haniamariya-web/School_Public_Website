import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "backdrop", "panel", "title", "date", "campus", "content", "mediaContainer", "image", "video"]

  connect() {
    this.boundHandleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.boundHandleKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.boundHandleKeydown)
  }

  open(event) {
    const params = event.currentTarget.dataset
    
    // Populate text data
    if (this.hasTitleTarget) this.titleTarget.textContent = params.newsModalTitleParam
    if (this.hasDateTarget) this.dateTarget.textContent = params.newsModalDateParam
    
    // Handle campus display
    if (this.hasCampusTarget) {
      if (params.newsModalCampusParam && params.newsModalCampusParam !== "") {
        this.campusTarget.textContent = params.newsModalCampusParam
        this.campusTarget.classList.remove("hidden")
        if (this.campusTarget.previousElementSibling) this.campusTarget.previousElementSibling.classList.remove("hidden")
      } else {
        this.campusTarget.classList.add("hidden")
        if (this.campusTarget.previousElementSibling) this.campusTarget.previousElementSibling.classList.add("hidden")
      }
    }

    if (this.hasContentTarget) this.contentTarget.textContent = params.newsModalContentParam
    
    // Reset media
    if (this.hasImageTarget) {
      this.imageTarget.classList.add("hidden")
      this.imageTarget.src = ""
    }
    if (this.hasVideoTarget) {
      this.videoTarget.classList.add("hidden")
      this.videoTarget.src = ""
    }
    if (this.hasMediaContainerTarget) {
      this.mediaContainerTarget.classList.add("hidden")
    }

    // Handle media if present
    if (params.newsModalHasMediaParam === "true" && this.hasMediaContainerTarget) {
      this.mediaContainerTarget.classList.remove("hidden")
      
      if (params.newsModalImageUrlParam && this.hasImageTarget) {
        this.imageTarget.src = params.newsModalImageUrlParam
        this.imageTarget.classList.remove("hidden")
      } else if (params.newsModalVideoUrlParam && this.hasVideoTarget) {
        this.videoTarget.src = params.newsModalVideoUrlParam
        this.videoTarget.classList.remove("hidden")
      }
    }

    // Show modal container
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      
      // Trigger animations in next frame to ensure display:block has applied
      requestAnimationFrame(() => {
        if (this.hasBackdropTarget) {
          this.backdropTarget.classList.remove("opacity-0")
          this.backdropTarget.classList.add("opacity-100")
        }
        
        if (this.hasPanelTarget) {
          this.panelTarget.classList.remove("opacity-0", "translate-y-4", "sm:translate-y-0", "sm:scale-95")
          this.panelTarget.classList.add("opacity-100", "translate-y-0", "sm:scale-100")
        }
      })
      
      // Prevent body scrolling
      document.body.style.overflow = "hidden"
    }
  }

  close() {
    // Start exit animations
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.remove("opacity-100")
      this.backdropTarget.classList.add("opacity-0")
    }
    
    if (this.hasPanelTarget) {
      this.panelTarget.classList.remove("opacity-100", "translate-y-0", "sm:scale-100")
      this.panelTarget.classList.add("opacity-0", "translate-y-4", "sm:translate-y-0", "sm:scale-95")
    }

    // Wait for animations to finish before hiding container completely
    setTimeout(() => {
      if (this.hasModalTarget) {
        this.modalTarget.classList.add("hidden")
      }
      
      // Pause video if playing to avoid background audio
      if (this.hasVideoTarget && !this.videoTarget.classList.contains("hidden")) {
        this.videoTarget.pause()
      }
      
      // Restore body scrolling
      document.body.style.overflow = ""
    }, 300)
  }

  handleKeydown(event) {
    if (event.key === "Escape" && this.hasModalTarget && !this.modalTarget.classList.contains("hidden")) {
      this.close()
    }
  }
}
