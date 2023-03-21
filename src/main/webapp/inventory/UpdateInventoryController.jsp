<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>

<%
String invId = request.getParameter("invId");
String invName = request.getParameter("invName");
String invBrand = request.getParameter("invBrand");
String invType = request.getParameter("invType");
String purchasePrice = request.getParameter("purchasePrice");
String sellingPrice = request.getParameter("sellingPrice");
String expDate = request.getParameter("expDate");
String invQty = request.getParameter("invQty");
String minInvLevel = request.getParameter("minInvLevel");


try {
    // Get database connection
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/nawanii", "root", "");

    // Update inventory item in database
    PreparedStatement stmt = con.prepareStatement("UPDATE inventory SET invName=?, invBrand=?, invType=?, purchasePrice=?, sellingPrice=?, expDate=?, invQty=?, minInvLevel=? WHERE invId=?");
    stmt.setString(1, invName);
    stmt.setString(2, invBrand);
    stmt.setString(3, invType);
    stmt.setDouble(4, Double.parseDouble(purchasePrice));
    stmt.setDouble(5, Double.parseDouble(sellingPrice));
    stmt.setDate(6, Date.valueOf(expDate));
    stmt.setInt(7, Integer.parseInt(invQty));
    stmt.setInt(8, Integer.parseInt(minInvLevel));

    stmt.setInt(9, Integer.parseInt(invId));
    int rowsUpdated = stmt.executeUpdate();
    
    // Close database connection and statement
    stmt.close();
    con.close();
    
    // Redirect to inventory list page with success message
    response.sendRedirect("../inventory/inventory_all.jsp?message=Inventory item updated successfully.");
  } catch (SQLException e) {
    // Handle database errors
    out.println("An error occurred while updating the inventory item: " + e.getMessage());
}
%>

<script>
function showUpdateSuccessAlert() {
    alert("Inventory updated successfully!");
}




</script>
