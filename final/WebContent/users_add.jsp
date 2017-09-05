<!-- 
	作者：谢岚
	日期：2017/5/11
	任务：增加用户的模块
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>addUser</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<script src="js/jquery.min.js" type="text/javascript"></script>

<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
<!-- 导航 -->
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!-- 导航js -->
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<script src="js/modernizr.js"></script>
<style type="text/css">
.main {
	height: 760px;
}

.left {
	height: 760px;
}

.left .line {
	height: 710px;
}

.company {
	height: 40px;
}

.user {
	height: 40px;
}

.icon {
	height: 50px;
}
</style>
</head>
<body>
	<!-- 检查用户是否登录 -->
	<%-- <jsp:include page="checkAdmin.jsp"></jsp:include> --%>
	<!-- 检查用户是否登录结束 -->


	<!--header开始-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header结束-->

	<!-- main -->
	<div class="main">
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>

		<div class="tableArea">
			<div class="cTitle">
				<label>添加用户</label>
			</div>
			<div class="zzsc-container"
				style="margin-top: 50px; margin-bottom: 20px; height: 70%">

				<form class="cd-form floating-labels" action="AddUserServlet"
					method="post">

					<fieldset>
						<legend>注册或添加用户</legend>
						<div class="icon" style="margin-top: 30px;">
							<label class="cd-label" for="cd-name">用户名：</label> <input
								class="user" type="text" name="userName" style="height: 50px;"
								required>
						</div>

						<div class="icon" style="margin-top: 30px;">
							<label class="cd-label" for="cd-company">密码：(默认123456)</label> <input
								class="company" type="password" name="passwd" value="123456" style="height: 50px;width:100%"
								required>
						</div>

						<div class="icon">
							<label class="cd-label" for="cd-textarea" style="height: 50%;">电子邮件：</label>
							<input class="email" type="email" name="email" id="cd-email"
								style="height: 50px;" required>
						</div>



						<div style="position:center">
							<h4 style="font-weight: bold;">用户级别</h4>
							<ul class="cd-form-list">
								<li><input type="radio" name="level" value="教师"
									sytle="font:14px;" checked> <label for="cd-radio-1"
									sytle="font:14px;" checked>教师</label></li>

								<li><input type="radio" name="level" value="学生"> <label
									for="cd-radio-2">学生</label></li>

								<li><input type="radio" name="level" value="系部管理员用户">
									<label for="cd-radio-3">系部管理员用户</label></li>
							</ul>
						</div>

						<div style="margin-top: 20px">
							<input type="submit" value="添加用户"
								style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1;"
								class="btn btn-primary"> <input type="reset" value="重置"
								style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1;"
								class="btn btn-primary">
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
	<hr>
	<!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/main.js"></script>
</html>