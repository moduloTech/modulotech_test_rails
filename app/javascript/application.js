// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "flatpickr"
import "stimulus-flatpickr"
// Initialize popovers
let popoverTriggerList = Array.from(document.querySelectorAll('[data-bs-toggle="popover"]'));
popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
});

document.addEventListener("DOMContentLoaded", () => {
    flatpickr("#start_date", {
      mode: "range",
      dateFormat: "Y-m-d H:i",
      onChange: [function(selectedDates){
        const dateArr = selectedDates.map(date => this.formatDate(date, "Y-m-d"))
        const difference = Date.parse(dateArr[1]) - Date.parse(dateArr[0])
        const totalDays = Math.ceil(difference / (1000 * 3600 * 24));
        console.log(totalDays + ' days')
    }]
    });
  });

