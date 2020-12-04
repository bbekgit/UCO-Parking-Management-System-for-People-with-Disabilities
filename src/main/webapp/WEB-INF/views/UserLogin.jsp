<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<span style="color:red">${msg}</span>
	<div class="row">
	<form action="${pageContext.servletContext.contextPath}/login/user/submit">
			<div class="col-lg-12 ">
				<div class="col-lg-6">User Id:- </div><div class="col-lg-6"><input type="text" name="userId"></div></div>
			<div class="col-lg-12 "><div class="col-lg-6">User Name:- </div><div class="col-lg-6"><input type="text" name="userName"></div></div>
			<input type="submit" name="submit">
	</form>
	</div>
</body>
</html>