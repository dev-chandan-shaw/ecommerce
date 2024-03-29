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
	<%User user = (User) session.getAttribute("currentUser"); %>

	<jsp:include page="header.jsp"></jsp:include>
	<section style="background-color: #eee;">
		<div class="container pt-3">

			<div class="row">
				<div class="col-lg-4">
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
						<p class="text-center mb-0" style="cursor: pointer; font-weight: 700">
							<a href="/profile" class="text-decoration-none">Profile <i class="fas fa-arrow-circle-right"></i></a>
						</p>
						<hr>
						<p class="text-center mb-0" style="cursor: pointer;">
							<a href="/addresses"
								class="text-decoration-none text-dark">Manage Address</a>
						</p>
						<hr>
						<p class="text-center mb-0" style="cursor: pointer;">
							<a href="myorders"
								class="text-decoration-none text-dark"> My orders</a>
						</p>
						<hr>
					</div>
				</div>

				<div class="col-lg-8" id="profile">
					<div class="card p-5">
						<div class="card-body">
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<p class="mb-0">Full Name</p>
								</div>
								<div class="col-sm-9">
									<p class="text-muted mb-0"><%=user.getFname()%>
										<%= user.getLname() %></p>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<p class="mb-0">Gender</p>
								</div>
								<div class="col-sm-9">
									<p class="text-muted mb-0"><%=user.getGender()%></p>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<p class="mb-0">Email</p>
								</div>
								<div class="col-sm-9">
									<p class="text-muted mb-0"><%=user.getEmail()%></p>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<p class="mb-0">Phone</p>
								</div>
								<div class="col-sm-9">
									<p class="text-muted mb-0"><%=user.getPhone()%></p>
								</div>
							</div>
							<hr>


							<div class="d-flex justify-content-center col-sm-12">
								<button class="btn btn-primary" onclick="updateProfile(event)"
									id="profile_update">Update Profile</button>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>

	</section>
	<script>
   
    function updateProfile(event) {
      const profile = document.getElementById("profile");
      profile.innerHTML =` 
      <div class="card mb-4">
            <div class="card-body">
              
      <form action="updateProfile" method="POST">
        <div class="row my-3">
          <div class="col-sm-2">
            First Name
          </div>
          <div class="col-sm-10">
            <input type="text" class="form-control" name = "fname" value="<%=user.getFname()%>">
          </div>
        </div>
        <div class="row my-3">
          <div class="col-sm-2">
            Last Name
          </div>
          <div class="col-sm-10">
            <input type="text" class="form-control" name = "lname" value="<%=user.getLname()%>">
          </div>
        </div>
        <div class="row my-3">
          <div class="col-sm-2">
            Email
          </div>
          <div class="col-sm-10">
            <input type="text" class="form-control" name = "email" value="<%=user.getEmail()%>">
          </div>
        </div>
        <div class="row my-3">
          <div class="col-sm-2">
            Phone
          </div>
          <div class="col-sm-10">
          	<input type="text" class="form-control" name = "phone" value = "<%=user.getPhone()%>">
          </div>
        </div>
        <div class = "d-flex col-sm-12  justify-content-center">
          <input type="submit" class = "btn btn-primary" value = "Confirm Change"/> 
        </div>
      </form>
      </div>
      </div>
      `
      event.target.classList.add("d-none")
    }
    

  </script>
</body>
</html>