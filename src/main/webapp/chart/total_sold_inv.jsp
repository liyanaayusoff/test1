<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../push.js/notify.jsp" />


<%
        String adminEmail=(String)session.getAttribute("adminEmail");
        
        //redirect user to login page if not logged in
        if(adminEmail==null){
         response.sendRedirect("index.jsp");
        }
        %>
        
<!DOCTYPE html>
<html>
<head>
<title>Chart</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css"/>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<style type="text/css">

.chartform {
  display: flex;
  justify-content: space-between;
  align-items: center;
}


.form-group {
  margin-left: 80px;
  margin-right: 40px;
}


input[type=number], select {
  width: 220px;
  padding: 0.375rem 0.75rem;
  font-size: 1rem;
  line-height: 1.5;
  color: #495057;
  background-color: #fff;
  border: 1px solid #ced4da;
  border-radius: 0.25rem;
  height: 35px;
}

.btn{
  background-color: #CCA1CB;
  height: 35px;
  color: #000;
  border: 1px solid #ced4da;
  cursor: pointer;

}

.btn:hover{
  background-color: #ced4da;
  color: #fff;

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
      <br><span>Welcome user, <strong><%=adminEmail%></strong></span>	
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5>Dashboard</h5>
  </div>
   <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="../system/admin_account.jsp" class="w3-bar-item w3-button w3-padding "><i class="fa fa-user fa-fw"></i> Account</a>
	<a href="../ListStaffController" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i> Staff</a>
	<a href="../admin_home.jsp" class="w3-bar-item w3-button w3-padding "><i class="fa fa-home"></i>  Home</a>
    <a href="../inventory/inventory_all.jsp" class="w3-bar-item w3-button w3-padding "><i class="fa fa-cube"></i>  Inventory</a>  
    <a href="../orders/order_list.jsp" class="w3-bar-item w3-button w3-padding " ><i class="fa fa-list-alt"></i>  Order</a>
	    <div class="dropdown chartBtn" style="float: left;">
	    <button class="w3-bar-item w3-button w3-padding "><i class="fa fa-bar-chart"></i>  Chart</button>
	    <div class="dropdown-content">
	      <a href="../chart/total_sales_inv.jsp">Sales & Profit</a>
	      <a href="../chart/total_sold_inv.jsp">Inventory Sold</a>
	    </div>
	  </div>  
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
    <h5><b><i class="fa fa-dashboard"></i> Inventory Sold Chart </b></h5>
  </header>

  <!-- content body -->
  <div class="w3-container">

 <form method="post" action="total_sold_inv.jsp" class="chartform">
  <div class="form-row">
    <div class="form-group">
      <label class="" for="inventory">Select an inventory item:</label>
      <select id="inventory" name="inventory" required>
      <option value="">--choose inventory--</option>
        <%-- Populate the inventory dropdown with data from the inventory table --%>
        <%
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/nawanii", "root", "");
          Statement stmt = conn.createStatement();
          ResultSet rs = stmt.executeQuery("SELECT * FROM inventory");
          while (rs.next()) {
            out.println("<option value=\"" + rs.getInt("invId") + "\">" + rs.getString("invName") + " </option>");
          }
        %>
      </select>
      &nbsp;
      <label for="year">Enter a year:</label>
      <input required type="number" id="year" name="year" required min="2021" max="2025" placeholder="eg; 2020,2021">
      <button class="btn" type="submit">Generate Chart</button>
</div>
    
    
  </div>
  
</form>


<%
  if (request.getMethod().equals("POST")) {
    int invId = Integer.parseInt(request.getParameter("inventory"));
    int year = Integer.parseInt(request.getParameter("year"));

    // Query the inventory table to get the name of the selected inventory item
    rs = stmt.executeQuery("SELECT invName FROM inventory WHERE invId = " + invId);
    rs.next();
    String invName = rs.getString("invName");

    // Display the title of the chart
    out.println("<center><h2>" + invName + " Total Sold in " + year + "</h2></center>");
  }
%>


  <%-- Display the chart if the form has been submitted --%>
  <% if (request.getMethod().equals("POST")) {
        int invId = Integer.parseInt(request.getParameter("inventory"));
        int year = Integer.parseInt(request.getParameter("year"));
        int[] sales = new int[12]; // Array to store total sales for each month

        // Query the order table to get the total inventory sold for each month
        rs = stmt.executeQuery("SELECT SUM(i.totalSoldQty) as total_sold, MONTH(o.orderDate) as month FROM ordersori o JOIN inventory i ON o.invId = i.invId WHERE YEAR(o.orderDate) = " + year + " AND i.invId = " + invId + " GROUP BY MONTH(o.orderDate)");
       
        		while (rs.next()) {
          sales[rs.getInt("month") - 1] = rs.getInt("total_sold"); // Store the total sales for the month in the array
        }

        // Display the chart using Chart.js

        		out.println("<canvas id=\"salesChart\" height=\"180px\" width=\"500px\"></canvas>");
                out.println("<script>");
                out.println("var salesData = {");
                out.println("  labels: [\"Jan\", \"Feb\", \"Mar\", \"Apr\", \"May\", \"Jun\", \"Jul\", \"Aug\", \"Sep\", \"Oct\", \"Nov\", \"Dec\"],");
                out.println("  datasets: [{");
                out.println("    label: \"Total Inventory Sold\",");
                out.println("    data: [" + sales[0] + ", " + sales[1] + ", " + sales[2] + ", " + sales[3] + ", " + sales[4] + ", " + sales[5] + ", " + sales[6] + ", " + sales[7] + ", " + sales[8] + ", " + sales[9] + ", " + sales[10] + ", " + sales[11] + "],");
                out.println("    backgroundColor: \"#47C3EB\",");
                out.println("    borderColor: \"#A7BFC7\",");
                out.println(" borderWidth: 1");
        		out.println(" }]");
        		out.println("};");
        		out.println(" var salesChart = new Chart(document.getElementById('salesChart'), {");
        		out.println(" type: 'bar',");
        		out.println(" data: salesData,");
        		out.println(" options: {");
        		out.println(" scales: {");
        		out.println(" yAxes: [{");
        		out.println(" ticks: {");
        		out.println(" beginAtZero: true");
        		out.println(" }");
        		out.println(" }]");
        		out.println(" }");
        		out.println(" }");
        		out.println("});");

        		
        		
        		out.println("</script>");

        		}
          
        		%>

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
