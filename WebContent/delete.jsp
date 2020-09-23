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
<title>出库</title>
</head>
<body background="2.jpg" style="background-repeat:no-repeat;background-size:100%;">
	<h1 align="center">停车场管理系统</h1>
	<%
		request.setCharacterEncoding("utf-8");
		String location = request.getParameter("location");
		Class.forName("com.mysql.jdbc.Driver");
		//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/parkinglotmis", "root",
				//"szj123456");
		//Statement stmt = con.createStatement();
		//ResultSet rs = stmt.executeQuery("select * from parkinginfo where location=" + location);
		Connection con = DBUtil.getConn();
		PreparedStatement stmt = con.prepareStatement("select * from parkinginfo where location=" + location);
		ResultSet rs = stmt.executeQuery();
		rs.next();
	%>
	<table align="center" border="1" width="300px" height="40px">
		<tr>
			<th><div style="color: blue; text-align: center;">车牌</div></th>
			<th><div style="color: blue; text-align: center;">位置</div></th>
			<th><div style="color: blue; text-align: center;">操作</div></th>
		</tr>
		<tr>
			<th><%=rs.getString(1)%></th>
			<th><%=rs.getString(2)%></th>
			<th><a href="deletesave.jsp?location=<%=location%>">确认出库</a>/<a
				href="display.jsp">取消</a></th>
		</tr>
	</table>
	<%
		rs.close();
		stmt.close();
		con.close();
	%>
</body>
</html>