<!-- 
	作者：何红春
	日期：2017/5/19
	任务：任务发布页面
	版本：1.3
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>任务发布</title>
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!-- 导航栏 -->
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" href="css/tableArea.css">
<link rel="stylesheet" href="css/releaseTask.css">
<style type="text/css">
		.main{
			height:760px;
		}
		.left{
			height:760px;
		}
		.left .line{
			height:680px;
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

	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>	
	

	<!-- main开始 -->
	<div class="main">
		<div class="left">
		<jsp:include page="left.jsp"></jsp:include>
			</div> 
		<div class="tableArea">
			<div class="cTitle">
				<label>发布任务</label>
			</div>
		<div class="content" class="panel">
			<form id="task" action="addTask" method="post">
				<h3>任务发布</h3>
				<h4>请发布任务，并将任务发布给相应的老师。</h4>
				<fieldset>
					<input placeholder="任务名" type="text"
						tabindex="1" name="taskName" class="input" autofocus required>
				</fieldset>
				<fieldset>
					<input list="materialsList" placeholder="材料类型" class="input"
						type="text" tabindex="2" name="materialType" required />
					<datalist id="materialsList">						
						<%
						DBConnection dbc1 = new DBConnection();
						dbc1.createConnection();
						
						String materialsSql = "select * from tmtype";//查询材料语句
						ResultSet materialsRs = dbc1.queryForRS(materialsSql);
						if(materialsRs != null){
							while (materialsRs.next()) {
								String materialsName = materialsRs.getString("tm_type_name");
								String materialsID = materialsRs.getString("tm_type_id");
								%>
								<option label="<%=materialsName%>" value="<%=materialsID%>" />
						<%
								}
							}
							dbc1.close();
						%>
					</datalist>
				</fieldset>
				<fieldset>
					<input list="reveiverList" placeholder="教师" type="text"
						tabindex="3" class="input" name="teacherNo" required />	
					<datalist id="reveiverList">
						<%
						DBConnection dbc2 = new DBConnection();
						dbc2.createConnection();
						String teacherSql = "select * from teacher";
						ResultSet teacherRs = dbc2.queryForRS(teacherSql);
						if(teacherRs != null){
							while (teacherRs.next()) {
								String teacherName = teacherRs.getString("teacher_name");
								String teacherID = teacherRs.getString("teacher_no");
								%>
							<option label="<%=teacherName%>" value="<%=teacherID%>" />
					<%
							}
						}
						dbc2.close();
					%>
					</datalist>
				</fieldset>
				<fieldset>
					<input list="courseList" placeholder="课程名称" type="text"
						tabindex="4" class="input" name="courseId" required />
					<datalist id="courseList">
						<%
						DBConnection dbc3 = new DBConnection();
						dbc3.createConnection();
						String courseSql = "select * from course";
						ResultSet courseRs = dbc3.queryForRS(courseSql);
						if(courseRs != null){
							while (courseRs.next()) {
								String courseName = courseRs.getString("course_name");
								String courseID = courseRs.getString("course_id");
						%>
						<option label="<%=courseName%>" value="<%=courseID%>" />
						<%
							}
						}
						dbc3.close();
					%>
				</datalist>
				</fieldset>				
				<fieldset>
					<input list="yearList" placeholder="学年" type="text"
						tabindex="6" class="startDate" name="teachingYear" required />
					<datalist id="yearList">
						<%
						DBConnection dbc5 = new DBConnection();
						dbc5.createConnection();
						String yearSql = "select distinct(teaching_year) from tyear_sem";
						ResultSet yearRs = dbc5.queryForRS(yearSql);
							if(yearRs != null){
							while (yearRs.next()) {
								String year = yearRs.getString("teaching_year");
						%>
						<option label="第<%=year%>学年" value="<%=year%>" />
						<%
							}
						}
						dbc5.close();
					%>
				</datalist>
				
				<input list="semList" placeholder="学期" type="text"
						tabindex="7" class="endDate" name="semester" required>
					<datalist id="semList">						
						<option label="第1学期" value="1" />
						<option label="第2学期" value="2" />
				</datalist>
				</fieldset>
				<fieldset>
					<input placeholder="任务开始时间" name="startDate" type="text" class="startDate"
						onfocus="(this.type='date')" tabindex="8" min="2010-05-12"
						max="2018-05-12" required> 
						<input placeholder="任务截止时间" name="endDate"
						type="text" class="endDate" onfocus="(this.type='date')"
						tabindex="7" min="2010-06-12" max="2018-06-12" required>
				</fieldset>
				<fieldset>
					<textarea placeholder="任务说明..." name="remarks" tabindex="9" ></textarea>
				</fieldset>
				<fieldset>
					<button name="submit" type="submit" id="contact-submit"
						data-submit="...Sending">发布任务</button>
				</fieldset>
			</form>
		</div>	
		</div> 	
	</div>
	<!-- main结束 -->
	<hr>
	<!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>
<script src="js/jquery.min.js"></script>
<script src="js/navChange.js"></script>
<script src="js/nav.js"></script>

</html>