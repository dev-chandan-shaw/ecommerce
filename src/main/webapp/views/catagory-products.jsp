<%@page import="in.chandan.main.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="in.chandan.main.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.card img {
	object-fit: cover;
	width: 100%;
	height: 250px;
}

.card {
	overflow: hidden;
}

.card img:hover {
	transform: scale(1.1);
	transition: transform .5s;
}

.card img:not(:hover) {
	transform: scale(1);
	transition: transform .5s;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="py-1">
		<!-- Single item -->
		<div class="container">

			<%
			NumberFormat formatter = NumberFormat.getIntegerInstance();

			// Format the number using DecimalFormat

			@SuppressWarnings("unchecked")
			List<Product> productList = (List<Product>) session.getAttribute("catagoryProducts");
			%>
			<%
			for (int i = 0; i < productList.size();) {
				int col = 0;
			%>
			<div class="row my-2">
				<%
				while (col < 4 && i < productList.size()) {
					Product product = productList.get(i);
					String price = formatter.format(product.getPrice());
					String mrp = formatter.format(product.getMrp());
				%>
				<div class="col-lg-3">
					<div class="card">
						<a href = "/product/<%=product.getName()%>/"><img src="<%=product.getImageAdd()%>" class="card-img-top"
							alt="Waterfall" /></a>
						<div class="card-body">
							<h5 class="card-title"><%=product.getName()%></h5>
							<h5 class="cart-title">
								&#8377;<%=price%><span class="text-decoration-line-through ms-1"
									style="font-size: medium; color: rgb(170, 163, 163);">&#8377;<%=mrp%></span>
							</h5>
						</div>
					</div>
				</div>
				<%
				i++;
				col++;
				}
				%>
			</div>
			<%
			}
			%>
		</div>
	</div>

</body>
</html>