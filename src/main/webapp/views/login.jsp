<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class= "container p-3 w-50 d-flex justify-content-center align-content-center flex-column border border-dark rounded-4 mt-5">
		<form action="login" method= "post" class= "d-flex justify-content-center flex-column">
		  <div class="row mb-3">
		    <label for="inputEmail3" class="col-sm-2 col-form-label">Email</label>
		    <div class="col-sm-10">
		      <input type="email" class="form-control"  name = "email" required="required"/>
		    </div>
		  </div>
		  
		  <div class="row mb-3">
		    <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" name = "password" required="required"/>
		    </div>
		  </div>
		  <button type="submit" class="btn btn-primary w-20">Login</button>
		</form>
		<h5 class = "d-flex justify-content-center">Did Not have Account!!! <a href ="/signup" class="text-decoration-none" >SignUp</a></h5>
	</div>
	
</body>
</html>