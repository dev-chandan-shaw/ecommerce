<%@page import="java.util.List"%>
<%@page import="in.chandan.main.entity.Address"%>
<%@page import="in.chandan.main.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

</head>
<body style="background-color: #eee;">
	<%
	User user = (User) session.getAttribute("currentUser");
	%>

	<%
	List<Address> addressList = (List<Address>) session.getAttribute("addressList");
	%>

	<jsp:include page="header.jsp"></jsp:include>
	<section>
		<div class="container pt-3">
			<div class="row">
				<div class="col-lg-4" style="height: 450px; position: sticky; top : 80px;">
					<div class="card mb-4">
						<div class="card-body text-center">
							<img
								src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp"
								alt="avatar" class="rounded-circle img-fluid"
								style="width: 150px;">
							<h5 class="mt-2 mb-1">
								Welcome
								<%=user.getFname()%></h5>
						</div>
						<hr>
						<p class="text-center mb-0" style="cursor: pointer;">
							<a href="/profile" class="text-decoration-none text-dark">Profile</a>
						</p>
						<hr>
						<p class="text-center mb-0" style="cursor: pointer; font-weight: 700">
							<a href="/addresses" class="text-decoration-none">Manage
								Address <i class="fas fa-arrow-circle-right"></i></a>
						</p>
						<hr>
						<p class="text-center mb-0" style="cursor: pointer;">
							<a href="/myorders" class="text-decoration-none text-dark">
								My orders</a>
						</p>
						<hr>
					</div>
				</div>

				<div class="col-lg-8">
					<div class="card mb-4 px-3" id="addressForm">
						<div class="card-body" >
							<div class="row">
								<div class="col-sm-12 border border-1 p-3 my-4"
									style="cursor: pointer;">
									<p class="mb-0 text-primary" onclick="openAddressForm()">+
										Add a new address</p>
								</div>
							</div>

								<div id="edit_form">
									<%
									for (Address address : addressList) {
									%>
									<div class="row d-flex py-3 align-items-center border border-1 my-1" id="<%=address.getId()%>">
										<div class="col-sm-8">
											<p class="text-muted mb-0"><%=address.toString()%></p>
										</div>
										<div class="col-sm-2" style="cursor: pointer;">
											<form action="deleteAddress" method="post" onsubmit="return confirmAddressDelete()">
												<input type="hidden" value="<%=address.getId()%>"
													name="addressId"> <input type="submit"
													class="btn btn-danger" value="Delete">
											</form>
										</div>
										<div class="col-sm-2" style="cursor: pointer;">
											<button class="btn btn-primary"
												onclick="updateAddress(<%=address.getId()%>,'<%=address.getHouseNo()%>','<%=address.getLocality()%>','<%=address.getDistrict()%>','<%=address.getPincode()%>', '<%=address.getState()%>')">Edit</button>
										</div>
									</div>
									<%
									}
									%>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
	document.addEventListener("click", function(event) {
	    if (event.target !== localityInput && !localityInput.contains(event.target)) {
	    	allLocalityDiv.innerHTML = ""
	    }
	});
	</script>
</body>
</html>