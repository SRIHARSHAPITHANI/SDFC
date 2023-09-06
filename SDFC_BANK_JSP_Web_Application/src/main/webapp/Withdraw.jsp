<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
	long account_no = Long.parseLong(request.getParameter("accno"));
	String name = request.getParameter("name");
	String password = request.getParameter("psw");
	double amount = Double.parseDouble(request.getParameter("amount"));
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","defdb","defdb");
	PreparedStatement ps = con.prepareStatement("update sdfc_bank_account_info set amount = amount-? where name=? and password=?");
	ps.setDouble(1,amount);
	ps.setString(2,name);
	ps.setString(3,password);
	int i = ps.executeUpdate();
	out.print(i+"Amount Withdrawn Successfully... ");
	con.close();
}
catch(Exception e){
	out.print(e);
}
%>
</body>
</html>