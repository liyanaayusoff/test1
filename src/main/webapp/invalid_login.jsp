<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <jsp:include page="push.js/notify.jsp" />
    
<!DOCTYPE html>
<html>
<head>
<title>Invalid Login</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="style\login-style.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">

</head>
<body>

	<div id="main" style="text-align:center; color: #fff;">
	<br>
		<h1>Invalid Login</h1> 
		<p>You are either not a registered user or
	    <br>you entered wrong email OR password.</p>
	    <br>
		<a href="index.jsp"><i class="fa fa-arrow-left"></i>&nbsp; Back to Login Page</a>
	<br><br>
	<img src="image/logo.JPG">
	<br>		
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
