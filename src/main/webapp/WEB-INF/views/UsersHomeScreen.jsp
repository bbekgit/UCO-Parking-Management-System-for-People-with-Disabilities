<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDDyJz8kc674wqabDEk1_mfBvwUA1FsSq4&callback=initMap" async defer></script>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

<script type="text/javascript">
	var map;
	var directionDisplay;
	var directionsService;
	var lat = 0;
	var lng = 0;
	
	function initMap() {
	  map = new google.maps.Map(document.getElementById('map'), {
	    center: {lat: 35.657647, lng: -97.472580},
	    zoom: 8
	  });
	}
	var toLoc = "";
	 function initGeolocation(tLoc)
     {
        if( navigator.geolocation )
        {
           // Call getCurrentPosition with success and failure callbacks
           navigator.geolocation.getCurrentPosition( success, fail );
           toLoc = tLoc;
        }
        else
        {
           alert("Sorry, your browser does not support geolocation services.");
        }
     }

     function success(position)
     {
    	  lng =  position.coords.longitude;
    	  lat = position.coords.latitude;
    	  
    	 drawPath( lat, lng, toLoc.split(",")[0], toLoc.split(",")[1]);
     }

     function fail()
     {
        // Could not obtain location
     }
     
	$( document ).ready(function() {
		$("select").select2();
		var locJson  = ${locationsJson};
		
	    $('#submit').click(function(){
	    	$("#checkOut").removeAttr("disabled"); 
	    	var toLoc = $('#toLoc').val();
    		if(toLoc == null){
    			alert("Please pick a location!!");
    			return false;
    		}
    		var currLat = "";
    		initGeolocation(toLoc);  
    		
	    });
	    
	    

	    $('#checkOut').click(function(){
	    	 window.open("${pageContext.servletContext.contextPath}/checkout/location?name=${name}");    		
	    });
	    
	    
	    
	});
	
    	function pinSymbol(color) {
    	  return {
    	    path: 'M 0,0 C -2,-20 -10,-22 -10,-30 A 10,10 0 1,1 10,-30 C 10,-22 2,-20 0,0 z',
    	    fillColor: color,
    	    fillOpacity: 1,
    	    strokeColor: '#000',
    	    strokeWeight: 2,
    	    scale: 1
    	  };
    	}
    	
    	
	function drawPath(fromLat, fromLng, toLat, toLng){
//         alert(fromLat +" "+fromLng +" "+toLat+" "+toLng);
        directionsDisplay = new google.maps.DirectionsRenderer();
        directionsService = new google.maps.DirectionsService();
        
        directionsDisplay.setMap(map);

        var start = fromLat+','+fromLng;
        var end = toLat+', '+toLng;
        var request = {
          origin:start, 
          destination:end,
          travelMode: google.maps.DirectionsTravelMode.DRIVING 
        };
        directionsService.route(request, function(response, status) {
          if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
          }
        });
	}

</script>

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

<div>
<br>
	<span style="color: green;">${msg}</span>
	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<span style="font-size: 18px;">Pick a Location:-</span> <select id="toLoc">
			<option selected="selected">--select--</option>
			<c:forEach items="${locations}" var="location" varStatus="loop">
				<option value="${location.lat},${location.lng}">${location.name}</option>
			</c:forEach>
		</select> <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<button id="submit">Submit</button>
<%-- 		<form action="${pageContext.servletContext.contextPath}/checkout/location?name=${name}"> --%>
			<button id="checkOut" class="btn-danger" type="submit" style="float:right;" disabled="disabled" >CheckOut</button>
<%-- 		</form> --%>
	</div>
</div>
<br>  <br>
  <div id="map" style="height: 80%;"></div>
