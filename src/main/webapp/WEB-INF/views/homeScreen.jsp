<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDDyJz8kc674wqabDEk1_mfBvwUA1FsSq4&callback=initMap" async defer></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta charset="ISO-8859-1">
<title>UCO Blind Parking</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
#id{
    height: 80% !important;
    overflow: scroll !important; 
  
}

body, html {
  height: 80%;
  width: 100%;
}

div#content {
  width: 100%; height: 100%;
}
</style>
<script>

	$(document).ready(function(){
		
		var locJson  = ${locationsJson};
// 		alert(${locationsJson});
		if(locJson != null 
				&& locJson!= undefined 
				&& locJson != ""){
			 var mapOptions = {
		             zoom: 16,
		             center: {lat: parseFloat(35.657647), lng: parseFloat(-97.472580)}
		           };
		           map = new google.maps.Map(document.getElementById('map'),
		               mapOptions);
			for(var i=0; i< locJson.length; i++){
				showLocation(locJson[i].lat, locJson[i].lng, locJson[i].name, map);
			}
		}
	})
	
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
      
     function showLocation(latt, lngg, name, map){

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
    	google.maps.event.addDomListener(window, 'load', initMap);
 	
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
</head>
<body>
<br>
	<input type="hidden" name="empId" value="${empId}">
	<span style="color:green">${msg}</span>
	
	<a href="${pageContext.servletContext.contextPath}/add/location"
			style="flaot: right"><button class="btn btn-info" style="float: right; margin-left: 20px;margin-right: 20px;">Add Location</button></a>
	<a href="${pageContext.servletContext.contextPath}/search/location"
			style="flaot: right"><button class="btn btn-info" style="float: right;">Search Location</button></a><br>
	<br><br>
	<div id="map" style="height:100%;width:100%;margin:0 auto;"></div>
	
	<br><br>
	<div class="container">
		<h2>Parking Locations</h2><br><br>
		<table class="table">
			<thead>
				<tr>
					<th>S.No</th>
					<th>Location Name</th>
					<th>Status</th>
					<th>Alloted To</th>
					<th>Modified Time</th>
					<th>Change Status</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${locations}" var="location" varStatus="loop">
				        <tr>
				        	<td>${loop.count}</td>
							<td>${location.name}</td>
							<c:if test="${location.status == 1}">
								<td><span style="color:grey;">Hold</span></td>
							</c:if>
							<c:if test="${location.status == 2}">
								<td><span style="color:green;">Available</span></td>
							</c:if>
							<c:if test="${location.status == 3}">
								<td><span style="color:red;">Not Available</span></td>
							</c:if>
							<td>${location.assignedToName}</td>
							<td>${location.modifiedDate}</td>
							<td><a href="${pageContext.servletContext.contextPath}/change/status?locationId=${location.locationId}"><i style="font-size:24px" class="fa">&#xf044;</i></a></td>
						</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

<br><br><br><br>

	
</body>
</html>