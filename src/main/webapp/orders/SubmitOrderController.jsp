<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>


<%
  String custName = request.getParameter("custName");
  String orderDate = request.getParameter("orderDate");
  String orderNo = request.getParameter("orderNo");
  String orderTotalPrice = request.getParameter("orderTotalPrice");

  String[] iventoriesIds = request.getParameterValues("invId");
  String[] orderQuantities = request.getParameterValues("orderQty");

  if (iventoriesIds == null) {
    out.println("No products selected.");
    return;
  }

  Connection con = null;
  PreparedStatement stmt = null;
  PreparedStatement updateStmt = null;
  ResultSet rs = null;

  try {
      Class.forName("com.mysql.jdbc.Driver");
      con = DriverManager.getConnection("jdbc:mysql://localhost/nawanii", "root", "");
      con.setAutoCommit(false);

      for (int i = 0; i < iventoriesIds.length; i++) {
          int inventoryId = Integer.parseInt(iventoriesIds[i]);
          int orderQuantity = Integer.parseInt(orderQuantities[i]);

          // Retrieve the current product quantity
          String selectQuery = "SELECT invQty FROM inventory WHERE invId = ?";
          stmt = con.prepareStatement(selectQuery);
          stmt.setInt(1, inventoryId);
          rs = stmt.executeQuery();
          int currentQuantity = 0;
          if (rs.next()) {
              currentQuantity = rs.getInt("invQty");
          }
          rs.close();
          stmt.close();

          // Update the product quantity
          int updatedQuantity = currentQuantity - orderQuantity;
          String updateQuery = "UPDATE inventory SET invQty = ? WHERE invId = ?";
          updateStmt = con.prepareStatement(updateQuery);
          updateStmt.setInt(1, updatedQuantity);
          updateStmt.setInt(2, inventoryId);
          updateStmt.executeUpdate();
          updateStmt.close();

          // Update the total sold quantity
          String updateSoldQtyQuery = "UPDATE inventory SET totalSoldQty = totalSoldQty + ? WHERE invId = ?";
          updateStmt = con.prepareStatement(updateSoldQtyQuery);
          updateStmt.setInt(1, orderQuantity);
          updateStmt.setInt(2, inventoryId);
          updateStmt.executeUpdate();
          updateStmt.close();

          // Insert the order details and product information
          stmt = con.prepareStatement("INSERT INTO ordersori (orderDate,orderQty,invId,orderNo,custName,orderTotalPrice) VALUES ( ?, ?, ?, ?, ?, ?)");
          stmt.setString(1, orderDate);
          stmt.setInt(2, orderQuantity);
          stmt.setInt(3, inventoryId);      
          stmt.setString(4, orderNo);
          stmt.setString(5, custName);
          stmt.setString(6, orderTotalPrice);
          stmt.executeUpdate();
          stmt.close();
          
       // Insert data into the sales table
          stmt = con.prepareStatement("INSERT INTO sales (date, invoiceId) VALUES (?, ?)");
          stmt.setString(1, orderDate);
          stmt.setString(2, orderNo);
          stmt.executeUpdate();
          stmt.close();
      }
      
      con.commit();
      response.sendRedirect("../orders/order_list.jsp");
      out.println("Order placed successfully!");
  } catch (Exception e) {
      if (con != null) {
          con.rollback();
      }
      out.println("Error: " + e.getMessage());
  } finally {
      try {
          if (rs != null) {
              rs.close();
          }
          if (stmt != null) {
              stmt.close();
          }
          if (updateStmt != null) {
              updateStmt.close();
          }
          if (con != null) {
              con.close();
          }
      } catch (SQLException e) {
          out.println("Error: " + e.getMessage());
      }
  }

%>



