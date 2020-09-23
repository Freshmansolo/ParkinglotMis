<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%
	String message = (String) request.getAttribute("message");
	if (!(message == null || message.equals(""))) {
%>
<script>alert("<%=message%>")
</script>
<%
	}
%>
<style>
#end {
	position: absolute;
	top: 0px;
	right: 0px;
}
</style>
</head>
<body background="2.jpg" style="background-repeat:no-repeat;background-size:100%;text-align: center;;">
	<div id="end">
		<a href="index.jsp">
			<button style="color: red;">退出系统</button>
		</a>
	</div>
	<h1 align="center">停车场管理系统</h1>
	<a href="add.jsp">入库车辆信息</a>
	<br>
	<br>
	<a href="display.jsp">当前停车场停车信息</a>
</body>
</html>