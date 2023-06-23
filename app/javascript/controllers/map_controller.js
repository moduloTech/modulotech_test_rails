import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var queryString = window.location.search;
    var urlParams = new URLSearchParams(queryString);
    var popup = L.popup();

    var lat = urlParams.get('latitude');
    var lng = urlParams.get('longitude');

    var map = L.map('map').setView([lat || 51.505, lng || -0.09], 10);

    if (lat && lng) {
      setPopup(L.latLng(lat, lng))
    }

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    function onMapClick(e) {
      setPopup(e.latlng)

      document.getElementById('latitude').value = e.latlng.lat;
      document.getElementById('longitude').value = e.latlng.lng;
    }

    function setPopup(coordinates) {
      popup
          .setLatLng(coordinates)
          .setContent("Your chosen location is here")
          .openOn(map);
    }

    map.on('click', onMapClick);
  }
}
