<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>OPEN ACCOUNT FORM</title>
</head>
<body>
<%
try{
long account_no = Long.parseLong(request.getParameter("accno"));
String name = request.getParameter("name");
String password = request.getParameter("psw");
String confirm_password = request.getParameter("cpsw");
double amount = Double.parseDouble(request.getParameter("amount"));
String address = request.getParameter("addrs");
long mobile_no = Long.parseLong(request.getParameter("mno"));
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","defdb","defdb");
if(password.equals(confirm_password)){
PreparedStatement ps = con.prepareStatement("insert into sdfc_bank_account_info values(?,?,?,?,?,?,?)");
ps.setLong(1,account_no);
ps.setString(2,name);
ps.setString(3,password);
ps.setString(4,confirm_password);
ps.setDouble(5,amount);
ps.setString(6,address);
ps.setLong(7,mobile_no);
int i = ps.executeUpdate();
out.print(i+"Record Inserted Successfully...");
}
else
	out.print("please Reconfirm your password");
con.close();
}
catch(Exception e){
	out.print(e);
}
%>
</body>
</html>