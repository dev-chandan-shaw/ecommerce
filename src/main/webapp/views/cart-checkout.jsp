<%@page import="com.razorpay.Order"%>
<%@page import="in.chandan.main.entity.Address"%>
<%@page import="java.util.List"%>
<%@page import="in.chandan.main.entity.User"%>
<%@page import="in.chandan.main.entity.Product"%>
<%@page import="in.chandan.main.entity.CartItem"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shawping | Checkout</title>
</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>
	<%
	User user = (User) session.getAttribute("currentUser");
	List<Address> addressList = (List<Address>) session.getAttribute("addressList");
	List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItemList");
	%>
	<div class="container my-1 py-5">

		<!--Section: Design Block-->
		<section>
			<div class="row">

				<div class="col-md-4 mb-4 position-static">
					<div class="card mb-4">
						<div class="card-header py-3">
							<h5 class="mb-0 text-font"><%=cartItems.size()%>
								item(s)
							</h5>
						</div>
						<div class="card-body">
							<hr>
							<%
							int totalAmount = 0;
							for (int i = cartItems.size() - 1; i >= 0; i--) {
								CartItem cartItem = cartItems.get(i);
								Product product = cartItem.getProduct();
								totalAmount += cartItem.getPrice();
							%>

							<div class="row">
								<div class="col-md-4">
									<img src="<%=product.getImageAdd()%>" class="rounded-3"
										style="width: 100px;" alt="Blue Jeans Jacket" />
								</div>
								<div class="col-md-6 ms-3">
									<span class="mb-0 text-price">&#8377;<%=cartItem.getPrice()%></span>
									<p class="mb-0 text-descriptions"><%=product.getName()%>
									</p>
									<p class="text-descriptions mt-0">
										Qty:<span class="text-descriptions fw-bold"><%=cartItem.getQuantity()%></span>
									</p>
								</div>
							</div>
							<hr>
							<%
							}
							%>
							<hr>
							<div class="card-footer mt-4">
								<ul class="list-group list-group-flush">
									<li
										class="list-group-item d-flex justify-content-between align-items-center px-0 fw-bold text-uppercase">
										Total to pay <span>&#8377;<%=totalAmount%></span>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-8" id="edit_form">
					<div class="card mb-4 px-3">
						<div class="card-body" id="addressForm">
							<div class="row">
								<div class="col-sm-12 border border-1 p-3 my-4"
									style="cursor: pointer;">
									<p class="mb-0 text-primary" onclick="openAddressForm()">+
										Add a new address</p>
								</div>
							</div>
							
							<div class="card">
								<%
								for (Address address : addressList) {
								%>
								<div class="card-body">

									<div class="row" id="<%=address.getId()%>">
										<div class="col-sm-10">
											<input type="radio" name="addressId"
												value="<%=address.getId()%>" /> <span
												class="text-muted mb-0"><%=address.toString()%></span>
										</div>

										<div class="col-sm-2" style="cursor: pointer;">
											<button class="btn btn-primary"
												onclick="updateAddress(<%=address.getId()%>,'<%=address.getHouseNo()%>','<%=address.getLocality()%>','<%=address.getDistrict()%>', '<%=address.getPincode()%>',  '<%=address.getState()%>')">Edit</button>
										</div>
									</div>

								</div>
								<%
								}
								%>
							</div>
							<div class="d-flex justify-content-center p-3">
								<button class="btn btn-primary" id="rzp-button">Place
									Order</button>
							</div>
						</div>
					</div>
				</div>
		</section>

		<!--Section: Design Block-->
		<%
		Order order = (Order) session.getAttribute("order");
		%>
	</div>


	<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
	<script type="text/javascript">
	let response = <%=order%>
	console.log(response)
		var options = {
	    "key": "rzp_test_z5yVWa8008Y4t2", // Enter the Key ID generated from the Dashboard
	    "amount": response.amount, 
	    "currency": "INR",
	    "name": "Shawping",
	    "description": "Confirm Your payment",
	    "image": "https://banner2.cleanpng.com/20180329/zue/kisspng-computer-icons-user-profile-person-5abd85306ff7f7.0592226715223698404586.jpg",
	    "order_id": response.id, 
	    "handler": function (response){
	    	console.log(response.razorpay_payment_id);
	    	console.log(response.razorpay_order_id);
	    	updateOrder(response.razorpay_payment_id, response.razorpay_order_id, "paid");
	    },
	    "prefill": {
	        "name": "",
	        "email": "",
	        "contact": ""
	    },
	    "notes": {
	        "address": "Razorpay Corporate Office"
	    },
	    "theme": {
	        "color": "#3399cc"
	    }
	};
	var rzp1 = new Razorpay(options);
	rzp1.on('payment.failed', function (response){
	        alert(response.error.code);
	        alert(response.error.description);
	        alert(response.error.source);
	        alert(response.error.step);
	        alert(response.error.reason);
	        alert(response.error.metadata.order_id);
	        alert(response.error.metadata.payment_id);
	});

	document.getElementById('rzp-button').onclick = function(e){
		if (addressId == null) {
			alert ("please select a deivery address!!")
		} else {
			rzp1.open();
		}
	    
	}

	function gotoConfirmationPage() {
		const newDiv = document.createElement('div');
		window.location.href = "http://localhost:8080/confirmation_page";
	}

	function updateOrder(payment_id, order_id, status) {
		const orderDetails = {
			    payment_id: payment_id,
			    order_id: order_id,
			    status: status,
			    addressId : addressId
			};
		fetch('http://localhost:8080/updateOrder', {
		    method: 'POST',
		    headers: {
		        'Content-Type': 'application/json'
		    },
		    body: JSON.stringify(orderDetails)
		}).then(data => {
			console.log(data);
			gotoConfirmationPage();
		})
		.catch(error => console.error('Error:', error));
	}
		
	var radioInputs = document.querySelectorAll('input[type="radio"]');
	var addressId;
    radioInputs.forEach(function(input) {
        input.addEventListener("change", function() {
        	var selectedValue = document.querySelector('input[name="addressId"]:checked').value;
            console.log("Selected option:", selectedValue);
            addressId = selectedValue;
            console.log(addressId)
          // You can perform further actions based on the selected value here
        });
      });
	</script>
</body>
</html>