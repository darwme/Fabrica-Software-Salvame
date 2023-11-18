const button = document.querySelector('.mostrar-ubicacion');
const lat = document.querySelector('.mostrar-ubicacion__titulo .lat');
const lng = document.querySelector('.mostrar-ubicacion__titulo .lng');
const distanciaLugar = document.querySelector('.mostrar-ubicacion__distancia p');

let coord = { lat: -12.054357, lng: -77.084362 }; // Coordenadas de UNMSM
let map;
let marker;

lat.textContent = `Lat: ${coord.lat}`;
lng.textContent = `Lng: ${coord.lng}`;

function iniciarMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 5,
    center: coord
  });

  marker = new google.maps.Marker({
    position: coord,
    map: map
  });

  button.addEventListener('click', () => {
    if (navigator.geolocation) {
      console.log('Geolocation is supported!');
      navigator.geolocation.getCurrentPosition(({ coords: { latitude, longitude } }) => {
        const userCoords = {
          lat: latitude,
          lng: longitude
        };

        console.log(userCoords);

        if (marker) {
          marker.setPosition(userCoords);
          map.setCenter(userCoords);
          map.setZoom(15);

          // Calcula la distancia entre la ubicación actual y las coordenadas del lugar
          const distancia = google.maps.geometry.spherical.computeDistanceBetween(
            new google.maps.LatLng(coord.lat, coord.lng),
            new google.maps.LatLng(userCoords.lat, userCoords.lng)
          );
          console.log(distancia);

          distanciaLugar.textContent = `${(distancia / 1000).toFixed(2)} km`;

          // nombreLugar.textContent = `Lat: ${userCoords.lat} Lng: ${userCoords.lng}`;

          lat.textContent = `Lat: ${userCoords.lat}`;
          lng.textContent = `Lng: ${userCoords.lng}`;

        } else {
          console.log('El marcador no está definido.');
        }

      }, () => {
        console.log('Error in the geolocation service.');
      });

    } else {
      console.log('Geolocation is not supported for this Browser/OS version yet.');
    }
  });
}
