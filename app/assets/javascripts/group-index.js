function myDistance(myLat, myLng, lat,  lng) {
  var R = 6371e3;
  var angle1 = myLat * Math.PI / 180;
  var angle2 = lat * Math.PI / 180;
  var difference1 = (lat-myLat) * Math.PI / 180;
  var difference2 = (lng-myLng) * Math.PI / 180;
  var a = Math.sin(difference1 / 2) * Math.sin(difference1 / 2) +
    Math.cos(angle1) * Math.cos(angle2) *
    Math.sin(difference2 / 2) * Math.sin(difference2 / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  return R * c / 1000;
}

document.addEventListener('turbolinks:load', function() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var myLat = position.coords.latitude;
      var myLng = position.coords.longitude;
      $('#all-group').find('.group').each(function() {
        var lat = $(this).data('lat');
        var lng = $(this).data('lng');
        var distance = myDistance(myLat, myLng, lat, lng);
        $(this).attr('data-distance', distance);
        $(this).closest('.group').find('.distance').html(distance.toFixed(2));
      });
      var $allgroup = $('#all-group'), $groups = $allgroup.find('.group');
      [].sort.call($groups, function(a, b) {
        return $(a).attr('data-distance') - $(b).attr('data-distance');
      });
      $groups.each(function(){
        $allgroup.append(this);
      });
    });
  }
});
