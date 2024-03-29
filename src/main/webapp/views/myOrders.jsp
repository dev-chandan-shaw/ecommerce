<%@page import="in.chandan.main.entity.Product"%>
<%@page import="in.chandan.main.entity.OrderItem"%>
<%@page import="in.chandan.main.entity.MyOrder"%>
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

	<jsp:include page="header.jsp"></jsp:include>
	<section>
		<div class="container pt-3">
			<div class="row">
				<div class="col-lg-4"
					style="height: 450px; position: sticky; top: 80px;">
					<div class="card">
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
						<p class="text-center mb-0" style="cursor: pointer;">
							<a href="/addresses" class="text-decoration-none text-dark">Manage
								Address</a>
						</p>
						<hr>
						<p class="text-center mb-0" style="cursor: pointer; font-weight: 700">
							<a href="/myorders" class="text-decoration-none">
								My orders <i class="fas fa-arrow-circle-right"></i></a>
						</p>
						<hr>
					</div>
				</div>
				<div class="col-lg-8" id="address-section">
					<%
					List<MyOrder> myOrderList = (List<MyOrder>) session.getAttribute("myOrderList");
					%>
					<%
					if (myOrderList.size() > 0) {
						for (int i = myOrderList.size() - 1; i > 0; i--) {
							MyOrder myOrder = myOrderList.get(i);
					%>
					<div class="card mb-4">
						<%
						List<OrderItem> orderItemList = myOrder.getOrderItems();
						%>
						<%
						for (OrderItem orderItem : orderItemList) {
							Product product = orderItem.getProduct();
						%>
						<div class="card-body">
							<div class="row align-items-center">
								<div class="col-md-2">
									<img src="<%=product.getImageAdd()%>"
										style="height: 100px; width: 70px; object-fit: cover;"
										class="img-fluid" alt="Generic placeholder image">
								</div>
								<div class="col-md-3 d-flex justify-content-center">
									<div>
										<p class="lead fw-normal mb-0"><%=product.getName()%></p>
									</div>
								</div>

								<div class="col-md-2 d-flex justify-content-center">
									<div>
										<p class="lead fw-normal mb-0"><%=orderItem.getQuantity()%></p>
									</div>
								</div>
								<div class="col-md-2 d-flex justify-content-center">
									<div>
										<p class="lead fw-normal mb-0">
											&#8377;<%=orderItem.getQuantity() * product.getPrice()%></p>
									</div>
								</div>

								<div class="col-md-3 d-flex justify-content-center">

									<div>
										<a class="text-primary text-decoration-none"
											style="cursor: pointer;"
											href="/review_and_rating/<%=product.getId()%>"><i
											class="fa fa-star me-1"></i> Rate & Review</a>
									</div>
								</div>
							</div>
						</div>
						<%
						}
						%>
					</div>
					<%
					}
					%>
					<%
					} else {
					%>
					<img alt="" style="height: 430px; width: 100%; object-fit: cover;"
						src="https://i.pinimg.com/originals/6f/fd/64/6ffd64c5366898c59bbc91d9aec935c3.png">
					<%
					}
					%>
				</div>
			</div>
		</div>
	</section>

</body>
</html>