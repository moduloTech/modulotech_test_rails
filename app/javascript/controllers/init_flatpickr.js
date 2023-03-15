import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    new flatpickr(this.element, {
      // more options available on the documentation!
    });
  }
}
