<%@page import="in.chandan.main.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css"
	integrity="sha512-4wfcoXlib1Aq0mUtsLLM74SZtmB73VHTafZAvxIp/Wk9u1PpIsrfmTvK0+yKetghCL8SHlZbMyEcV8Z21v42UQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Pacifico&family=Rubik+Distressed&family=Satisfy&family=Syne+Mono&display=swap')
	;
#search-result {
	max-height: 250px;
	overflow-y : scroll;
}
</style>

<script src="script.js"></script>

<link rel="stylesheet" href="style.css">
</head>
<body>
	<%
	User user = (User) session.getAttribute("currentUser");
	Integer item = (Integer) session.getAttribute("items");
	if (item == null)
		item = 0;
	%>
	<nav class="position-sticky top-0 border-2"
		style="background-color: black; color: white;z-index: 999">
		<div class="d-flex justify-content-center  align-items-center p-2"
			style="gap: 70px;">
			<div style="cursor: pointer;">
				<a class="navbar-brand my-1" href="/home"
					class="text-decoration-none"
					style="font-family: 'Rubik Distressed', cursive; color: white; font-size: xx-large;">D_BAZAAR</a>
			</div>
			<div>
				<div class="d-flex align-items-center">
					<input type="text" id="search-bar" placeholder="Search products, brands and more" class="form-control position-relative"
						style="width: 600px;" onkeyup="searchProduct()"> <i
						class="fas fa-search p-2 rounded-end" style="cursor: pointer;"></i>
				</div>
				<div id="search-result" class = "position-absolute bg-light text-black" style="width: 600px; border-radius: 8px"></div>
			</div>

			<%
			if (user != null) {
			%>
			<div class="dropdown" style="cursor: pointer; color: white;">
				<i class="fas fa-user"></i><span class=" ms-1 dropdown-toggle"
					id="dropdownMenuButton1" data-bs-toggle="dropdown"
					aria-expanded="false"><%=user.getFname()%></span>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					<li><a class="dropdown-item" href="/profile">My Profile</a></li>
					<li><a class="dropdown-item" href="/myorders">My orders</a></li>
					<li><a class="dropdown-item" href="/logout">Logout</a></li>
				</ul>
			</div>
			<%
			} else {
			%>

			<div style="cursor: pointer; color: white;">
				<a href="/login" class="text-decoration-none text-light"> <i
					class="fas fa-user"></i><span class="me-1 ms-2">Login</span></a>
			</div>
			<%
			}
			%>
			<%
			if (user == null) {
			%>
			<div style="cursor: pointer; color: white;">
				<a href="/login" class="text-decoration-none text-light"><i
					class="fas fa-shopping-cart" style="cursor: pointer;"></i><span
					class="ms-2 position-relative">Cart</span></a>
			</div>
			<%
			} else {
			%>
			<div style="cursor: pointer; color: white;" class="position-relative">
				<a href="/cart" class="text-decoration-none text-light"><i
					class="fas fa-shopping-cart" style="cursor: pointer;"></i><span
					class="ms-2">Cart<span
						class="position-absolute top-20 start-100 translate-middle rounded-pill badge bg-danger">
							<%=item%></span>
				</span></a>
			</div>
			<%
			}
			%>

		</div>
	</nav>
</body>
</html>