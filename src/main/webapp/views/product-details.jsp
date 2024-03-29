<%@page import="in.chandan.main.entity.Review"%>
<%@page import="in.chandan.main.entity.CartItem"%>
<%@page import="java.util.List"%>
<%@page import="in.chandan.main.entity.User"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="in.chandan.main.entity.Product"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="/script.js"></script>
</head>
<body>
	<%
	User user = (User) session.getAttribute("currentUser");
	Product product = (Product) session.getAttribute("clicked_product");
	NumberFormat formatter = NumberFormat.getIntegerInstance();
	String price = formatter.format(product.getPrice());
	String mrp = formatter.format(product.getMrp());
	%>

	<jsp:include page="header.jsp"></jsp:include>

	<div class="d-flex px-5 py-4 justify-content-around align-items-start" style="margin: auto; width: 90%; min-height: 100vh;">
		<div
			style="width: 35%; height : 500px; ; position: sticky; top: 100px;">
			<img src="<%=product.getImageAdd()%>"
				style="object-fit: cover; height: 400px; width: 100%; border-radius: 5px;"
				alt="">
			<div class="d-flex justify-content-between mt-3">
				<%
				boolean isInCart = false;
				List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItemList");
				if (user != null && user.getCart() != null && cartItems != null) {

					for (int j = 0; j < cartItems.size(); j++) {
						if (cartItems.get(j).getProduct().getName().equals(product.getName())) {

					isInCart = true;
					break;
						}
					}
				}
				if (isInCart) {
				%>
				<a href='/cart'><button class="btn btn-primary"
						style="width: 180px; height: 50px;">Go to Cart</button></a>
				<%
				} else {
				%>
				<%
				if (user == null) {
				%>
				<a href="/login"><button class="btn btn-primary"
						style="width: 180px; height: 50px;">Add to Cart</button></a>
				<%
				} else {
				%>
				<button onclick="addToCart(<%=product.getId()%>)"
					class="btn btn-primary" style="width: 180px; height: 50px;">Add
					to Cart</button>
				<%
				}
				%>

				<%
				}
				%>
				<button class="btn btn-danger" style="width: 180px;">Buy
					Now</button>
			</div>
		</div>
		<div class="p-2" style="width: 45%;">
			<p style="font-size: x-large;"><%=product.getName()%></p>
			<h2 class="d-inline my-2">
				&#8377;<%=price%></h2>
			<p class="text-decoration-line-through">
				&#8377;<%=mrp%></p>
			<h5>Available Offers</h5>
			<p>Bank Offer 10% instant discount on ICICI Bank Credit Cards</p>
			<p>Get &#8377;125* instant discount for the 1st Order using</p>
			<p>10% Instant Discount on BOBCARD Transactions, up to &#8377;500
				on orders of &#8377;5,000 and above</p>
			<hr>

			<p style="font-size: larger; width: 70px; text-align: center;"
				class="rounded-pill border my-2 d-inline px-2 py-1">
				<%=product.getOverallRating()%>
				<i class="fa fa-star"></i>
			</p>
			<span style="font-size: larger;" class="ms-1"><%=product.getReviews().size()%>
				reviews and ratings</span>
			<hr>
			<%
			List<Review> reviews = product.getReviews();
			%>
			<%
			for (Review review : reviews) {
			%>
			<p>
				<span class="rounded-pill border border-2 my-2 d-inline px-2 py-1"><%=review.getRating()%>
					<i class="fa fa-star"></i></span> <span class="ms-2"><%=review.getReview()%></span>
			</p>
			<p><%=review.getUser().getFname()%>
				(Certified Buyer)
			</p>
			<hr>
			<%
			}
			%>
		</div>
	</div>

</body>
</html>