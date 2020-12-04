
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	
	<h2 align="center">Login As</h2><br><br>	
	
	
	<div class="col-lg-12" style="top:30%;">
    <div class="row">
        <div class="col-xs-6">
        <form action="${pageContext.request.contextPath}/login/admin" class="inline">
		    <button class="btn  btn-sx btn-primary" style="float: right;width: 50%;height: 20%;" type="submit" id="add"><span style="font-size: xx-large;">Admin</span></button>
		</form>
        </div>
        <div class="col-xs-6">
		<form action="${pageContext.request.contextPath}/login/user" class="inline">
		    <button class="btn btn-success btn-sx submit-button "  style="width: 50%;height: 20%;" type="submit" id="view"><span style="font-size: xx-large;">User</span></button>
		</form>            
        </div>
    </div>
</div>
	
</body>
</html>