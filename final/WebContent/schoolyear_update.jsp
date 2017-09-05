<!-- 
	作者：谢岚
	日期：2017/5/25
	任务：修改学年学期信息
	版本：1.0
 -->

<%@ page language="java" import="java.util.*,com.database.db.*"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<%
	request.setCharacterEncoding("utf-8");
%>
<title>修改学年学期信息</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">

<script src="js/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
 	<!-- 导航 -->
	<link rel="stylesheet" href="css/footer.css">
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

<body bgcolor="#CED3FE">
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
			<!--  数据库连接-->
	<%
		DBConnection dbc = new DBConnection();
		dbc.createConnection();
	%>
			
	<div class="zzsc-container"
			style="margin-top: 50px; margin-bottom: 20px; height: 70%">

			<form class="cd-form floating-labels"
				action="UpdateSchoolYearServlet" method="post">
				<!--从数据库获取学年学期的信息-->
				<%
					try {
						String id = request.getParameter("id");
						System.out.println(id);
						String pass = null;

						String sql = "select * FROM tyear_sem where id=" + id + ";";
						System.out.println(sql);
						ResultSet rs = dbc.queryForRS(sql);
						rs.last();
						int size = rs.getRow();

						int count = 0;
						do {
							String teaching_year = rs.getString("teaching_year"); //从表单获得 
							String semester = rs.getString("semester"); //从表单获得 
							String start_date = rs.getString("start_date"); //从表单获得 
							String end_date = rs.getString("end_date"); //从表单获得
				%>
				<fieldset>
					<legend>修改学年学期信息</legend>
					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-name">编号：</label> <input
							class="user" type="text" name="id" value="<%=id%>"
							style="height: 50px;" readonly>
					</div>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-name">学年：</label> <input
							class="user" type="text" name="teaching_year"
							value="<%=teaching_year%>" style="height: 50px;" required>
					</div>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">学期：</label> <input
							class="company" type="text" name="semester" style="height: 50px;width:100%;"
							value="<%=semester%>" required>
					</div>
					<!--开始日期和结束日期：type为date-->
					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">开始日期：</label> <input
							class="company" type="date" name="start_date"
							value="<%=start_date%>" style="height: 50px;width:100%" required>
					</div>


					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">结束日期：</label> <input
							class="company" type="date" name="end_date" style="height: 50px;width:100%"
							value="<%=end_date%>" required>
					</div>
					<!--开始日期和结束日期：type为date结束-->
					<div style="margin-top: 160px">
						<input type="submit" value="确认修改"
							style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1; margin-top: -200px;"
							class="btn btn-primary"> <input type="reset" value="取消"
							style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1; margin-top: -200px;"
							class="btn btn-primary" href="schoolyear_query.jsp">
					</div>
				</fieldset>


				<%
					} while (rs.next());
						dbc.close();
					} catch (Exception e) {
					}
				%>
				<!--从数据库获取学年学期的信息结束-->
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
