<%@ page import="java.sql.*" %>
<%
String DB_DRIVER = "com.mysql.jdbc.Driver";
String DB_HOST = "jdbc:mysql://localhost/nawanii";
String DB_USER = "root";
String DB_PASSWORD = "";
Connection conn = null;
PreparedStatement pstmt = null;
String staffId = request.getParameter("staffId");
String staffName = request.getParameter("staffName");
String staffPhoneNo = request.getParameter("staffPhoneNo");
String staffEmail = request.getParameter("staffEmail");
String staffPassword = request.getParameter("staffPassword");

try {
    Class.forName(DB_DRIVER);
    conn = DriverManager.getConnection(DB_HOST, DB_USER, DB_PASSWORD);
    String query = "UPDATE staff SET staffName=?, staffPhoneNo=?, staffEmail=?, staffPassword=? WHERE staffId=?";
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1, staffName);
    pstmt.setString(2, staffPhoneNo);
    pstmt.setString(3, staffEmail);
    pstmt.setString(4, staffPassword);
    pstmt.setInt(5, Integer.parseInt(staffId));
    int rowsUpdated = pstmt.executeUpdate();
    if (rowsUpdated > 0) {
        out.println("Record updated successfully.");
        response.sendRedirect("../staff-file/staff_account.jsp");
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
