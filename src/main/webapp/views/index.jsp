<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="in.chandan.main.entity.CartItem"%>
<%@page import="in.chandan.main.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="in.chandan.main.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>D_BAZAAR | Home</title>
<style type="text/css">
@import
url('https://fonts.googleapis.com/css2?family=Arvo:ital,wght@0,400;0,700;1,400;1,700&family=Croissant+One&family=Dancing+Script:wght@500&family=Farsan&family=Lobster+Two&family=Poor+Story&family=Tilt+Prism&display=swap')

* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.card {
	overflow: hidden;
	position: absolute;
}

.card img {
	object-fit: cover;
	width: 100%;
	height: 200px;
	filter: brightness(50%);
	border-radius: 12px;
}

.card img:hover {
	transform: scale(1.1);
	transition: transform .5s;
}

.card img:not(:hover) {
	transform: scale(1);
	transition: transform .5s;
}

#hero {
	height: 400px;
	background-image:
		url("https://images.unsplash.com/photo-1500917293891-ef795e70e1f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80");
	background-position: center;
	background-size: cover;
	width: 100%;
	object-fit: cover;
	margin-bottom: 20px;
}

.content {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-family: 'Satisfy', cursive;
	height: 400px;
	padding: 50px;
}

#hero .content .left-content .heading {
	font-size: 50px;
}

#hero .content .right-content .heading {
	font-size: 50px;
}

.catagories {
	padding: 25px;
	border: 1px solid black;
	border-radius: 12px;
	width: 85%;
	margin: auto;
}

.col img:not(:hover) {
	transform: scale(1);
	transition: transform .5s;
}

.col {
margin: 0px;
}

.row {
	display: flex;
	justify-content: space-between;
}

.card p {
	position: absolute;
	bottom: 0px;
	left: 20px;
	color: white;
}
</style>

</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div id="hero" class="scale-up-center">
		<div class="content">
			<div class="left-content">
				<h1 class="heading">Special offers on</h1>
				<h1 class="heading">All products</h1>
				<h1 style="color: red" class="shake-horizontal heading">Hurry
					Up</h1>
			</div>
			<div class="right-content">
				<h1 class="heading">Summer Sale is</h1>
				<h1 class="heading">Live Now</h1>
				<h1 style="color: red" class="shake-horizontal heading">50% off</h1>
			</div>
		</div>
	</div>
	<h2 class="text-center" style="font-family:"Arvo", serif;">Catagories</h2>
	<div class="catagories">
		<div class="row" style="margin-bottom: 20px;">
			<div class="col">
				<div class="card" style="border-radius: 12px;">
					<a href="/catagories/mens"><img
						src="https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg?size=626&ext=jpg&ga=GA1.1.1395880969.1710201600&semt=sph"
						alt=""></a>
					<p>Mens</p>
				</div>
			</div>
			<div class="col">
				<div class="card" style="border-radius: 12px;">
					<a href="/catagories/womens"><img
						src="https://img.freepik.com/free-photo/portrait-happy-lady-sunglasses-standing-with-colorful-shopping-bags-hands-pink-background-young-woman-standing-white-shirt-denim-shorts_574295-1182.jpg"
						alt=""></a>
					<p>Womens</p>
				</div>
			</div>
			<div class="col">
				<div class="card" style="border-radius: 12px;">

					<a href="/catagories/kids"><img
						src="https://www.go4india.net/images/kids-clothes-online-india.jpg"
						alt=""></a>
					<p>Kids</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<div class="card" style="border-radius: 12px;">
					<a href="/catagories/electronics"><img
						src="https://f.hubspotusercontent30.net/hubfs/5624788/Electronic%20Online%20Header-01.jpg"
						alt=""></a>
					<p>Electronics</p>
				</div>
			</div>

			<div class="col">
				<div class="card" style="border-radius: 12px;">
					<a href="/catagories/sports and outdoors"><img
						src="https://content.jdmagicbox.com/comp/delhi/z4/011pxx11.xx11.230407171652.a4z4/catalogue/ghulati-sports-emporium-rohini-delhi-sports-goods-dealers-cxo0g71uo8.jpg"
						alt=""></a>
					<p>Sports and Outdoors</p>
				</div>
			</div>
			<div class="col">
				<div class="card" style="border-radius: 12px;">
					<a href="/catagories/books and media"><img
						src="https://www.mindstirmedia.com/wp-content/uploads/2020/01/self-publishing-platforms-books.jpg"
						alt=""></a>
					<p>Books and Media</p>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>