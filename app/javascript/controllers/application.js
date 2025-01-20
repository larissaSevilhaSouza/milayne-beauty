import { Application } from "@hotwired/stimulus"
import Lightbox from '@stimulus-components/lightbox'
import AnimatedNumber from '@stimulus-components/animated-number'
import Dialog from '@stimulus-components/dialog'
import BiddingFormController from './bidding_form_controller'

const application = Application.start()
application.register('lightbox', Lightbox)
application.register('animated-number', AnimatedNumber)
application.register('dialog', Dialog)
application.register('bidding-form', BiddingFormController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }