<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
  // Get the form data
  String invName = request.getParameter("invName");
  String invBrand = request.getParameter("invBrand");
  String invType = request.getParameter("invType");
  double purchasePrice = Double.parseDouble(request.getParameter("purchasePrice"));
  double sellingPrice = Double.parseDouble(request.getParameter("sellingPrice"));
  String expDate = request.getParameter("expDate");
  int invQty = Integer.parseInt(request.getParameter("invQty"));
  int totalSoldQty = Integer.parseInt(request.getParameter("totalSoldQty"));
  int minInvLevel = Integer.parseInt(request.getParameter("minInvLevel"));


  // Connect to the database
  String url = "jdbc:mysql://localhost/nawanii";
  String username = "root";
  String password = "";
  Connection conn = null;
  try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, username, password);


    // Insert the inventory data into the database
    String query = "INSERT INTO inventory (invName, invBrand, invType, purchasePrice, sellingPrice, expDate, invQty, totalSoldQty, minInvLevel) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement stmt = conn.prepareStatement(query);
    stmt.setString(1, invName);
    stmt.setString(2, invBrand);
    stmt.setString(3, invType);
    stmt.setDouble(4, purchasePrice);
    stmt.setDouble(5, sellingPrice);
    stmt.setString(6, expDate);
    stmt.setInt(7, invQty);
    stmt.setInt(8, totalSoldQty);
    stmt.setInt(9, minInvLevel);

    stmt.executeUpdate();

    // Redirect to the inventory list page
    response.sendRedirect("../inventory/inventory_all.jsp");
  } catch (Exception e) {
    out.println(e.getMessage());
  } finally {
    if (conn != null) {
      conn.close();
    }
  }
%>
