import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "toggleForm", "biddingCategory", 
    "contractFields", "contractEndFields", 
    "bidNoticeFields", "bidCompleteFields",
    "bidResultsFields"
  ]

  connect() {
    this.hideAllFields()
    this.toggleFormTarget.classList.remove("scale-y-0", "h-0")
    this.toggleFormTarget.classList.add("scale-y-100")
  }

  toggleForm(event) {
    event.preventDefault()
    if (this.toggleFormTarget.classList.contains("scale-y-100")) {
      this.toggleFormTarget.classList.remove("scale-y-100")
      this.toggleFormTarget.classList.add("scale-y-0")
      this.toggleFormTarget.classList.add("h-0")
    } else {
      this.toggleFormTarget.classList.remove("scale-y-0")
      this.toggleFormTarget.classList.remove("h-0")
      this.toggleFormTarget.classList.add("scale-y-100")
    }
  }

  hideAllFields() {
    this.contractFieldsTarget.classList.add("hidden")
    this.contractEndFieldsTarget.classList.add("hidden")
    this.bidNoticeFieldsTarget.classList.add("hidden")
    this.bidCompleteFieldsTarget.classList.add("hidden")
    this.bidResultsFieldsTarget.classList.add("hidden")  
  }

  showFields() {
    this.hideAllFields()
    switch(this.biddingCategoryTarget.value) {
      case "Contract":
        this.contractFieldsTarget.classList.remove("hidden")
        break
      case "ContractEnd":
        this.contractEndFieldsTarget.classList.remove("hidden")
        break
      case "BidNotice":
        this.bidNoticeFieldsTarget.classList.remove("hidden")
        break
      case "BidComplete":
        this.bidCompleteFieldsTarget.classList.remove("hidden")
        break
      case "BidResult":
        this.bidResultsFieldsTarget.classList.remove("hidden")
        break
    }
  }
}
