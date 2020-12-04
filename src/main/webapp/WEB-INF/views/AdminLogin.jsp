<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<span style="color: red">${msg}</span>

	<div class="row">
		<form
			action="${pageContext.servletContext.contextPath}/login/admin/submit">
			<div class="col-lg-12 ">
				<div class="col-lg-6">Admin Name:-</div>
				<div class="col-lg-6">
					<input type="text" name="name">
				</div>
			</div>
			<div class="col-lg-12" >
				<div class="col-xs-6">Password:-</div>
				<div class="col-xs-6">
				<input type="password" name="pwd">
				</div>
			</div>
			<div class="col-lg-12" >
			  <input type="submit" name="submit">
			</div>
		</form>
	</div>

</body>
</html>