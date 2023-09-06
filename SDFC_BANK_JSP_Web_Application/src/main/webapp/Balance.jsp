<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","defdb","defdb");
PreparedStatement ps = con.prepareStatement("select account_no,name,amount from sdfc_bank_account_info where account_no=? and name=? and password=?");
ps.setLong(1,account_no);
ps.setString(2,name);
ps.setString(3,password);
ResultSet rs = ps.executeQuery();
ResultSetMetaData rsmd = rs.getMetaData();
out.print("<table border='1'>");
int n = rsmd.getColumnCount();
for(int i=1;i<=n;i++){
	out.print("<td> <font color:blue size=3>"+"<br>"+rsmd.getColumnName(i));
}
out.print("<tr>");
while(rs.next()){
	for(int i=1;i<=n;i++){
		out.print("<td><br>"+rs.getString(i));
	}
	out.print("<tr>");
}
out.print("</table");
con.close();
}
catch(Exception e){
	out.print(e);
}

%>
</body>
</html>