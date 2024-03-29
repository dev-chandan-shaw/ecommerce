<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
li {
	border: 1px solid black;
	padding: 5px;
	list-style: none;
	cursor: pointer;
}

li:hover {
	background: black;
	color: white;
}
</style>
</head>
<body>

	<div
		class="container d-flex flex-column justify-content-center align-items-center"
		style="height: 100vh;">
		<div>
			<input type="text" class="me-1" id="pincode"
				autocomplete="new-password" onkeyup="get_details()">
		</div>
		<div class="position-relative">
			<div>
				<input type="text" id="locality" autocomplete="off">
			</div>
			<div id="result-box"></div>
			<div class="position-absolute">
				<input type="text" disabled id="city" placeholder="city"> <input
					type="text" disabled id="district" placeholder="state">
			</div>
		</div>

	</div>

</body>

<script type="text/javascript">
const availableLocality = [];

const inputBox = document.getElementById("pincode")
function get_details() {
    var pincode = document.getElementById("pincode").value; // Retrieve the pincode value
    availableLocality.length = 0;
    fetch('http://localhost:8080/api/pincode/'+pincode)
        .then(response => {
            return response.json();
        })
        .then(data => {
        	document.getElementById("city").value = data.PostOffice[0].Taluk;
        	document.getElementById("district").value = data.PostOffice[0].District;
        	addListOfPostOffice(data.PostOffice)
        })
        .catch(error => {
        	document.getElementById("city").value = ''
            document.getElementById("district").value = ''
            availableLocality.length = 0;
        });
    
}

function addListOfPostOffice(PostOffice) {
	
	PostOffice.forEach(function(element) {
		availableLocality.push(element.Name)
	});
	console.log(availableLocality)
}
const resultbox = document.getElementById("result-box");
const searchInput = document.getElementById("locality")
let allLocality = availableLocality;
  searchInput.onkeyup = function () {
    let result = [];
    let search = searchInput.value;
    if (search.length) {
      result = allLocality.filter(keyword =>{
        return keyword.toLowerCase().includes(search.toLowerCase());
      })
      console.log(result)
      display(result);
    }
    
  }
  searchInput.onclick = function () {
	  if (!searchInput.value.length) {
		  displayAll()
	  }
  } 
  searchInput.onchange = function () {
	  
  }
  document.addEventListener("click", function(event) {
	    if (event.target !== searchInput && !searchInput.contains(event.target)) {
	    	resultbox.innerHTML = ""
	    }
	});
  
  function display(result) {
    const content = result.map((list) => {
      return "<li onclick = selectInput(this)>" + list + "</ul>";
    })
    resultbox.innerHTML = "<ul>" + content.join('') + "</ul>";
  }

  function displayAll() {
    const all_list = allLocality.map((list) => {
      return  "<li onclick = selectInput(this)>" + list + "</li>";
    })
    resultbox.innerHTML = "<ul>" + all_list.join('') + "</ul>";
  }
  function selectInput(list) {
	 searchInput.value = list.innerHTML;
	 resultbox.innerHTML = ''
  }
</script>
</html>