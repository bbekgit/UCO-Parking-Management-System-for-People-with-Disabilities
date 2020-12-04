<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>UCO Locations</title>
</head>
<body>
	<div class="row">
		<form
			action="${pageContext.servletContext.contextPath}/change/status/submit">
			<input type="hidden" s name="locationId" id="locationId"
				value="${location.locationId}">
			<div class="col-lg-12 ">
				<div class="col-lg-6">Location Name:-</div>
				<div class="col-lg-6">
					<input style="" type="text"
						value="${location.name}" readonly="readonly">
				</div>
			</div>
			<div class="col-lg-12 ">
				<div class="col-lg-6">Assigned To:-</div>
				<div class="col-lg-6">
					<input type="text" name="assignedToName" id="asigne"
						value="${location.assignedToName}">
				</div>
			</div>
			<div class="col-lg-12 ">
				<div class="col-lg-6">Status:-</div>
				<div class="col-lg-6">
					<select style="width: 16%;" name="status"
						id="status">
						<option value="1">Hold</option>
						<option value="2">Available</option>
						<option value="3">Not Available</option>
					</select>
				</div>
			</div>
			<br> <input type="submit">
		</form>
	</div>
</body>
</html>