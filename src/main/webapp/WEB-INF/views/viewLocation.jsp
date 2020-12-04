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
	
	$( document ).ready(function() {
		$("select").select2();
		$('#singleDiv').show();
		$('#fromToDiv').hide();
		var locJson  = ${locationsJson};
// 		alert(${locationsJson})
	    $(".searchType").change(function(){
	    	var id = $("input[name=searchType]:checked").val();
			if(id == 'single'){
				$('#singleDiv').show();
				$('#fromToDiv').hide();
			}	
			else if(id == 'fromTo'){
				$('#singleDiv').hide();
				$('#fromToDiv').show();
			}
			else if(id == 'available')
			{
				$('#singleDiv').hide();
				$('#fromToDiv').hide();
// 				alert(locJson);
				if(locJson != null 
						&& locJson!= undefined 
						&& locJson != ""){
					 var mapOptions = {
				             zoom: 18,
				             center: {lat: parseFloat(35.657647), lng: parseFloat(-97.472580)}
				      };
				      map = new google.maps.Map(document.getElementById('map'),
				               mapOptions);
					for(var i=0; i< locJson.length; i++){
// 						alert(locJson);
						showLocationForAvailable(locJson[i].lat, locJson[i].lng, locJson[i].name, map);
					}
				}
			}
	    });
	    
	    $('.submit').click(function(){
	    	var type = $("input[name=searchType]:checked").val();
// 	    	alert("type = "+type);
	    	if(type == 'single'){
	    		var loc = $('#loc').val();
	    		if(loc == "" || loc == null || loc == ''){
	    			alert("Please select location!!");
	    			return false;
	    		}
	    		showLocation(loc.split(",")[0], loc.split(",")[1]);
	    	}
	    	else{
	    		var fromLoc = $('#fromLoc').val();
	    		var toLoc = $('#toLoc').val();
	    		if(fromLoc == "" || toLoc == null){
	    			alert("Please pick from and to locations!!");
	    			return false;
	    		}
	    		drawPath(fromLoc.split(",")[0], fromLoc.split(",")[1], toLoc.split(",")[0], toLoc.split(",")[1]);
	    	}
	    });
	});
	
	function showLocation(latt, lngg){
    	 var mapOptions = {
            zoom: 18,
            center: {lat: parseFloat(latt), lng: parseFloat(lngg)}
          };
          map = new google.maps.Map(document.getElementById('map'),
              mapOptions);

          var marker = new google.maps.Marker({
            position: {lat: parseFloat(latt), lng: parseFloat(lngg)},
            map: map
          });
		}
	
	 function showLocationForAvailable(latt, lngg, name, map){
     	

           var marker = new google.maps.Marker({
             position: {lat: parseFloat(latt), lng: parseFloat(lngg)},
             map: map,
             draggable: true,
             raiseOnDrag: true,
             labelContent: name,
             labelAnchor: new google.maps.Point(latt, lngg),
             labelClass: "labels", // the CSS class for the label
             labelInBackground: false,
             icon: pinSymbol('red'),
           });

        	var iw = new google.maps.InfoWindow({
       	    	content: name
       	    });
       	  	google.maps.event.addListener(marker, "click", function(e) {
       	    	iw.open(map, this);
       	  	});
 		}
     

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
//     	google.maps.event.addDomListener(window, 'load', initMap);
    	
	function drawPath(fromLat, fromLng, toLat, toLng){
        
        directionsDisplay = new google.maps.DirectionsRenderer();
        directionsService = new google.maps.DirectionsService();
        var myOptions = {
          mapTypeId: google.maps.MapTypeId.ROADMAP,
        }
        map = new google.maps.Map(document.getElementById("map"), myOptions);
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
  <br>
	<div class="row">
		<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-6">
			<input type="radio" class="searchType" name="searchType" value="available"> Show Available
			<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<input type="radio" class="searchType" name="searchType" value="single" checked="checked"> Search Location
			<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
<!-- 			<input type="radio" class="searchType" name="searchType" value="fromTo"> Search Directions -->
		</div>
	</div>  
	<br>
  <div class="row">
  
   	<div id="singleDiv">
 		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-xs-3">
 			<span style="font-size: 18px;">Location Name:-</span>
 		</div>
 		<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-6">
 			<select id="loc">
 				<option selected="selected">--select--</option>
 				<c:forEach items="${locations}" var="location" varStatus="loop">
 					<option value="${location.lat},${location.lng}">${location.name}</option>
 				</c:forEach>
 			</select>
 			<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
 			<button class="submit" id="submit">Submit</button>
 		</div>
  	</div>
  	
  	<div id="fromToDiv">
 		<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-xs-3">
 			<span style="font-size: 18px;">From:-</span>
 			<select id="fromLoc">
 				<option selected="selected">--select--</option>
 				<c:forEach items="${locations}" var="location" varStatus="loop">
 					<option value="${location.lat},${location.lng}">${location.name}</option>
 				</c:forEach>
 			</select>
 		</div>
 		<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-6">
 			<span style="font-size: 18px;">To:-</span>
 			<select id="toLoc">
 				<option selected="selected">--select--</option>
 				<c:forEach items="${locations}" var="location" varStatus="loop">
 					<option value="${location.lat},${location.lng}">${location.name}</option>
 				</c:forEach>
 			</select>
 			<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
 			<button class="submit" >Submit</button>
 		</div>
  	</div>
  </div>
  <br>  
  <div id="map" style="height: 80%;"></div>
