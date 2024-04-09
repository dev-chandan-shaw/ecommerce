<%@page import="in.chandan.main.entity.User"%>
<%@page import="in.chandan.main.entity.CartItem"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart Items</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
*{
 padding: 0;
 margin: 0;
 box-sizing: border-box;
}

.button-style {
	width : 30px;
    outline: none;
    border-radius: 5px;
    color: #fff;
  background-color: #007bff;
  border: 2px solid #007bff;
  border-radius: 5px;
  cursor: pointer;
}

@media (min-width: 1025px) {
.h-custom {
height: 100vh !important;
}
}

.card-registration .select-input.form-control[readonly]:not([disabled]) {
font-size: 1rem;
line-height: 2.15;
padding-left: .75em;
padding-right: .75em;
}

.card-registration .select-arrow {
top: 13px;
}

.bg-grey {
background-color: #eae8e8;
}

@media (min-width: 992px) {
.card-registration-2 .bg-grey {
border-top-right-radius: 16px;
border-bottom-right-radius: 16px;
}
}

@media (max-width: 991px) {
.card-registration-2 .bg-grey {
border-bottom-left-radius: 16px;
border-bottom-right-radius: 16px;
}
}

</style>
</head>
<body style="background-color: #d2c9ff;">
<jsp:include page="header.jsp"></jsp:include>
<%
		User user =(User) session.getAttribute("currentUser"); 
		List<CartItem> list = (List<CartItem>) session.getAttribute("cartItemList");
%>

<div id="custom-message"></div>
<section class="h-100 h-custom">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12">
        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
          <div class="card-body p-0">
            <div class="row g-0">
              <div class="col-lg-8">
                <div class="p-5">
                  <div class="d-flex justify-content-between align-items-center mb-5">
                    <h1 class="fw-bold mb-0 text-black">Shopping Cart</h1>
                    <h6 class="mb-0 text-muted"><%=list.size()%> items</h6>
                  </div>
                  <hr class="my-4">

	<%		
		List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItemList");
		int totalAmount = 0;
		for (int i=cartItems.size()-1; i>=0; i--) {
			CartItem cartItem = cartItems.get(i);
			int cartItemPrice = cartItem.getQuantity()*cartItem.getProduct().getPrice();
			totalAmount += cartItemPrice;
			
	%>
                  <div class="row mb-4 d-flex justify-content-between align-items-center">
                    <div class="col-md-2 col-lg-2 col-xl-2">
                      <img
                        src="<%=cartItem.getProduct().getImageAdd()%>"
                        class="img-fluid rounded-3" alt="Cotton T-shirt">
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-3">
                      <h6 class="text-muted"><%=cartItem.getProduct().getName()%></h6>
                      <!--  <h6 class="text-black mb-0">Cotton T-shirt</h6> -->
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-2 d-flex align-items-center">
                     <div>
			        	<input type = "hidden" name = "product_name" value = "<%=cartItem.getProduct().getName()%>"/>
			        	<input type = "hidden" name = "cart_item_id" value = "<%=cartItem.getId()%>"/>
			        	<div class="input-group">
			        	  <input type = "submit" class = "button-style" value = "&#8722;" onClick = "updateQuantity(<%=i%>,<%=cartItem.getId()%>,'decrement')"/>
	                      <input type="text" id = "<%=i%>" class="form-control form-control-sm form-control-rounded quantity text-center" name = "quantity" aria-label="Recipient's username" aria-describedby="button-addon2" value = "<%=cartItem.getQuantity()%>" readonly/>
						  <input type = "submit" class = "button-style" onClick = "updateQuantity(<%=i%>,<%=cartItem.getId()%>,'increment')" value = "+"/>
						</div>
			        </div>
                    </div>
                    <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                      <h6 class="mb-0" id = "<%=cartItem.getId()%>">&#8377;<%=cartItemPrice%></h6>
                    </div>
                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
				     <button onClick = "remove(event,<%=cartItem.getId()%>)" class="btn btn-danger"><i class="far fa-trash-alt"></i></button>
                    </div>
                  </div>
                 <hr class="my-4">
			<%}%>

                </div>
              </div>
              <div class="col-lg-4 bg-grey">
                <div class="p-5">
                  <h3 class="fw-bold mb-5 mt-2 pt-1">Summary</h3>
                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-5">
                    <h5 class="text-uppercase">Items</h5>
                    <h5><%=cartItems.size()%></h5>
                  </div>

                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-5">
                    <h5 class="text-uppercase">Total price</h5>
                    <h5 id ="totalAmount">&#8377;<%=totalAmount%></h5>
                  </div>

                  <button type="button" onclick="checkout()" id = "rzp-button1" class="btn btn-dark btn-block btn-lg"
                    data-mdb-ripple-color="dark">Checkout</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<script type="text/javascript">
function checkout() {
	var cartItems = [
        <% for (CartItem item : cartItems) { %>
            '<%= item.getId() %>',
        <% } %>
    ];
	let totalAmount = <%=totalAmount%>
	console.log(totalAmount)
	console.log(cartItems)
	var requestBody = {
			totalAmount : totalAmount,
			cartItemsId : cartItems
	}
	console.log(JSON.stringify(requestBody));
	fetch('http://localhost:8080/confirm-checkout', {
		method: 'POST',
		headers: {
			'Content-Type' : 'application/json'
		},
		body : JSON.stringify(requestBody)
	}).then(data => {
		window.location.href = "http://localhost:8080/place-order"
		return data.json()
	}).then (data => {
		console.log(data)
	}).catch(error => console.error("Error : ",error));
}
</script>

</body>
</html>