import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    console.log(1)
    new flatpickr(this.element, {
      enableTime: true
      // more options available on the documentation!
    });
  }
}