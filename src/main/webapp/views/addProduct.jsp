      <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
      	pageEncoding="ISO-8859-1"%>
      <!DOCTYPE html>
      <html>
      <head>
      <meta charset="ISO-8859-1">
      <title>Product Adding Page</title>
      <script src="https://code.jquery.com/jquery-3.7.1.min.js"
      	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
      	crossorigin="anonymous"></script>
      <link
      	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      	rel="stylesheet"
      	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      	crossorigin="anonymous">
      </head>
      <body>

      	<div class= "container px-5 py-2 my-2 border border-1">

      		<form action="add_product" method="post">
      			<div class="mb-3">
      				<label for="exampleFormControlInput1" class="form-label">Name</label>
      				<input type="text" class="form-control" name="name"
      					placeholder="Enter Product name">
      			</div>
      			<div class="mb-3">
      				<label for="exampleFormControlInput1" class="form-label">MRP</label>
      				<input type="text" class="form-control" name="mrp"
      					placeholder="Enter product's MRP">
      			</div>
      			<div class="mb-3">
      				<label for="exampleFormControlInput1" class="form-label">Price</label>
      				<input type="text" class="form-control" name="price"
      					placeholder="Enter final price">
      			</div>
      			<div class="mb-3">
      				<label for="exampleFormControlInput1" class="form-label">Image
      					Address</label> <input type="text" class="form-control" name="image_add"
      					placeholder="Enter your product image address">
      			</div>
      			<div class="mb-3">
      				<label for="exampleFormControlInput1" class="form-label">Stock</label>
      				<input type="text" class="form-control" name="stock"
      					placeholder="Enter product's stock">
      			</div>
      			<div class="mb-3">
      				<label for="exampleFormControlInput1" class="form-label">Catagory</label>
      				<input type="text" class="form-control" name="catagory"
      					placeholder="Enter product's catagory">
      			</div>

      			<input type="submit" class="btn btn-primary" value="Add Product" />
      		</form>
      	</div>
      </body>
      </html>
