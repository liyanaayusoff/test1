<%@ page import="java.sql.*" %>

<%
  Connection con = null;
  PreparedStatement stmt = null;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/nawanii", "root", "");

    String orderNo = request.getParameter("orderNo");
    stmt = con.prepareStatement("DELETE FROM ordersori WHERE orderNo = ?");
    stmt.setString(1, orderNo);
    stmt.executeUpdate();

    response.sendRedirect("../orders/order_list.jsp?deleteStatus=success"); // Redirect to the view orders page with a success message
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
