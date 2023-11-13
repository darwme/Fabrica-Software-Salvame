const button = document.querySelector('.mostrar-ubicacion');

function iniciarMap() {

  let coord = { lat: -34.5956145, lng: -58.4431949 };

  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 10,
    center: coord
  });

  let marker = new google.maps.Marker({
    position: coord,
    map: map
  });

  button.addEventListener('click', () => {


    if (navigator.geolocation) {

      console.log('Geolocation is supported!');
      navigator.geolocation.getCurrentPosition(({ coords: { latitude, longitude } }) => {

        const cords = {
          lat: latitude,
          lng: longitude
        };


        console.log(cords);
        var marker = new google.maps.Marker({
          position: cords,
          map: map
        });

        map.setCenter(cords);
        map.setZoom(15);
        marker.setPosition(cords);

      }, () => {
        console.log('Error in the geolocation service.');
      });

    }
    else {

      console.log('Geolocation is not supported for this Browser/OS version yet.');

    }
  });

}