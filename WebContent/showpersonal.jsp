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
<title>普通用户显示界面</title>
</head>
<style>
	#end{
	position:absolute;
	top:0px;
	right:0px;
	}
</style>
<body background="2.jpg" style="background-repeat:no-repeat;background-size:100%;">
	<div id="end">
	<a href="index.jsp">
    <button style="color:red;">退出系统</button></a>
	</div>
	
	<%
		String message = (String) request.getAttribute("message");
		if (!(message == null || message.equals(""))) {
	%>
	<script>
		alert("<%=message%>")
	</script>
	<%
		}
	%>
	<h1 align="center">停车场欢迎您！</h1>
	<%
		request.setCharacterEncoding("utf-8");
		Class.forName("com.mysql.jdbc.Driver");
		//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/parkinglotmis", "root",
				//"szj123456");
		//Statement stmt = con.createStatement();
		Connection con = DBUtil.getConn();
		PreparedStatement stmt = con.prepareStatement("select * from parkinginfo");
		ResultSet rs = stmt.executeQuery();
		//ResultSet rs = stmt.executeQuery("select * from parkinginfo");
		List<String> num = new ArrayList<String>();
		List<String> location = new ArrayList<String>();
		while (rs.next()) {
			num.add(rs.getString(1));
			location.add(rs.getString(2));
		}
	%>
	<table align="center" border="1" width="300px" height="40px">
		<tr>
			<th colspan="2"><h3 align="center">停车场目前停车信息：</h3></th>
		</tr>
		<tr>
			<th><div style="color: blue; text-align: center;">车牌</div></th>
			<th><div style="color: blue; text-align: center;">位置</div></th>
		</tr>

		<%
			for (int i = 0; i < num.size(); i++) {
		%>
		<tr>
			<th><%=num.get(i)%></th>
			<th><%=location.get(i)%></th>
		</tr>
		<%
			}
			rs.close();
			stmt.close();
			con.close();
		%>
	</table>
	<br>
	<form method="post" action="operate?method=search">
		<div align="center">输入您的车牌号查询停车位置：</div>
		<div align="center"><input type="text" id="carcard" name="carcard">
		<input type="submit" value="查找"></div>
	</form>
</body>
</html>