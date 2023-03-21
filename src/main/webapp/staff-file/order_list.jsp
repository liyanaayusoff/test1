<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>Order</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css"/>

<script src="https://cdn.onesignal.com/sdks/OneSignalSDK.js" async=""></script>
<script>
  var OneSignal = window.OneSignal || [];
  OneSignal.push(function() {
    OneSignal.init({
      appId: "c5faf2e1-534d-4607-827c-5c993c295aa3",
      autoRegister: false,
      notifyButton: {
        enable: false
      }
    });
  });
</script>
<style>
.ButtonView{
	background-color: blue;
	float: center;
	size: 18px;
	border: none;
	cursor: pointer;
	color: #584646;
	border-radius: 15px;
}

.ButtonUpdate{
	background-color: orange;
	float: center;
	size: 18px;
	border: none;
	cursor: pointer;
	color: #584646;
	border-radius: 15px;
}

.ButtonDelete{
	background-color: red;
	float: center;
	size: 18px;
	border: none;
	cursor: pointer;
	color: #584646;
	border-radius: 15px;
}

.tableButton:hover {
	color: white;
}

.tableButton{
	float: center;
	size: 18px;
	border: none;
	cursor: pointer;
	color: #000;
	border-radius: 5px;

}
</style>

</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-large" style="z-index:4; background-color:#A382A7;">
  <button  class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <img src="../image/avatar.png" class=" w3-bar-item w3-right w3-circle" style="height:45px">
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
      <br><span>Welcome user, <br> <strong><%=staffEmail%></strong></span>	
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5>Dashboard</h5>
  </div>
 <div class="w3-bar-block">
      <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
      <a href="../staff-file/staff_account.jsp" class="w3-bar-item w3-button w3-padding "><i class="fa fa-user fa-fw"></i> Account</a>
	  <a href="../staff_home.jsp" class="w3-bar-item w3-button w3-padding "><i class="fa fa-home"></i>  Home</a>
	  <a href="../staff-file/s-inventory_list.jsp" class="w3-bar-item w3-button w3-padding "><i class="fa fa-cube"></i>  Inventory</a>  
	  <a href="../staff-file/order_list.jsp" class="w3-bar-item w3-button w3-padding activeNav" ><i class="fa fa-list-alt"></i>  Order</a>
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
    <h5><b><i class="fa fa-dashboard"></i> Order List</b></h5>
  </header>

  <!-- content body -->
  <div class="w3-container">
 
  
  
    <a href="../staff-file/order_form.jsp">    
	<button class="w3-button" style="float: right; font-size:15px; border-radius:10px; background-color: #A189A9;"><i class="fa fa-plus"></i>&nbsp;Submit New Order</button>
  </a>	
	<br><br>
  <table id="tableA">
      <tr>
        <th>Order No</th>
        <th>Customer Name</th>
        <th>Order Date</th>
        <th>Order Total Item</th>
        <th>Total Price</th>
        <th>Invoice</th>
        <th>Action</th>
        
      </tr>
      <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost/nawanii", "root", "");
          stmt = con.createStatement();
          
          
          rs = stmt.executeQuery("SELECT DISTINCT orderNo, custName, orderDate, orderTotalPrice, SUM(orderQty) AS total_quantity FROM ordersori GROUP BY orderNo");
          while (rs.next()) {
            String orderNo = rs.getString("orderNo");
            String custName = rs.getString("custName");
            Date orderDate = rs.getDate("orderDate");
            double orderTotalPrice = rs.getDouble("orderTotalPrice");
            int totalQuantity = rs.getInt("total_quantity");

      %>
      <tr>
        <td><%= orderNo %></td>
        <td><%= custName %></td>
        <td><%= orderDate %></td>
        <td><%= totalQuantity %></td>
        <td><fmt:formatNumber value="<%= orderTotalPrice %>" type="number" pattern="#,##0.00" /></td>
        
		<td>
		<a href="../orders/print_invoice.jsp?orderNo=<%= orderNo %> " target="_blank">  
        <button style="background-color: #A189A9; border:1px black solid; cursor:pointer;">Print</button>
        </a>
        </td>
            
            	    
           <td>                      
           
           <button class="tableButton ButtonView">
        		 <a href="../staff-file/s-view_order.jsp?orderNo=<%= orderNo %>"><i class="fa fa-eye"></i></a>
			</button>

			<button class="tableButton ButtonDelete">
           		<a href="../staff-file/SDeleteOrderController.jsp?orderNo=<%= orderNo %>&deleteStatus=success" onclick="return confirm('Are you sure you want to delete this order?')"><i class="fa fa-trash"></i></a>
           
			</button>
           
            </td>
      </tr>
      <%
          }
        } catch (Exception e) {
          e.printStackTrace();
        } finally {
          try {
            if (rs != null) {
              rs.close();
            }
            if (stmt != null) {
              stmt.close();
            }
            if (con != null) {
              con.close();
            }
          } catch (SQLException e) {
            e.printStackTrace();
          }
        }
      %>
    </table>
  
  
  <br><br>

        <script>
	function myFunction() {
	  alert("Sucessfully delete a staff");
	  window.location.href = "ListStaffController";
	}
	</script>
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

//Parse the URL to get the query parameters
const urlParams = new URLSearchParams(window.location.search);

// Check if the deleteStatus parameter is present and has a value of "success"
if (urlParams.has('deleteStatus') && urlParams.get('deleteStatus') === 'success') {
  // Display a success message
  alert('Order successfully deleted!');
}
</script>

</body>
</html>
