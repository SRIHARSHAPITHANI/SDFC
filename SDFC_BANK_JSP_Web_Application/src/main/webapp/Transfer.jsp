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
	long target_account_no = Long.parseLong(request.getParameter("taccno"));
	double amount = Double.parseDouble(request.getParameter("amount"));
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","defdb","defdb");
	PreparedStatement ps1 = con.prepareStatement("update sdfc_bank_account_info set amount = amount+? where account_no = ?");
	ps1.setDouble(1,amount);
	ps1.setLong(2,target_account_no);
	PreparedStatement ps2 = con.prepareStatement("update sdfc_bank_account_info set amount = amount-? where account_no = ?");
	ps2.setDouble(1,amount);
	ps2.setLong(2,account_no);
	int i = ps1.executeUpdate();
	out.print(i+"Amount Recieved Successfully...");
	int j = ps2.executeUpdate();
	out.print(j+"Amount Transfered Successfully...");
	con.close();
}
catch(Exception e){
	out.print(e);
}
%>
</body>
</html>