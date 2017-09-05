<!-- 
	作者：余欣
	日期：2017/5/17
	任务：教师管理页面--新增
	版本：1.3
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="com.database.db.TeacherDao"%>
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="com.bean.Teacher"%>
	<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>addTeacher</title>
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<!-- 导航栏 -->
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<link rel="stylesheet" href="css/releaseTask.css">

<link rel="stylesheet" href="css/addStudent.css">
<link rel="stylesheet" href="css/left.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<style type="text/css">
		.main{
			height:1200px;
		}
		.left{
			height:1200px;
		}
		.left .line{
			height:1130px;
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
				<label>添加教师</label>
			</div>
			<div class="content" class="panel">
				<form id="task" action="addTeacher" method="post">
				<h3>教师信息</h3>
				<fieldset>
					姓名：<input  name="teacher_name"
						tabindex="1" class="stupwd" required>
					工号：<input  name="teacher_no"
						tabindex="2" class="stugender" required>
				</fieldset>
				
				<fieldset>
					密码：<input name="password"
						tabindex="3" class="stupwd" value="123456" readonly>
					性别：<select name="gender" class="stugender"  style="font-size:14px;" required>
						<option value="F">女</option>
						<option value="M">男</option>
						</select>
					
				</fieldset>
				
				<fieldset>
					生日：<input  name="birthday" type="date"
						tabindex="5" class="stupwd" required>
					职称：<input  name="title"
						 tabindex="6"  class="stugender" required>
					
				</fieldset>
				<fieldset>
					最后学历：<input name="education" class="input"
						tabindex="7" required>
					
				</fieldset>
				<fieldset>
					最后学历毕业院校：<input name="edu_university" class="input"
						tabindex="8" required>
					
				</fieldset>
				<fieldset>
					最后学位：<input name="degree" class="input"
						tabindex="9" required>
					
				</fieldset>
				<fieldset>
					最后学位毕业院校：<input name="deg_university" class="input"
						 tabindex="10" required>
					
				</fieldset>
				<fieldset>
					研究方向：<input name="research_dir" class="input"
						tabindex="11" required>
					
				</fieldset>
				<fieldset>
					电话：<input name="tel" class="input"
						tabindex="12" required>
					
				</fieldset>
				<fieldset>
					手机：<input name="mobile" class="input"
						tabindex="13" required>
					
				</fieldset>
				<fieldset>
					邮箱：<input name="email" class="input" type="email"
						tabindex="14" required>
					
				</fieldset>
				<fieldset>
					备注：<textarea name="teacher_note" tabindex="15" required></textarea>
				</fieldset>
				<fieldset>
					<button name="submit" type="submit" id="contact-submit"
						data-submit="...Sending">提交</button>
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
</html>