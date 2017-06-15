var I18n, google, i;
$('#group-not-found').on('click', initMap());

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

function initMap() {
  navigator.geolocation.getCurrentPosition(function(position) {
    var myPosition = {
      lat: position.coords.latitude,
      lng: position.coords.longitude
    };

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 13,
      center: myPosition
    });

    var infoWindow = new google.maps.InfoWindow({
      content: I18n.t('marker_here'),
      disableAutoPan: true
    });

    var myMarker = new google.maps.Marker({
      position: myPosition,
      map: map,
      draggable: true,
      icon: 'http://maps.google.com/mapfiles/kml/paddle/purple-stars.png'
    });

    var circle = new google.maps.Circle({
      map: map,
      radius: 3000,
      fillColor: '#99c0ff',
      strokeColor: '#4785e8',
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillOpacity: 0.35,
      draggable: true,
      zIndex: -1
    });

    circle.bindTo('center', myMarker, 'position');
    infoWindow.open(map, myMarker);

    var bounds = circle.getBounds();

    var markers = [];
    var title, count, size, category, time, address, content, avatar;

    var findplace = new google.maps.places.Autocomplete($('#find-place')[0]);

    var directionsService = new google.maps.DirectionsService;
    var directionsDisplay = new google.maps.DirectionsRenderer({
      suppressMarkers: true,
      preserveViewport: true
    });

    directionsDisplay.setMap(map);

    findplace.addListener('place_changed', function(){
      var place = findplace.getPlace();
      if (place.address_components) {
        address = [
          (place.address_components[0] && place.
            address_components[0].short_name || ''),
          (place.address_components[1] && place.
            address_components[1].short_name || ''),
          (place.address_components[2] && place.
            address_components[2].short_name || '')
        ].join(' ');
      }
      myMarker.setVisible(false);
      map.setCenter(place.geometry.location);
      map.setZoom(13);
      myMarker.setPosition(place.geometry.location);
      myMarker.setVisible(true);
    });



    $('#all-group').find('.group').each(function(){
      var groupPosition = new google.maps.LatLng($(this).data('lat'),
        $(this).data('lng'));
      var groupMarker = new google.maps.Marker({
        position: groupPosition,
        map: map,
        visible: false,
        group_id: $(this).data('id')
      });

      if (bounds.contains(groupPosition)) {
        groupMarker.setVisible(true);
      }

      markers.push(groupMarker);

      $(this).on('click', function(){
        for (i=0; i < markers.length; i++) {
          markers[i].setVisible(false);
          if (markers[i].group_id == $(this).data('id')) {
            markers[i].setVisible(true);
            google.maps.event.trigger(markers[i], 'click');
          }
        }
      });
    });


    circle.addListener('bounds_changed', showGroupBounds);
    circle.addListener('bounds_changed', function(){
      directionsDisplay.setMap(null);
    });
    function showGroupBounds(){
      infoWindow.close();
      bounds = circle.getBounds();
      for (i = 0; i < markers.length; i++) {
        if (bounds.contains(markers[i].getPosition())) {
          markers[i].setVisible(true);
        } else {
          markers[i].setVisible(false);
        }
      }
    }


    function displayRoute(){
      directionsService.route({
        origin: myMarker.getPosition(),
        destination: this.getPosition(),
        travelMode: 'DRIVING'
      }, function(response, status) {
        if (status == 'OK') {
          directionsDisplay.setMap(map);
          directionsDisplay.setDirections(response);
        } else {
          window.alert(I18n.t('group.direction_error') + status);
        }
      });
    }

    function displayInfo(){
      var $group = $('#group-' + this.group_id);
      avatar = $group.data('avatar');
      title = $group.data('title');
      category = $group.data('category');
      count = $group.data('count');
      size = $group.data('size');
      time = $group.data('time');
      address = $group.data('address');
      content = '<div class="info-window">' +
      '<div class="info-avatar-container"><img src="' + avatar +
      '" class="info-avatar" /></div>' +
      '<div class="title"><h2>' + title + '</h2></div>' +
      '<div class="content">' +
      '<h4>' + category + '</h4>' +
      '<p>' + I18n.t('group.time') + time + '</p>' +
      '<p>' + I18n.t('group.address') + address + '</p>' +
      '<p>' + I18n.t('group.count') + count + '/' + size +'</p>'+
      '<div></div></div>';
      infoWindow.close();
      infoWindow.setContent(content);
      infoWindow.open(map, this);
    }

    function closeInfo(){
      infoWindow.close();
    }

    function hoverToGroup(){
      var group = $('#group-' + this.group_id);
      $('html, body').animate({
        scrollTop: group.offset().top - 82
      }, 500);
      group.animate({ backgroundColor: '#aa0000' },
       1000, function() {
         $(this).animate({ backgroundColor: '#fff' }, 1000);
       });
    }

    for (i = 0; i < markers.length; i++) {
      markers[i].addListener('click', displayRoute);
      markers[i].addListener('click', hoverToGroup);
      markers[i].addListener('mouseover', displayInfo);
      markers[i].addListener('mouseout', closeInfo);
    }


    $('#nearby-slider').on('mousemove', function(){
      $('#nearby-number').val($(this).val());
      circle.setRadius(parseFloat($(this).val())*1000);
    });

    $('#nearby-number').on('change', function() {
      $('#nearby-slider').val($(this).val());
      circle.setRadius(parseFloat($(this).val())*1000);
    });
  });

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

  $('#sideNavOpen').on('click', function(){
    $('#map-helper').css({'width' : '250px'});
  });
  $('#sideNavClose').on('click', function(){
    $('#map-helper').css({'width' : '0px'});
  });
}
