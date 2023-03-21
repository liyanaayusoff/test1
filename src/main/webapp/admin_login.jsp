<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<%
        String adminEmail=(String)session.getAttribute("adminEmail");
        
        //redirect user to home page if already logged in
        if(adminEmail!=null){
            response.sendRedirect("admin_home.jsp");
        }
 
        String status=request.getParameter("status");
        
        if(status!=null){
         if(status.equals("false")){
            out.print("Incorrect login details!");           
         }
         else{
         out.print("Some error occurred!");
         }
        }
        %>
    



	<form action="AdminLoginController.jsp" id="main" method="post">
	<center><img src="image/logo.JPG"><center>
	<h1>INVENTORY MANAGEMENT SYSTEM</h1>
		
		<h2>Login</h2>
		
		<div class="input-parent">
			<label for="adminEmail">Email</label>
			<input type="text" id="adminEmail" name="adminEmail" required>
		</div>
		
		<div class="input-parent">
			<label for="adminPassword">Password</label>
			<input type="password" id="adminPassword" name="adminPassword" required>			

		</div>		
		<button type="submit">Login as Admin</button>
		<br><br>
		<a href="index.jsp"><i class="fa fa-arrow-left"></i>&nbsp;back</a>
	</form>

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

//toggle password
const passwordInput = document.querySelector("#password")
const eye = document.querySelector("#eye")

eye.addEventListener("click", function(){
  this.classList.toggle("fa-eye-slash")
  const type = passwordInput.getAttribute("type") === "password" ? "text" : "password"
  passwordInput.setAttribute("type", type)
})

</script>

</body>
</html>
