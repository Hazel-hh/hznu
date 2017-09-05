<!-- 
	作者：余欣
	日期：2017/5/15
	任务：学生信息管理--查看详情页
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.database.db.StudentDao"%>
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="com.bean.Student"%>
	<%@page import="java.util.*"%>
	<%@page import="java.net.*"%>
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
<link rel="stylesheet" href="css/tableArea.css">
<link rel="stylesheet" href="css/releaseTask.css">
<link rel="stylesheet" href="css/addStudent.css">
<link rel="stylesheet" href="css/left.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<style type="text/css">
	.main{
		height:900px;
	}
	.left{
		height:760px;
	}
	.left .line{
		height:850px;
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
	<% request.setCharacterEncoding("UTF-8");%>
	<jsp:useBean id="Student" class="com.bean.Student">
	</jsp:useBean>
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>
		<div class="tableArea">
		<div class="cTitle">
				<label>查看学生</label>
		</div>
		<div class="content" style="margin-left:30px;">
		<form  method="get" action="student.jsp" id="task">
			<%StudentDao dao = new StudentDao();
			String number=request.getParameter("taskId");
			number = URLDecoder.decode(number,"UTF-8");
			System.out.println(number);
			String student_no=dao.findByStudent_name(number).getStudent_no();
			String student_name=dao.findByStudent_name(number).getStudent_name();
			String password=dao.findByStudent_name(number).getPassword();
			String gender=dao.findByStudent_name(number).getGender();
			String birthday=dao.findByStudent_name(number).getBirthday();
			String dept_id=dao.findByStudent_name(number).getDept_name();
			String major_id=dao.findByStudent_name(number).getMajor_name();
			String grade=dao.findByStudent_name(number).getGrade();	
			String class_id=dao.findByStudent_name(number).getClass_name();
			String mobile=dao.findByStudent_name(number).getMobile();
			String email=dao.findByStudent_name(number).getEmail();
			String student_note=dao.findByStudent_name(number).getStudent_note();
			dao.close();
			%>
			<h3>学生信息</h3>
						<fieldset>
							姓名：<input  value=<%=student_name %> 
								tabindex="1" class="stupwd" readonly>
							学号：<input value=<%=student_no %> name="student_no"
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
								tabindex="5" class="birthday" readonly>
							系名：<input value=<%=dept_id %> 
								 tabindex="6"  class="sdept" readonly>
							专业：<input value=<%=major_id %> class="major"
								tabindex="7" readonly>
						</fieldset>
						
						<fieldset>
							年级：<input value=<%=grade %> class="input"
								tabindex="8" readonly>
							
						</fieldset>
						<fieldset>
							班级：<input value=<%=class_id %> class="input"
								tabindex="9" readonly>
							
						</fieldset>
						<fieldset>
							手机：<input value=<%=mobile %> class="input"
								tabindex="10" readonly>
							
						</fieldset>
						<fieldset>
							邮箱：<input value=<%=email %> class="input"
								tabindex="11" readonly>
							
						</fieldset>
						<fieldset>
							备注：<textarea tabindex="12" readonly><%=student_note %></textarea>
						</fieldset>
						<fieldset>
							<button name="submit" type="submit" id="contact-submit"
								data-submit="...Sending">关闭</button>
						</fieldset>
			
			</table>
		</form>
		</div>
		</div>
	</div><!-- main结束 -->
	<hr>
	<!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>
</html>