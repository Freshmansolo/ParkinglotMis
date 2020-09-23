<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.DBUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>出库确认</title>
<style>
	h2{
		text-align:center;
	}
	div{
		text-align:center;
	}
</style>
</head>
<body background="2.jpg" style="background-repeat:no-repeat;background-size:100%;">
	<%
		request.setCharacterEncoding("utf-8");
		String location = request.getParameter("location");
		Class.forName("com.mysql.jdbc.Driver");
		//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/parkinglotmis", "root",
				//"szj123456");
		//Statement stmt = con.createStatement();	
		//int i=stmt.executeUpdate("delete from parkinginfo where location="+location);
		Connection con = DBUtil.getConn();
		PreparedStatement stmt = con.prepareStatement("delete from parkinginfo where location="+location);
		int i = stmt.executeUpdate();
		if(i==1)
		{
			out.println("<h2>出库成功！</h2><br/>");
			Statement stmt2 = con.createStatement();
			String sql="update parkingorder set state=0 where listnum="+location;
			stmt2.executeUpdate(sql);
		}
			else
		{
			out.println("<h2>出库失败！</h2><br/>");
		}
		out.println("<div><a href='main.jsp'>返回首页</a></div>");
		con.close();
		stmt.close();
		%>
</body>
</html>