<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录</title>
<link href="style/background.css" rel="stylesheet" type="text/css" />
<style>
.demo {
	width: 150px;
	height: 20px;
}
</style>
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
	<form method="post" action="operate?method=login"
		onsubmit="return check()">
		<div style="text-align: center;">
			<table align="center" border="1" style="margin: auto；" width='30%'>
				<tr>
					<td>用户名：</td>
					<td><input type="text" id="account" name="account"
						class="demo"></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input type="password" id="code" name="code" class="demo"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="登录">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="regist.jsp"><input type="button" value="注册"></a>
					</td>
				</tr>
			</table>
		</div>
	</form>
	<script type="text/javascript">
		function check() {
			var account = document.getElementById("account");
			if (account.value == "") {
				alert("用户名不能为空！");
				account.focus();
				return false;
			}
			var code = document.getElementById("code");
			if (code.value == "") {
				alert("密码不能为空！");
				code.focus();
				return false;
			}
		}
	</script>
</body>
</html>