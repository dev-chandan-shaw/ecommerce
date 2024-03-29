/**
 * 
 */

console.log("hello world")
// add to cart start here
function addToCart(productId) {
	console.log(productId)
	fetch('http://localhost:8080/add_to_cart', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			productId: productId
		})
	}).then(res => {
		return res.json()
	}).then(res => {
		window.location.href = "http://localhost:8080/cart"
		console.log(res);
	}).catch(error => console.error("Error : ", error));
}
// updating quantity of the cartItem product
function updateQuantity(quantityId, cartItemId, status) {
	var quantity = document.getElementById(quantityId).value;

	// Construct the request body as a JSON object
	var requestBody = {
		quantity: quantity,
		cartItemId: cartItemId,
		status: status
	};

	fetch('http://localhost:8080/updateQuantity', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(requestBody)
	}).then(data => {
		console.log(data)
		console.log("Form submitted");
		return data.json()
	}).then(data => {
		localStorage.setItem("data", JSON.stringify(data));
		return data;
	}).then(data => {
		document.getElementById(quantityId).value = data.quantity
		document.getElementById(cartItemId).textContent = '\u20B9' + data.amount
		location.reload()
	}).catch(error => console.error('Error:', error));
}

let storedDataString = localStorage.getItem("data")
let data = JSON.parse(storedDataString);
console.log(data)
if (data != null) {
	setTimeout(function() {
		const Toast = Swal.mixin({
			toast: true,
			position: "bottom",
			showConfirmButton: false,
			timer: 2000,
			timerProgressBar: true,
			didOpen: (toast) => {
				toast.onmouseenter = Swal.stopTimer;
				toast.onmouseleave = Swal.resumeTimer;
			}
		});
		Toast.fire({
			title: data.msg
		})
	}, 400);
}

localStorage.removeItem("data");

//function to remove item from cart
function remove(event, cartItemId) {
	Swal.fire({
		title: "Are you sure?",
		text: "You want to remove this item!",
		showCancelButton: true,
		confirmButtonColor: "#3085d6",
		cancelButtonColor: "#d33",
		confirmButtonText: "Yes, remove it!"
	}).then((result) => {
		if (result.isConfirmed) {
			deleteCartItem(cartItemId)
		}
	});
}

function deleteCartItem(cartItemId) {
	fetch('http://localhost:8080/delete-cart-item', {
		method: 'DELETE',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({cartItemId : cartItemId})
	}).then(res =>{
		window.location.href = "http://localhost:8080/cart";
		console.log(res)
	}).catch(error => console.error("Error is : ", error));
}


function updateAddress(addressId, houseno, locality, district, pincode, state) {
	const address = document.getElementById("edit_form");
	address.innerHTML = `
      <div class="card">
	      <div class="card-body">
		      <form action="update_address_from_profile" method="POST">
		      		<div class="row my-2">
						<div class="col-sm-12">
							<label>Pincode*</label> <input type="text"
								class="form-control" value = '${pincode}' name="pincode" onkeyup="getDetails()"
								id="pincode" autocomplete="new-password" required>
						</div>
					</div>
					<div class="row my-2">
						<div class="col-sm-6">
							<label>House No./Street*</label> <input value = '${houseno}' type="text"
								class="form-control" name="houseno" required>
						</div>
						<div class="col-sm-6">
							<label>Locality*</label> <input onkeyup = filterLocality() type="text" id="locality"
								class="form-control position-relative" value = '${locality}' name="locality"
								autocomplete="off" required>
							<div id="result-box"
								class="position-absolute" style="width: 300px"></div>
						</div>

					</div>
					<div class="row my-2">
						<div class="col-sm-6">
							<label>City/District*</label> <input type="text"
								class="form-control bg-light" id="district" value = '${district}' name="district"
								required readonly>
						</div>
						<div class="col-sm-6">
							<label>State*</label> <input type="text"
								class="form-control bg-light" id="state" value = '${state}' name="state"
								required readonly>
						</div>
						<input type = "hidden" name = "addressId" value = '${addressId}'/>
					</div>
					<div class="d-flex col-sm-12  justify-content-around mt-3">
						<input type="submit" class="btn btn-primary" value="SUBMIT" />
						<input type="button" onclick="closeAddForm()"
							class="btn btn-danger" value="CANCEL" />
					</div>
		      </form>
	      </div>
      </div>
    `

	pincodeInput = document.getElementById('pincode');
	allLocalityDiv = document.getElementById('result-box');
	localityInput = document.getElementById('locality');

	localityInput.onclick = function() {
		if (!localityInput.value.length) {
			displayAll();
		}
	};
	getDetails();
}

function closeAddForm() {
	location.reload()
}
// here we will store all the locality for a particular pincode

