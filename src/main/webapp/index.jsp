<jsp:include page="push.js/notify.jsp" />


<!DOCTYPE html>
<html>
<head>
<title>Inventory</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="style\login-style.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">

</head>
<body>

	<div id="main">
	<center><img src="image/logo.JPG"><center>
	<h1>INVENTORY MANAGEMENT SYSTEM</h1>
		<br>

		<a href="admin_login.jsp">    
			<button class="buttonA" style="float: right; font-size:15px;">Admin</button>
		</a>
		<br><br><br>
		<div>
		<a href="staff_login.jsp">    
			<button class="buttonA" style="float: right; font-size:15px;">Staff</button>
		</a>	
		</div>
	<br><br>		
	</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}

 window.addEventListener("DOMContentLoaded", e => {

    // Original JavaScript code by Chirp Internet: chirpinternet.eu
    // Please acknowledge use of this code by including this header.

}
</script>

</body>
</html>
