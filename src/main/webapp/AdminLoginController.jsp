<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
String adminEmail = request.getParameter("adminEmail");
String adminPassword = request.getParameter("adminPassword");

Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
  Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/nawanii","root","");
	
	stmt = con.createStatement();

	rs = stmt.executeQuery("SELECT * FROM admin WHERE adminEmail='" + adminEmail + "' AND adminPassword='" + adminPassword + "'");

	if(rs.next()){
	  session.setAttribute("adminEmail", adminEmail);
	  response.sendRedirect("admin_home.jsp");
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