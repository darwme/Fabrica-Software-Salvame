let map;
let marker;
const distanciaLugar = document.querySelector('.mostrar-ubicacion__distancia p');
const lat = document.querySelector('.mostrar-ubicacion__titulo .lat');
const lng = document.querySelector('.mostrar-ubicacion__titulo .lng');
let userCoords = { lat: 0, lng: 0 };

const capturarButton = document.querySelector('.btn-capturar');

function iniciarMap() {
    const coord = { lat: -12.054357, lng: -77.084362 }; // Coordenadas de UNMSM

    // Inicializar mapa
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 5,
        center: coord,
    });

    // Inicializar marker
    marker = new google.maps.Marker({
        position: coord,
        map: map,
        draggable: true,
    });

    map.addListener('click', (evt) => {
        console.log(evt);
        marker.setPosition(evt.latLng);
        updateMarkerPosition(marker.getPosition());
    });

    capturarButton.addEventListener('click', () => {
        const currentPosition = marker.getPosition(); // Posición actual del marker "Para Cueto"
        console.log('Current position:', currentPosition);
        updateMarkerPosition(currentPosition);
        calculateDistance(currentPosition);
    });

    updateMarkerPosition(coord);
}

// Actualiza las coordenadas en pantalla
function updateMarkerPosition(latLng) {
    lat.textContent = `Lat: ${latLng.lat().toFixed(6)}`;
    lng.textContent = `Lng: ${latLng.lng().toFixed(6)}`;
}

// Calcula la distancia entre el marker y la ubicación actual del usuario
function calculateDistance() {
    const distancia = google.maps.geometry.spherical.computeDistanceBetween(
        new google.maps.LatLng(marker.getPosition().lat(), marker.getPosition().lng()),
        new google.maps.LatLng(userCoords.lat, userCoords.lng)
    );
    distanciaLugar.textContent = `${(distancia / 1000).toFixed(2)} km`;
}

// Obtener la ubucación actual del usuario
if (navigator.geolocation) {

    navigator.geolocation.getCurrentPosition(({ coords: { latitude, longitude } }) => {
        userCoords = {
            lat: latitude,
            lng: longitude
        };
    });

} else {
    console.log('Geolocation is not supported for this Browser/OS version yet.');
}