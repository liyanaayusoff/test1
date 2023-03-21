<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title> Order</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css"/>
<link rel="stylesheet" href="../style/account-style.css"/>


<script>
      function calculateTotalPrice() {
        var totalPrice = 0.0;
        var orderQuantities = document.getElementsByName("orderQty");

        for (var i = 0; i < orderQuantities.length; i++) {
          var orderQuantity = parseInt(orderQuantities[i].value);
          var sellingPrice = parseFloat(orderQuantities[i].getAttribute("data-price"));
          totalPrice += sellingPrice * orderQuantity;
        }

        document.getElementById("total_price").value = totalPrice.toFixed(2);
      }
    </script>
 
 <style>
 
 #tableO {
  border-collapse: collapse;
  width: 70%;
  text-align: left;

}

#tableO td, #tableO th {
  border: 1px solid #ddd;
  
}


#tableO th {
  background-color: #A382A7;
  color: #fff;
  height: 10px;
  padding-top: 7px;
  padding-bottom: 7px;
  text-align: center;
  
  
}

#tableO tr {
  background-color: #F0F0F0;
  color: black;
 
}

#tableO td {
  height: 7px;
}

#tableO input[type=number], input[type=text], input[type=date] {
  background-color: #EEEDEE;
  height: 30px;
  padding-top: 7px;
  padding-bottom: 7px;
  }
 
.btnOrder {
  background-color: #616161;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin:2px;
  width: 70%;
  height:40px;
}

.btnOrder:hover {
  background-color: #C3BFBF;
  color: black;
  cursor: pointer;

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
      <br><span>Welcome user, <br><strong><%=adminEmail%></strong></span>	
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
    <a href="../orders/order_list.jsp" class="w3-bar-item w3-button w3-padding activeNav" ><i class="fa fa-list-alt"></i>  Order</a>
	    <div class="dropdown" style="float: left;">
	    <button class="w3-bar-item w3-button w3-padding navdropbtn"><i class="fa fa-bar-chart"></i>  Chart</button>
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
    <h5><b><i class="fa fa-dashboard"></i> View Order</b></h5>
  </header>

  <!-- content body -->
  <div class="w3-container">
	
	<%-- JSP code starts here --%>
      <%
        String orderNo = request.getParameter("orderNo");
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost/nawanii", "root", "");

          String selectQuery = "SELECT orderNo, custName, orderDate, orderTotalPrice, invName, orderQty, sellingPrice FROM ordersori INNER JOIN inventory ON ordersori.invId = inventory.invId WHERE orderNo = ? AND orderQty >= 1";
          stmt = con.prepareStatement(selectQuery);
          stmt.setString(1, orderNo);
          rs = stmt.executeQuery();

          if (rs.next()) {
  
			double orderTotalPrice = rs.getDouble("orderTotalPrice");
			double sellingPrice = rs.getDouble("sellingPrice");
			double totalPrice = sellingPrice * rs.getInt("orderQty");

			DecimalFormat df = new DecimalFormat("#,##0.00");
			String formattedPrice = df.format(orderTotalPrice);
			String formattedPrice1 = df.format(sellingPrice);
			String formattedPrice2 = df.format(totalPrice);

		
			%>
			
			
	<a href="../orders/order_list.jsp">    
	<button class="w3-button w3-dark-grey" style="float: right; font-size:15px; border-radius:25px;"><i class="fa fa-arrow-left"></i>&nbsp;Back</button>
     </a>
	<br>
	<div class="container">
	<table id="tableO">
      <tr>
          <td style="color:#fff;background-color: #A382A7;">&nbsp;&nbsp;<b>Order Number:</b></td>
          <td><input type="text" style="color:#000;" value='<%=rs.getString("orderNo")%>' name="orderNo" disabled></td>
        </tr>
        <tr>
          <td style="color:#fff;background-color: #A382A7;">&nbsp;&nbsp;<b>Cust Name:</b></td>
          <td><input type="text" style="color:#000;"  value='<%=rs.getString("custName")%>' name="custName" disabled></td>
        </tr>
        
        <tr>
          <td style="color:#fff;background-color: #A382A7;">&nbsp;&nbsp;<b>Date:</b></td>
          <td><input type="date" style="color:#000;" value='<%=new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("orderDate"))%>' name="orderDate" disabled></td>
        </tr>
        <tr>
        </table>
		<br>
		<table id="tableO">
	          <tr>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price (RM)</th>
                <th>Total Price (RM)</th>
              </tr>
  <%
              do {
      %>
                <tr>
                  <td style="text-align:center;"><%=rs.getString("invName")%></td>
                  <td style="text-align:center;"><%=rs.getInt("orderQty")%></td>
                  <td style="text-align:center;"><%= formattedPrice1 %></td>
                  <td style="text-align:center;"><%= formattedPrice2 %></td>
                </tr>
                 
      		
	  <%
              } while (rs.next());
      %>              
        </table>                
		<br>
      	<table id="tableO">
      
	<tr>
          <td style="color:#fff;background-color: #A382A7;">&nbsp;&nbsp;<b>Order Total Purchase: </b></td>
          <td ><input type="text" name="totalPurchase" style="color:#000;" value='RM <%= formattedPrice %>' disabled></td>
        </tr>
	</table>
         </div>   
      <%
          } else {
      %>
            <p>No order found with the given order number.</p>
      <%
          }
          rs.close();
          stmt.close();
          con.close();
        } catch (Exception e) {
          out.println("Error: " + e.getMessage());
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
            out.println("Error: " + e.getMessage());
          }
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
</script>


</body>
</html>