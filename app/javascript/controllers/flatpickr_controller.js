import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
const END_PICKER_DAY_INTERVAL = 1
const END_PICKER_MONTH_LIMIT = 6

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["startDate", "endDate"]

  connect() {

    // actual not available dates
    const reservations = JSON.parse(this.element.dataset.reservations)
    const reservationsDisableDates = reservations.map(reservation => ({
      from: reservation[0], // booking[0] is the start_date
      to: reservation[1] // booking[1] is the end_date
    }))

    const today = new Date();
    // default start_date picker
    const startDatePicker = new Date(today)
    // default end_date picker starts 1 days after start_date
    const endDatePicker = new Date(startDatePicker)
    endDatePicker.setDate(startDatePicker.getDate() + END_PICKER_DAY_INTERVAL)
    // limit date picker to 6 months from start_date picker
    const limitDatePicker = new Date(startDatePicker)
    limitDatePicker.setMonth(startDatePicker.getMonth() + END_PICKER_MONTH_LIMIT)

    // Ensure startDatePicker is not in any disabled range
    this.adjustDatesForDisabledRanges(startDatePicker, endDatePicker, reservationsDisableDates)

    flatpickr(this.startDateTarget, {
      defaultDate: startDatePicker,
      minDate: startDatePicker,
      maxDate: limitDatePicker,
      disable: reservationsDisableDates,
      dateFormat: "Y-m-d",
    })

    flatpickr(this.endDateTarget, {
      defaultDate: endDatePicker,
      minDate: endDatePicker,
      maxDate: limitDatePicker,
      disable: reservationsDisableDates,
      dateFormat: "Y-m-d",
    })
  }

  adjustDatesForDisabledRanges(startDate, endDate, disabledDates) {
    disabledDates.forEach(date => {
      const fromDate = new Date(date.from)
      const toDate = new Date(date.to)

      if ((startDate >= fromDate && startDate <= toDate) || (endDate >= fromDate && endDate <= toDate)) {
        startDate.setDate(toDate.getDate() + 1)
        endDate.setDate(startDate.getDate() + END_PICKER_DAY_INTERVAL)
      }
    });
  }
}
