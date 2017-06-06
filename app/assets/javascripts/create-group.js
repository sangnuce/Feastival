var google;
window.onload = initAutocomplete();
function initAutocomplete() {
  var input = $('.place-input')[0];
  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    var address = $('.place-input')[0].value;
    if (place.address_components) {
      [
        (place.address_components[0] && place.
          address_components[0].short_name || ''),
        (place.address_components[1] && place.
          address_components[1].short_name || ''),
        (place.address_components[2] && place.
          address_components[2].short_name || '')
      ].joins;
    }
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({'address': address}, function(results, status) {
      if (status == 'OK') {
        $('.latitude')[0].value = results[0].geometry.location.lat();
        $('.longitude')[0].value = results[0].geometry.location.lng();
      }
    });
  });
}
