<%@page import="org.springframework.ui.Model"%>
<%@page import="in.chandan.main.entity.Review"%>
<%@page import="in.chandan.main.entity.Product"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Review</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style type="text/css">
* {
  margin: 0;
  padding : 0;
  box-sizing: border-box;
}

.container {
  width: 70%;
  margin: auto;
  border: 2px solid gainsboro;
  padding: 10px;
  position: absolute;
  top: 55%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.rating {
  display: inline-block;
}

.rating input {
  display: none;
}

.rating label {
  float: right;
  cursor: pointer;
  font-size: 30px;
  color: #ddd;
}

input:not(:checked) ~ label:hover ~ label,
input:not(:checked) ~ label:hover {
 color: #fd4;
}

input:checked ~ label {
  color : #fd4;
}

#review {
  height: 200px;
  width: 100%;
  resize: none;
  outline: none;
  padding: 10px;
  border : 1px solid gray;
}
	
</style>
</head>
<body>
	<%Product product = (Product) session.getAttribute("reviewProduct");%>
	<%Review review = (Review) session.getAttribute("previousReview"); %>
	<%String reviewMsg = ""; %>
	<%if (review != null) reviewMsg += review.getReview();%>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
	    <div class="d-flex justify-content-between">
	      <div>
	        <h5 id="ratingMessage">Rate this product</h5>
	        <div class="rating">
	          <input type="radio" name="rate" id = "rate-5" onclick="addRating(5)">
	          <label for="rate-5" class = "fas fa-star"></label>
	          <input type="radio" name="rate" id = "rate-4" onclick="addRating(4)">
	          <label for="rate-4" class = "fas fa-star"></label>
	          <input type="radio" name="rate" id = "rate-3" onclick="addRating(3)">
	          <label for="rate-3" class = "fas fa-star" ></label>
	          <input type="radio" name="rate" id = "rate-2" onclick="addRating(2)">
	          <label for="rate-2" class = "fas fa-star" ></label>
	          <input type="radio" name="rate" id = "rate-1" onclick="addRating(1)">
	          <label for="rate-1" class = "fas fa-star"></label>
	        </div>
	      </div>
	      <div class="d-flex align-items-center">
	        <p><%=product.getName()%> (<%=product.getOverallRating()%> <i class = "fas fa-star"></i>)</p>
	        <img src="<%=product.getImageAdd()%>" style="height: 50px; width: 50px; object-fit: cover; border-radius: 5px;" alt="">
	      </div>
	    </div>
	    
	    <hr>
	
	    <h5 id="ratingMessage">Review this product</h5>
	    <textarea id="review" class = "mb-2" placeholder="Write your review" aria-label="mytextarea" required="required"><%=reviewMsg%></textarea>
	    <div class="d-flex justify-content-end mt-1">
	      <button class = "btn btn-primary" onClick = "submitReview(<%=product.getId()%>)">Submit</button>
	    </div>
	    
	  </div>
	  
<script>
	

	<% if (review != null) {%>
		function setRating(rating) {
		    var radioButton = document.getElementById('rate-' + rating);
		    if (radioButton) {
		        radioButton.checked = true;
		    }
		}
		
		setRating(<%=review.getRating()%>);
	<%}%>
		
	

    var rating;
    function addRating(myRating) {
        rating = myRating;
    }
    function submitReview(productId) {
      let review = document.getElementById('review').value
      if (rating == undefined) {
        rating = 0;
      }
      fetch('http://localhost:8080/submitReview', {
		    method: 'POST',
		    headers: {
		        'Content-Type': 'application/json'
		    },
		    body: JSON.stringify({
		    	rating : rating,
		    	review : review,
		    	productId : productId
		    })
		}).then(data => {
			console.log(data)
			console.log("review submitted");
			return data.json()
		}).then(data => {
			console.log(data)
			Swal.fire("Thank You very much for your review :)");
		})
		.catch(error => console.error('Error:', error));
    }
 </script>
</body>
</html>