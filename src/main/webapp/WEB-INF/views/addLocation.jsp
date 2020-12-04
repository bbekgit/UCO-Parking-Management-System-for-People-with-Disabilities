	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDDyJz8kc674wqabDEk1_mfBvwUA1FsSq4&callback=initMap" async defer></script>
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
	
 <style>
   #map {
     height: 100%;
   }
   html, body {
     height: 100%;
     margin: 0;
     padding: 0;
   }
 </style>
  <br>
  <div class="row">
  	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12">
	  	<form:form action="${pageContext.request.contextPath}/add/location/submit" onsubmit="return onSubmit();" modelAttribute="location" method="POST">
		  	<input type="hidden" id="lat" name="lat" value="0">
		  	<input type="hidden" id="lng" name="lng" value="0">
		  	<input type="hidden" id="latLng" name="latLng" value="0">
	  		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-xs-2">
	  			<span style="font-size: 18px;">Location Name:-</span> 
	  		</div>
	  		<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-4">
	  			<input class="form-control"name="name" id="locationName" autocomplete="off">
	  		</div>
	  		<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-4">
	  			<input style="" class="btn btn-success" type="submit" value="submit">
	  		</div>
	  	</form:form>
  	</div>
  </div>
  <br>  
  <div id="map" style="height: 80%;"></div>
    
<script>
      var map;
      var lat = 0;
      var lng = 0;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
        	center: {lat: 35.657647, lng: -97.472580},
          zoom: 16
        });
        
        google.maps.event.addListener(map, 'click', function(event) {
			lat =  event.latLng.lat();
			lng =  event.latLng.lng();
 	  		map = new google.maps.Map(document.getElementById('map'), {
 	          center: {lat: event.latLng.lat(), lng: event.latLng.lng()},
 	          zoom: 18
 	        });
        	placeMarker(event.latLng);
     	   		
     	});

     	function placeMarker(location) {
     	    var marker = new google.maps.Marker({
     	        position: location, 
     	        map: map
     	    });
     	}
      }
      
      function onSubmit(){
    	  if(lat == 0 || lng == 0){
    		  alert("Please pick the location!!");
    		  return false;
    	  }
    	  $("#lat").val(lat);
    	  $("#lng").val(lng);
    	  $("#latLng").val(lat+"|"+lng);
    	  
      }
      
    </script>