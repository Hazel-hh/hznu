<!-- 
	作者：何红春
	日期：2017/5/6
	任务：首页以及登录模块
	版本：1.3
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>index</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/login.css">


</head>
<body>
	<!--header开始-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header结束-->

	<!-- login开始 -->
	<div class="login">
		<div id="back" id=back
			style="display: none; POSITION: absolute; left: 0; top: 0; width: 100%; height: 100%; background-color: #525252; filter: alpha(opacity = 10); opacity: 0.60; z-index: 10">
		</div>
		<div id="win"
			style="display: none; POSITION: absolute; background-color: #f1f1f1; left: 50%; top: 50%; width: 600px; height: 400px; margin-left: -300px; margin-top: -200px; text-align: center; z-index: 11;">

			<a href="javascript:closeLogin();"><img src="images/nav/cancle.png" /></a>
			<h1>用户登录</h1>

			<form method="post" onsubmit="return check();" action="loginDeal.jsp">
				<input type="text" required="required" placeholder="用户名"
					name="userno" id="username"></input> <input type="password"
					required="required" placeholder="密码" name="password" id="password"></input>
				
				<input type="radio" id="userType" name="userType" value="admin"><span>管理员</span>
				<input type="radio" id="teacher" name="userType" value="teacher"><span>教师</span>
				<br />
				<button class="subBtn" type="submit" id="subBtn" >登录</button>
				<button class="resetBtn" type="reset">重置</button>
			</form>
		</div>
	</div>
	<!-- login结束-->

	
	<!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>
<script src="js/jquery.min.js"></script>
<script src="js/slider.js"></script>
<script src="js/navChange.js"></script>
<script type="text/javascript" src="js/loginBtn.js"></script>
</html>