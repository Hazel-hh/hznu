<!-- 
	作者：谢岚
	日期：2017/5/11
	任务：增加系部信息的静态模块
	版本：1.0
 -->
<!-- 
	作者：谢岚
	日期：2017/5/23
	任务：成功添加到数据库并跳转到查询界面
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<script src="js/jquery.min.js" type="text/javascript"></script>

<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
<!-- 导航js -->
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<script src="js/modernizr.js"></script>
<style type="text/css">
.main {
	height: 860px;
}

.left {
	height: 760px;
}

.left .line {
	height: 810px;
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
	<jsp:include page="checkAdmin.jsp"></jsp:include>
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
				<label>添加系别</label>
			</div>
			<div class="zzsc-container"
				style="margin-top: 50px; margin-bottom: 20px; height: 70%">

				<form class="cd-form floating-labels" action="AddDeptServlet"
					method="post">

					<fieldset>
						<legend>添加系部信息</legend>
						<div class="icon" style="margin-top: 30px;">
							<label class="cd-label" for="cd-name">系部 ID：</label> <input
								class="user" type="text" name="dept_id" style="height: 50px;"
								required>
						</div>

						<div class="icon" style="margin-top: 30px;">
							<label class="cd-label" for="cd-company">系部名称：</label> <input
								class="company" type="text" name="dept_name"
								style="height: 50px;" required>
						</div>

						<div class="icon">
							<label class="cd-label" for="cd-textarea" style="height: 50%;">系部说明：</label>
							<input class="message" type="text" name="dept_introduction"
								id="cd-email" style="height: 50px;">
						</div>

						<div class="icon">
							<label class="cd-label" for="cd-textarea" style="height: 50%;">备注：</label>
							<textarea class="message" type="text" name="dept_note"></textarea>
						</div>

						<div style="margin-top: 160px">
							<input type="submit" value="添加系别"
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

	<hr />
	<!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->



</body>
<script src="js/main.js"></script>
</html>