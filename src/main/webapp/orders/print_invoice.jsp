<%@page import="java.sql.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Order Invoice</title>

<style>


/* header */

header { margin: 0 0 3em; height: 130px;}
header:after { clear: both; content: ""; display: table; }

header address { float: left; font-size:14PX; font-style: normal; line-height: 1.25; margin: 0 1em 1em 0; }
header address p { margin: 0 0 0.25em; }
header span, header img { display: block; float: right; }
header span { margin: 0 0 1em 1em; max-height: 25%; max-width: 60%; position: relative; }
header img { height: 150px; max-width: 150px; }
header input { cursor: pointer; -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)"; height: 100%; left: 0; opacity: 0; position: absolute; top: 0; width: 100%; }

header h1 { 
	font: bold 100% sans-serif; 
	letter-spacing: 0.5em; 
	text-align: center; 
	text-transform: uppercase; 
	background: #000; 
	border-radius: 0.25em; 
	color: #FFF; 
	margin: 0 0 1em; 
	padding: 0.5em 0;
}



/* page */

html { background: #fff; cursor: default; }

body { background: #fff;}

h2 {
  color: #333;
  font-size:15px;
}

table {
  margin-top: 20px;
  border-collapse: collapse;
  width: 100%;
}

th, td {
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

th {
  background-color: #C8C8C8;
  color: #000;
}

tr:hover {
  background-color: #f5f5f5;
}

p {
  margin: 0;
  margin-bottom: 10px;
}

.error {
  color: red;
}

* {
  box-sizing: border-box;
}

.row {
  display: flex;
}

/* Create two equal columns that sits next to each other */
.column {
  flex: 50%;
  padding: 10px;
  height: 190px;
}

.column1 {
  padding: 10px;
  height: 300px;
  width: 100px; /* Should be removed. Only for demonstration */
}

</style>

  </head>
  <body>

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
      %>
      
      <header>
			<h1>Order Invoice #<%=rs.getString("orderNo")%></h1>
		<img src="../image/logo.JPG" style="float:left;width:80px;height:80px;">
			
			<address >
				<p>&nbsp;Nawanii Empire</p>
				<p>&nbsp;No-15 Jalan Sungai Rusa 11000 </p>
				<p>&nbsp;Balik Pulau, Pulau Pinang</p>
				<p>&nbsp;017 413 7963</p>
			</address>
			<span><img alt="" src="http://www.jonathantneal.com/examples/invoice/logo.png"><input type="file" accept="image/*"></span>
		</header>
      
	<div class="row">
	<div class="column" style="background-color:none; text-align:LEFT;">
    <h2>CUSTOMER NAME</h2>
     <p><%=rs.getString("custName")%></p>
	
  </div>
  <div class="column" style="background-color:none; text-align:right;">
    <h2>ORDER NO </h2> 
	<p>#<%=rs.getString("orderNo")%></p>
    
    <h2>ORDER DATE</h2>
	<p><%=new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("orderDate"))%></p>

			<%
			double orderTotalPrice = rs.getDouble("orderTotalPrice");
			double sellingPrice = rs.getDouble("sellingPrice");
			double totalPrice = sellingPrice * rs.getInt("orderQty");

			DecimalFormat df = new DecimalFormat("#,##0.00");
			String formattedPrice = df.format(orderTotalPrice);
			String formattedPrice1 = df.format(sellingPrice);
			String formattedPrice2 = df.format(totalPrice);
			
			%>
			<h2>ORDER TOTAL PURCHASE</h2>
			<p style="font-size:24px;">RM <%= formattedPrice %></p>
 
 			
			
  </div>

</div>
<br>
            <table >
              <tr>
                <th style="text-align:center;">Product Name</th>
                <th style="text-align:center;">Quantity</th>
                <th style="text-align:center;">Unit Price</th>
                <th style="text-align:center;">Total Price</th>
              </tr>
      <%
              do {
      %>
                <tr>
                  <td style="text-align:center;"><%=rs.getString("invName")%></td>
                  <td style="text-align:center;"><%=rs.getInt("orderQty")%></td>
                  <td style="text-align:center;">RM <%= formattedPrice1 %></td>
                  <td style="text-align:center;">RM <%= formattedPrice2 %></td>
                </tr>
                                
      <%
              } while (rs.next());
      %>             
      		</table>
      		<BR>
      		 <BR>
      		 <BR>
      		<p style="text-align:center;">ADDITIONAL NOTES</p>
      		<HR>
      		 <p style="text-align:center;">Thank you for purchase order with Nawanii Empire</p>
      		
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
  </body>
</html>