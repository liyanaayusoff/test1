<%@ page import="java.sql.*" %>

<%
  Connection con = null;
  PreparedStatement stmt = null;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/nawanii", "root", "");

    String invId = request.getParameter("invId");
    stmt = con.prepareStatement("DELETE FROM inventory WHERE invId = ?");
    stmt.setString(1, invId);
    stmt.executeUpdate();

    response.sendRedirect("../inventory/inventory_all.jsp?deleteStatus=success"); // Redirect to the view inventory page with a success message
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    try {
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
