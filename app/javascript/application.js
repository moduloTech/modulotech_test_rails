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


// TO FIX LATER
    // your code here
    let flatpickrTriggerList = Array.from(document.querySelectorAll('[data-controller="flatpickr"]'));
    flatpickrTriggerList.map(function (ca) {
        const end_date = document.querySelector('#end_date');
        const totalPrice = document.querySelector('#totalprice');
        const roomPrice = document.querySelector('#room-price').dataset.price;
        const bookingForm = document.getElementById('booking-form-div');
        const bookings = JSON.parse(bookingForm.dataset.bookings);
        if(bookings) {
            new flatpickr(ca, {
                dateFormat: "Y-m-d H:i",
                "disable": bookings
                // more options available on the documentation!
              })
            }
        });