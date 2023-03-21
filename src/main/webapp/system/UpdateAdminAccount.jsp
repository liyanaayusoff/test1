<%@ page import="java.sql.*" %>
<%
String DB_DRIVER = "com.mysql.jdbc.Driver";
String DB_HOST = "jdbc:mysql://localhost/nawanii";
String DB_USER = "root";
String DB_PASSWORD = "";
Connection conn = null;
PreparedStatement pstmt = null;
String adminId = request.getParameter("adminId");
String adminName = request.getParameter("adminName");
String adminPhoneNo = request.getParameter("adminPhoneNo");
String adminEmail = request.getParameter("adminEmail");
String adminPassword = request.getParameter("adminPassword");

try {
    Class.forName(DB_DRIVER);
    conn = DriverManager.getConnection(DB_HOST, DB_USER, DB_PASSWORD);
    String query = "UPDATE admin SET adminName=?, adminPhoneNo=?, adminEmail=?, adminPassword=? WHERE adminId=?";
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1, adminName);
    pstmt.setString(2, adminPhoneNo);
    pstmt.setString(3, adminEmail);
    pstmt.setString(4, adminPassword);
    pstmt.setInt(5, Integer.parseInt(adminId));
    int rowsUpdated = pstmt.executeUpdate();
    if (rowsUpdated > 0) {
        out.println("Record updated successfully.");
        response.sendRedirect("../system/admin_account.jsp");
    } else {
        out.println("Failed to update record.");
    }
} catch (SQLException e) {
    out.println("SQL Exception: " + e.getMessage());
} catch (ClassNotFoundException e) {
    out.println("Class Not Found Exception: " + e.getMessage());
} finally {
    try {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        out.println("SQL Exception: " + e.getMessage());
    }
}
%>
