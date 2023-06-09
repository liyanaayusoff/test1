<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
 <%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
 <jsp:include page="../push.js/notify.jsp" />
 

<%
        String staffEmail=(String)session.getAttribute("staffEmail");
        
        //redirect user to login page if not logged in
        if(staffEmail==null){
         response.sendRedirect("index.jsp");
        }
        %>
  

<!DOCTYPE html>
<html>
<head>
<title>Account</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css"/>
<link rel="stylesheet" href="../style/account-style.css"/>


</head>




<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-large" style="z-index:4; background-color:#A382A7;">
  <button  class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <img src="../image/avatar.png" class=" w3-bar-item w3-right w3-circle" style="height:45px">
  <a href="#" class="w3-bar-item w3-right"><i class="fa fa-bell fa-fw" ></i></a>
<img src="../image/logo.JPG" class=" w3-bar-item w3-left w3-circle" style="height:45px">
  <P style="font-size: 14px; font-weight:bold;">  NAWANII EMPIRE INVENTORY MANAGEMENT SYSTEM </P>

</div>

<!-- Load an icon library to show a hamburger menu (bars) on small screens -->



<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s4">
      <img src="../image/avatar.png" class="w3-circle w3-margin-right" style="width:80px">
    </div>
	 <div class="w3-col s8 w3-bar">
      <br><span>Welcome staff, <br><strong><%=staffEmail%></strong></span>	
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5>Dashboard</h5>
  </div>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="../staff-file/staff_account.jsp" class="w3-bar-item w3-button w3-padding activeNav"><i class="fa fa-user fa-fw"></i> Account</a>
	<a href="../staff_home.jsp" class="w3-bar-item w3-button w3-padding "><i class="fa fa-home"></i>  Home</a>
  <a href="../staff-file/s-inventory_list.jsp" class="w3-bar-item w3-button w3-padding"><i class="fa fa-cube"></i>  Inventory</a>  
  <a href="../staff-file/order_list.jsp" class="w3-bar-item w3-button w3-padding" ><i class="fa fa-list-alt"></i>  Order</a>
  <a href="../logout.jsp" class="w3-bar-item w3-button"><i class="fa fa-sign-out"></i>  Logout</a>
	
	<br>
  </div>
</nav>




<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <div class="topnav" id="myTopnav">
  
 
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    <i class="fa fa-bars"></i>
  </a>
 
</div>
  
  <header class="w3-container" style="padding-top:22px">
  </header>

  <!-- content body -->
  <div class="w3-container">
     <div class="container"><h1><i class="fa fa-user fa-fw"></i> User Account</h1>

  <form name="registration" class="registartion-form center" method="post">
	<table>
    <%
       String DB_DRIVER = "com.mysql.jdbc.Driver";
       String DB_HOST = "jdbc:mysql://localhost/nawanii";
       String DB_USER = "root";
       String DB_PASSWORD = "";
       Connection conn = null;
       Statement st;
       Class.forName(DB_DRIVER);
       conn = DriverManager.getConnection(DB_HOST, DB_USER, DB_PASSWORD);
       st = conn.createStatement();
       ResultSet rs1 = st.executeQuery("SELECT * FROM staff WHERE staffEmail = '" + staffEmail + "'");

       while(rs1.next()){
       %>
       
      <tr>
        <td><label for="name">Staff Id:</label></td>
        <td><input type="text" name="staffId" id="staffId" value="<%=rs1.getInt("staffId")%>"></td>
      </tr>
      <tr>
        <td><label for="email">Name:</label></td>
        <td><input type="text" name="staffName" id="staffName" value="<%=rs1.getString("staffName")%>"></td>
      </tr>
      <tr>
        <td><label for="password">Phone Number:</label></td>
        <td><input type="text" name="staffPhoneNo" id="staffPhoneNo" value="<%=rs1.getString("staffPhoneNo")%>"></td>
      </tr>
      <tr>
        <td><label for="phoneNumber">Email:</label></td>
        <td><input type="text" name="staffEmail" id="staffEmail" value="<%=rs1.getString("staffEmail")%>"></td>
      </tr>
       <tr>
        <td><label for="userType">Role:</label></td>
        <td><input type="text" name="userType" id="userType" value="<%=rs1.getString("userType")%>"></td>
      </tr>
       <tr>
        <td>
        &nbsp;
         </td>
         <td>
         <br>
                  	<a href="../staff-file/staff_account_edit.jsp?staffId=<%=rs1.getInt("staffId")%>" class="acc">Edit</a>
    
         </td>
      </tr>
       <%
       }
        %>
    </table>
  </form>
    </div>

  </div>
  <hr>
 
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 footerbg">
    <h4>FOOTER</h4>
    <p>Powered by </p>
  </footer>

  <!-- End page content -->
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
</script>

</body>
</html>