var pincodeInput;
let localityInput;
let allLocality = [];
let allLocalityDiv;

function openAddressForm() {
	const addressDiv = document.getElementById("addressForm");
	addressDiv.innerHTML = `
		  				<div class="card">
								<div class="card-body">
									<form action="add_new_address" method="POST">
										<div class="row my-2">
											<div class="col-sm-12">
												<label>Pincode*</label> <input type="text"
													class="form-control" name="pincode" onkeyup="getDetails()"
													id="pincode" autocomplete="new-password" required>

											</div>
										</div>

										<div class="row my-2">

											<div class="col-sm-6">
												<label>House No./Street*</label> <input type="text"
													class="form-control" name="houseno" required>
											</div>
											<div class="col-sm-6">
												<label>Locality*</label> <input onkeyup = filterLocality() type="text" id="locality"
													class="form-control position-relative" name="locality"
													autocomplete="off" required>
												<div id="result-box"
													class="position-absolute" style="width: 300px"></div>
											</div>

										</div>
										<div class="row my-2">

											<div class="col-sm-6">
												<label>City/District*</label> <input type="text"
													class="form-control bg-light" id="district" name="district"
													required readonly>
											</div>
											<div class="col-sm-6">
												<label>State*</label> <input type="text"
													class="form-control bg-light" id="state" name="state"
													required readonly>
											</div>
										</div>
										<div class="d-flex col-sm-12  justify-content-around mt-3">
											<input type="submit" class="btn btn-primary" value="SUBMIT" />
											<input type="button" onclick="closeAddForm()"
												class="btn btn-danger" value="CANCEL" />
										</div>
									</form>
								</div>
							</div>
							</div>
		  `
	pincodeInput = document.getElementById('pincode');
	allLocalityDiv = document.getElementById('result-box');
	localityInput = document.getElementById('locality');

	localityInput.onclick = function() {
		if (!localityInput.value.length) {
			displayAll();
		}
	};
}
function filterLocality() {
	let result = [];
	let search = localityInput.value;
	if (search.length) {
		result = allLocality.filter(keyword => {
			return keyword.toLowerCase().includes(search.toLowerCase());
		})
		display(result);
	}
	if (!search.length) {
		displayAll()
	}
}

function getDetails() {
	pincode = pincodeInput.value;
	allLocality.length = 0;
	fetch('http://localhost:8080/api/pincode/' + pincode)
		.then(response => {
			return response.json();
		})
		.then(data => {
			document.getElementById("district").value = data.PostOffice[0].District
			document.getElementById("state").value = data.PostOffice[0].State
			addListOfPostOffice(data.PostOffice)
		}).catch(error => {
			document.getElementById("district").value = ''
			document.getElementById("state").value = ''
			allLocality.length = 0;
		})
}

function addListOfPostOffice(PostOffice) {
	PostOffice.forEach(function(element) {
		allLocality.push(element.Name)
	});
}

function selectInput(list) {
	localityInput.value = list.innerHTML;
	allLocalityDiv.innerHTML = ''
}


function display(result) {
	const content = result.map((list) => {
		return "<li onclick = selectInput(this)>" + list + "</li>";
	})
	if (!result.length) {
		allLocalityDiv.innerHTML = ""
	} else {
		allLocalityDiv.innerHTML = "<ul>" + content.join('') + "</ul>";
	}
}
function displayAll() {
	const all_list = allLocality.map((list) => {
		return "<li onclick = selectInput(this)>" + list + "</li>";
	})
	allLocalityDiv.innerHTML = "<ul>" + all_list.join('') + "</ul>";
}

document.addEventListener("click", function(event) {

	const searchBar = document.getElementById("search-bar");
	const searchResult = document.getElementById("search-result");
	if (event.target !== searchBar && !searchBar.contains(event.target)) {
		searchResult.innerHTML = ""
		searchBar.value = ""
	}
});

function confirmAddressDelete() {
	return confirm("Do you want to delete the address");
}



function searchProduct() {
	const searchBar = document.getElementById("search-bar");

	let search = searchBar.value;
	if (search.length > 0) {
		fetch('http://localhost:8080/product/search/' + search)
			.then(response => {
				return response.json()
			}).then(data => {
				showResult(data)
			})
			.catch(error => console.error("Error => ", error))
	}
}

function showResult(Products) {
	const searchBar = document.getElementById("search-bar");
	const searchResult = document.getElementById("search-result");
	const content = Products.map((product) => {
		return `<a href = '/product/${product.name}/' class = 'list-group-item' style = 'cursor : pointer'>` + product.name + `</a>`;
	})

	searchResult.innerHTML = "<div class = 'list-group'>" + content.join('') + "</div>";

}
