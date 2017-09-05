<!-- 
	作者：余欣
	日期：2017/5/20
	任务：教师管理页面--查看教师详情页
	版本：1.1
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
<title>checkTeacher</title>
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<!-- 导航栏 -->
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>

<link rel="stylesheet" href="css/releaseTask.css">
<link rel="stylesheet" href="css/addStudent.css">
<link rel="stylesheet" href="css/left.css">
<link rel="stylesheet" href="css/tableArea.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<style type="text/css">
	.main{
		height:1230px;
	}
	.left{
		height:1100px;
	}
	.left .line{
		height:1180px;
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
	
	<% request.setCharacterEncoding("UTF-8");%>
	<jsp:useBean id="Teacher" class="com.bean.Teacher">
	
	</jsp:useBean>
	
	<div class="main">
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>
		<div class="tableArea">
		<div class="cTitle">
				<label>教师信息</label>
		</div>
		<div class="tableArea">
		<div class="content" style="margin-left:-20%;margin-top:-3%;">
		<form  method="get" action="teacher.jsp" id="task">
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
			dao.close();
			%>
			
			<h3>教师信息</h3>
						<fieldset>
							姓名：<input  value=<%=teacher_name %> 
								tabindex="1" class="stupwd" readonly>
							工号：<input value=<%=teacher_no %> name="teacher_no"
								tabindex="2" class="stugender" readonly>
						</fieldset>
						
						<fieldset>
							密码：<input value=<%=password %> 
								tabindex="3" class="stupwd" readonly>
							性别：<input value=<%=gender %> name="gender"
								tabindex="4" class="stugender" readonly>
							
						</fieldset>
						
						<fieldset>
							生日：<input value=<%=birthday %>
								tabindex="5" class="stupwd" readonly>
							职称：<input value=<%=title %> name="title"
								 tabindex="6"  class="stugender" readonly>
							
						</fieldset>
						<fieldset>
							最后学历：<input value=<%=education %> class="input"
								tabindex="6" readonly>
							
						</fieldset>
						<fieldset>
							最后学历毕业院校：<input value=<%=edu_university %> class="input"
								tabindex="7" readonly>
							
						</fieldset>
						<fieldset>
							最后学位：<input value=<%=degree %> class="input"
								tabindex="8" readonly>
							
						</fieldset>
						<fieldset>
							最后学位毕业院校：<input value=<%=deg_university %> class="input"
								 tabindex="9" readonly>
							
						</fieldset>
						<fieldset>
							研究方向：<input value=<%=research_dir %> class="input"
								tabindex="10" readonly>
							
						</fieldset>
						<fieldset>
							电话：<input value=<%=tel %> class="input"
								tabindex="11" readonly>
							
						</fieldset>
						<fieldset>
							手机：<input value=<%=mobile %> class="input"
								tabindex="12" readonly>
							
						</fieldset>
						<fieldset>
							邮箱：<input value=<%=email %> class="input"
								tabindex="13" readonly>
							
						</fieldset>
						<fieldset>
							备注：<textarea tabindex="14" readonly><%=teacher_note %></textarea>
						</fieldset>
						<fieldset>
							<button name="submit" type="submit" id="contact-submit"
								data-submit="...Sending">关闭</button>
						</fieldset>
			</form>
			</div>
			</div>
			</div>
	</div><!-- main结束 -->
	<hr>
	<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>
</html>