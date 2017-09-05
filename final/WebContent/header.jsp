<!-- 
	作者：何红春
	日期：2017/5/6
	任务：公共页-首页导航栏以及轮播图以及个人信息模块
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userNo = "";
	if (session.getAttribute("userNo") != null) {
		userNo = session.getAttribute("userNo").toString();
	}
	String userName = "";
	if(session.getAttribute("userName")!= null){
		userName = session.getAttribute("userName").toString();
		System.out.println(userName);
	}
%>
<!-- wrapper开始 -->
<div class="wrapper" id="wrapper">
	<div class="bg-white"></div>
	<!-- header开始 -->
	<header class="header">
		<div class="container">
			<ul class="nav">
				<li class="nav-item"><a href="index.jsp">首页</a></li>
				<li class="nav-item"><a href="courseClass.jsp">课表管理</a></li>
				<li class="nav-item"><a href="users_query.jsp">用户管理</a>
				</li>
				<li class="nav-item" data-subNav="nav_info"><a href="dept_query.jsp">信息管理</a>
				</li>
				<li class="nav-item" data-subNav="nav_TeaM"><a href="materialsTable.jsp">教学材料管理</a>
				</li>
				<li class="nav-item"><a href="teacher.jsp">教师管理</a></li>
				<li class="nav-item"><a href="student.jsp">学生管理</a></li>
				<li class="nav-item" data-subNav="nav_Teacher"><a href="teacherTask.jsp">教师专区</a></li>
			</ul>
			<div class="user">
				<div class="user-hover"></div>
				<div class="user-img">
					<img src='images/nav/user.png' alt='#'> <span class="arrow-bg"></span>
					<span class="arrow-font"></span>
				</div>
				<hr width="90%" />
				<div class="user-info">
					<ul>
						<%
							if (session.getAttribute("userNo") != null) {
								out.print("<li class=''><img src='images/nav/4-3.png'/>" + userName + "</li>");
								out.print(
										"<li class='logout'><a href='logout.jsp' id='logout' class='logout' ><img src='images/nav/4-2.png' class='loginImg'/>退出登录</a></li>");
							} else {
						%>
						<li class='#'><a href='#'></a></li>
						<li class='#'><a href='#'></a></li>
						<li class='logout'><a href='#' id='loginBtn'
							onclick="openLogin();"><img src='images/nav/4-4.png' class="loginImg"/>立即登陆</a></li>
						<%
							}
						%>
					</ul>
				</div>
			</div>
		</div>
	</header>
	<!-- header结束 -->

	<!-- sub-nav开始 -->
	<div class="sub-nav">
		<div class="sub-nav__wrap" data-link="nav_info">
			<a href="dept_query.jsp"> <img src="images/nav/2-1.png" alt="view" /> <span>系部管理</span>
			</a> <a href="major_query.jsp"> <img src="images/nav/2-2.png" alt="view" /> <span>专业管理</span>
			</a> <a href="class_query.jsp"> <img src="images/nav/2-3.png" alt="view" /> <span>班级管理</span>
			</a> <a href="schoolyear_query.jsp"> <img src="images/nav/2-4.png" alt="view" /> <span>学年学期管理</span>
			</a>
			</a>
		</div>
		<div class="sub-nav__wrap" data-link="nav_TeaM">
			<a href="tmtype.jsp"> <img src="images/nav/3-1.png" alt="view" /> <span>类型管理</span>
			</a> <a href="template.jsp"> <img src="images/nav/3-2.png" alt="view" /> <span>模板管理</span>
			</a> <a href="taskTable.jsp"> <img src="images/nav/3-3.png" alt="view" /> <span>提交任务管理</span>
			</a> <a href="materialsTable.jsp"> <img src="images/nav/3-4.png" alt="view" /> <span>材料管理</span>
			</a> <a href="materialsTable.jsp#statisticMaterials"> <img src="images/nav/3-5.png" alt="view" /> <span>汇总教学材料</span>
			</a>
		</div>
		<div class="sub-nav__wrap" data-link="nav_Teacher">
			<a href="teacherTask.jsp"> <img src="images/nav/3-1.png" alt="view" /> <span>任务列表</span>
			</a> <a href="downloadTemplate.jsp"> <img src="images/nav/3-2.png" alt="view" /> <span>模板下载</span>
			</a> <a href="teacherMaterials.jsp"> <img src="images/nav/3-5.png" alt="view" /> <span>教学材料</span>
			</a>
		</div>
	</div>
	<!-- sub-nav结束 -->
</div>
<!-- wrapper结束 -->
