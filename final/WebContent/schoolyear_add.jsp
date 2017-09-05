<!-- 
	作者：谢岚
	日期：2017/5/23
	任务：增加学年学期信息
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>增加学年学期信息</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<script src="js/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<!-- 导航js -->
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/modernizr.js"></script>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
/*  判断学年格式是否正确    */
function panduan() {
	var str = document.getElementById("teaching_year").value;
	var pattern = /(?!0000)[0-9]{4}-(?!0000)[0-9]{4}/;
	 
	if (pattern.test(str))
	//2个值比较，做判断 
	{
		alert("学年成功")
		//输出对话框提示
		document.getElementById("str").focus()
		//焦点定位 
	} else
	//否则
	{
		alert("学年格式错误")
		//输出对话框提示 
		document.getElementById("str").focus()
		//焦点定位 
	}
}
</script>
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
input::-webkit-input-placeholder { /*WebKit browsers*/
	color: #94aab0;
}

input::-moz-input-placeholder { /*Mozilla Firefox*/
	color: #94aab0;
}

input::-ms-input-placeholder { /*Internet Explorer*/
	color: #94aab0;
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
	<div class="main">
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>
		<div class="tableArea">
			<div class="cTitle">
				<label>新增学年</label>
			</div>
			<div class="zzsc-container"
			style="margin-top: 50px; margin-bottom: 20px; height: 70%">

			<form class="cd-form floating-labels" action="AddSchoolYearServlet"
				method="post">

				<fieldset>
					<legend>添加学年学期信息</legend>
					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-name">学年：</label> <input
							class="user" type="text" name="teaching_year"
							style="height: 50px;" required>
					</div>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">学期：</label> <input
							class="company" type="text" name="semester" style="height: 50px;"
							required>
					</div>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">开始日期：</label> <input
							class="company" type="date" name="start_date"
							style="height: 50px;" required>
					</div>


					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">结束日期：</label> <input
							class="company" type="date" name="end_date" style="height: 50px;"
							required>
					</div>

					<div style="margin-top: 50px">
						<input type="submit" value="确认添加"
							style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1;"
							class="btn btn-primary" onclick="panduan()"> <input type="reset" value="重置"
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
<script src="js/main.js"></script>
</html>