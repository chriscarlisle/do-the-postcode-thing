import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
    this.element.innerHTML = "";
  }

  handleKeyup(e) {
    if (e.code == "Escape") {
      this.close()
    }
  }
}
