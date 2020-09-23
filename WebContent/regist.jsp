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
<title>注册</title>
<style>
.demo {
	width: 150px;
	height: 20px;
	float:left;
}

.tian {
	color: red;
	float:right;
	width:150px;
}
#end {
	position: absolute;
	top: 0px;
	right: 0px;
}
</style>
</head>
<body background="2.jpg" style="background-repeat:no-repeat;background-size:100%;">
	<%
		String message = (String) request.getAttribute("message");
		if (!(message == null || message.equals(""))) {
	%>
	<script>alert("<%=message%>")
	</script>
	<%
		}
	%>
<h1 align="center">停车场管理系统</h1>
	<div id="end">
		<a href="index.jsp">
			<button style="color: red;">返回登录界面</button>
		</a>
	</div>
<form method="post" action="operate?method=regist" onsubmit="return check();">
	<div style="text-align: center;">
		<table align="center" border="1"  width='60%'>
			<tr>
				<td>用户名：</td>
				<td style="width:60%;"><input type="text" id="account" name="account" class="demo"
					onblur="check()"> <span id="div1" class="tian"></span></td>
					
			</tr>
			<tr>
				<td>密码：</td>
				<td><input type="password" id="code" name="code" class="demo"
					onblur="check()"> <span id="div2" class="tian"></span></td>
					
			</tr>
			<tr>
				<td>确认密码：</td>
				<td><input type="password" id="recode" name="recode" class="demo"
					onblur="check()"> <span id="div3" class="tian"></span></td>
					
			</tr>
			<tr>
				<td colspan="2"><input type="reset" value="重置">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" value="注册"></td>
			</tr>
		</table>
	</div>
	</form>
	<script type="text/javascript">
		function check() {
			var div=document.getElementById("div1");
			div.innerHTML="";
			var account=document.getElementById("account");
			if(account.value==" ") {
				div.innerHTML="用户名不能为空！";
				account.focus();
				return false;
			}
			var characcount1=account.value.toLowerCase();
			for(var i=0;i<account.value.length;i++) {
				var characcount=characcount1.charAt(i);
				if (!(characcount>=0&&characcount<=9)&&(!(characcount>='a'&&characcount<='z'))&&(characcount!='_'))
				{
					div.innerHTML="用户名包含非法字符！";
					account.select();
					return false;
				}
			}
			if (account.value.length<4||account.value.length>16) {
				div.innerHTML="长度4-16个字符！";
				account.select();
				return false;
			}
			
			var div = document.getElementById("div2");
			div.innerHTML="";
			var code=document.getElementById("code");
			if(code.value==" ") {
				div.innerHTML="密码不能为空！"
				code.focus();
				return false;
			}
			if(code.value.length<4||code.value.length>16) {
				div.innerHTML="密码长度4-16位！";
				code.select();
				return false;
			}
			var div=document.getElementById("div3");
			div.innerHTML="";
			var code=document.getElementById("code");
			var recode=document.getElementById("recode");
			if(recode.value==" ") {
				div.innerHTML="密码不能为空！"
				recode.focus();
				return false;
			}
			if(recode.value!=code.value) {
				div.innerHTML="密码不一致！";
				recode.select();
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
