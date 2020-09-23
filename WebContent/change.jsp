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
<title>添加停车信息</title>
<style>
.demo {
	width: 150px;
	height: 20px;
}

hr {
	width: 280px;
	height: 5px;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body background="2.jpg" style="background-repeat:no-repeat;background-size:100%;">
	<h1 align="center">停车场管理系统</h1>
	<%
		String message = (String) request.getAttribute("message");
		if (!(message == null || message.equals(""))) {
	%>
	<script>alert("<%=message%>")
	</script>
	<%
		}
	%>

	<%
		request.setCharacterEncoding("utf-8");
		Class.forName("com.mysql.jdbc.Driver");
		//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/parkinglotmis", "root",
				//"szj123456");
		//Statement stmt = con.createStatement();
		//ResultSet rs = stmt.executeQuery("select * from parkingorder where state=" + "0");
		Connection con = DBUtil.getConn();
		PreparedStatement stmt = con.prepareStatement("select * from parkingorder where state=" + "0");
		ResultSet rs = stmt.executeQuery();
		List<String> empty = new ArrayList<String>();
		while (rs.next()) {
			empty.add(rs.getString(1));
		}
	%>
	<h3 align="center" style="color: darkgreen;">当前空停车位编号：</h3>
	<div style="text-align: center;">
		<%
			int j = 0;
			for (int i = 0; i < empty.size(); i++) {
		%>
		<input type="button" value="<%=empty.get(i)%>"
			style="width: 40px; color: green;">
		<%
			j++;
				if (j % 5 == 0) {
		%>
		<br>
		<%
			}
			}
		%>
		<%
			List<String> chepai = new ArrayList<String>();
			List<String> weizhi = new ArrayList<String>();
			request.setCharacterEncoding("utf-8");
			String location = request.getParameter("changelocation");
			Statement stmt1 = con.createStatement();
			ResultSet rs1 = stmt1.executeQuery("select * from parkinginfo where location=" + location);
			while(rs1.next())
			{
				chepai.add(rs1.getString(1));
				weizhi.add(rs1.getString(2));
			}
		%>

	</div>
	<hr color="grey">
	<form method="post" action="operate?method=change" onsubmit="return check()">
		<div style="text-align: center;">
			<table align="center" border="1" style="margin: auto；" width='30%'>
				<tr>
					<td>车牌号：</td>
					<td><input type="text" id="num" name="num" class="demo"
						value="<%=chepai.get(0)%>" onblur="if (!/^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/.test(value)) value =''"></td>
				</tr>
				<tr>
					<td>停车位编号：</td>
					<td><input type="text" id="location" name="location"
						class="demo" value="<%=weizhi.get(0)%>"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="hidden" id="realnum"
						name="realnum" value="<%=chepai.get(0)%>"> <input
						type="hidden" id="reallocation" name="reallocation"
						value="<%=weizhi.get(0)%>"> <input type="submit"
						value="修改">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
						href="display.jsp"><input type="button" value="取消"></a></td>
				</tr>
			</table>
		</div>
	</form>
	<script>
		function check()
		{
			var num=document.getElementById("num");
			if(num.value=="")
			{
				alert("请输入正确格式的车牌号!形如：（冀A12345）");
				num.focus();
				return false;
			}
			var location=document.getElementById("location");
			if(location.value=="")
			{
				alert("请输入停车位置");
				location.focus();
				return false;
			}
			var charlocation=location.value.toLowerCase();
			for(var i=0;i<location.value.length;i++) {
				var charlocal=charlocation.charAt(i);
				if (!(charlocal>=0&&charlocal<=9))
				{
					alert("停车位置格式输入有误，请从上方空车位序号选择");
					location.select();
					return false;
				}
			}
			
		}

	</script>
	<div align="center">
		<a href="main.jsp">返回首页</a>
	</div>
	<%
		rs1.close();
		rs.close();
		con.close();
		stmt.close();
	%>
</body>
</html>