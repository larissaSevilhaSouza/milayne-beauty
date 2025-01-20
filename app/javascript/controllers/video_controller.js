import { Controller } from "@hotwired/stimulus"
import IframeLightbox from '@stimulus-components/lightbox'

export default class extends Controller {
  static targets = ['lightbox']

  connect() {
    this.lightbox = IframeLightbox.attach(this.lightboxTarget)
    
  }

  openLightbox() {
    this.lightboxTarget.classList.remove('hidden')
    this.lightboxTarget.classList.add('flex')
    this.lightbox.open()
  }
  
  closeLightbox() {
    this.lightboxTarget.classList.remove('flex')
    this.lightboxTarget.classList.add('hidden')
    this.lightbox.close()
  }
}