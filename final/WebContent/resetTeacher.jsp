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
<title>resetTeacher</title>
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<!-- 导航栏 -->
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="css/releaseTask.css">
<link rel="stylesheet" href="css/addStudent.css">
<link rel="stylesheet" href="css/tableArea.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<style type="text/css">
		.main{
			height:1280px;
		}
		.left{
			height:1100px;
		}
		.left .line{
			height:1210px;
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
				<label>修改教师</label>
			</div>
		<div class="content">
			<form id="task" action="resetTeacher" method="post">
			<%TeacherDao dao = new TeacherDao();
	String number=request.getParameter("taskId");
	//System.out.println(number);
	String teacher_no=dao.findByTeacher_name(number).getTeacher_no();
	String teacher_name=dao.findByTeacher_name(number).getTeacher_name();
	String password=dao.findByTeacher_name(number).getPassword();
	String gender=dao.findByTeacher_name(number).getGender();
	String birthday=dao.findByTeacher_name(number).getBirthday();
	String title=dao.findByTeacher_name(number).getTitle();
	String education=dao.findByTeacher_name(number).getEducation();
	String edu_university=dao.findByTeacher_name(number).getEdu_university();	
	String research_dir=dao.findByTeacher_name(number).getResearch_dir();
	String degree=dao.findByTeacher_name(number).getDegree();
	String deg_university=dao.findByTeacher_name(number).getDeg_university();
	String tel=dao.findByTeacher_name(number).getTel();
	String mobile=dao.findByTeacher_name(number).getMobile();
	String email=dao.findByTeacher_name(number).getEmail();
	String teacher_note=dao.findByTeacher_name(number).getTeacher_note();
	
	
	%>
	
				<h3>教师信息</h3>
				<fieldset>
					姓名：<input  value=<%=teacher_name %> name="teacher_name"
						tabindex="1" class="stupwd" required>
					工号：<input value=<%=teacher_no %> name="teacher_no"
						tabindex="2" class="stugender" required>
				</fieldset>
				
				<fieldset>
					密码：<input value="******" name="password"
						tabindex="3" class="stupwd" readonly>
					性别：<input value=<%=gender %> name="gender"
						tabindex="4" class="stugender" required>
					
				</fieldset>
				
				<fieldset>
					生日：<input value=<%=birthday %> name="birthday" type="date"
						tabindex="5" class="stupwd" required>
					职称：<input value=<%=title %> name="title"
						 tabindex="6"  class="stugender" required>
					
				</fieldset>
				<fieldset>
					最后学历：<input value=<%=education %> name="education" class="input"
						tabindex="6" required>
					
				</fieldset>
				<fieldset>
					最后学历毕业院校：<input value=<%=edu_university %> name="edu_university" class="input"
						tabindex="7" required>
					
				</fieldset>
				<fieldset>
					最后学位：<input value=<%=degree %> name="degree" class="input"
						tabindex="8" required>
					
				</fieldset>
				<fieldset>
					最后学位毕业院校：<input value=<%=deg_university %> name="deg_university" class="input"
						 tabindex="9" required>
					
				</fieldset>
				<fieldset>
					研究方向：<input value=<%=research_dir %> name="research_dir" class="input"
						tabindex="10" required>
					
				</fieldset>
				<fieldset>
					电话：<input value=<%=tel %> name="tel" class="input"
						tabindex="11" required>
					
				</fieldset>
				<fieldset>
					手机：<input value=<%=mobile %> name="mobile" class="input"
						tabindex="12" required>
					
				</fieldset>
				<fieldset>
					邮箱：<input value=<%=email %> name="email" class="input" type="email"
						tabindex="13" required>
					
				</fieldset>
				<fieldset>
					备注：<textarea name="teacher_note" tabindex="14" required><%=teacher_note %></textarea>
				</fieldset>
				<fieldset>
					<button name="submit" type="submit" id="contact-submit"
						data-submit="...Sending">提交</button>
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
</html>