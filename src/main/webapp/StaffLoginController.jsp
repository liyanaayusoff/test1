<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
String staffEmail = request.getParameter("staffEmail");
String staffPassword = request.getParameter("staffPassword");

Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
  Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/nawanii","root","");
	
	stmt = con.createStatement();

	rs = stmt.executeQuery("SELECT * FROM staff WHERE staffEmail='" + staffEmail + "' AND staffPassword='" + staffPassword + "'");

	if(rs.next()){
	  session.setAttribute("staffEmail", staffEmail);
	  response.sendRedirect("staff_home.jsp");
	}
	else{
  		response.sendRedirect("invalid_login.jsp?status=false");
	}
}
catch (Exception e) 
{
  response.sendRedirect("invalid_login.jsp?status=error");
} 
%>