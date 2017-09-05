<!-- 
	作者：谢岚
	日期：2017/5/11
	任务：增加专业信息的模块
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.database.db.DBConnection"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>增加专业信息</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<script src="js/jquery.min.js" type="text/javascript"></script>

<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!-- 导航js -->
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<!-- 导航js -->

<script src="js/modernizr.js"></script>
<style type="text/css">
.main {
	height: 920px;
}

.left {
	height: 760px;
}

.left .line {
	height: 870px;
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
				<label>添加系别</label>
			</div>
			<div class="zzsc-container"
			style="margin-top: 50px; margin-bottom: 20px; height: 70%">

			<form class="cd-form floating-labels" action="AddMajorServlet"
				method="post">

				<fieldset>
					<legend>添加专业信息</legend>
					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-name">专业 ID：</label> <input
							class="user" type="text" name="major_id" style="height: 50px;"
							required>
					</div>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">专业名称：</label> <input
							class="company" type="text" name="major_name"
							style="height: 50px;" required>
					</div>

					<div class="icon">
						<label class="cd-label" for="cd-textarea" style="height: 50%;">专业说明：</label>
						<input class="message" type="text" name="major_introduction"
							id="cd-email" style="height: 50px;">
					</div>


					
					<div class="icon" style="margin-top: 30px;">
					
					<input list="deptList" placeholder="所属系部ID" class="input company " style="font-size: 1.1rem;color: #94aab0;font-weight: bold;height: 50px;"
						type="text" tabindex="2"  name="dept_id" required />
					<datalist id="deptList" class="budget">						
						<%
						DBConnection dbc1 = new DBConnection();
						dbc1.createConnection();						
						String deptSql = "select * from dept";//查询材料语句
						ResultSet deptRs = dbc1.queryForRS(deptSql);
						if(deptRs != null){
							while (deptRs.next()) {
								String deptName = deptRs.getString("dept_name");
								String deptID = deptRs.getString("dept_id");
								%>
								<option label="<%=deptName%>" value="<%=deptID%>" />
						<%
								}
							}
							dbc1.close();
						%>
					</datalist>
					
					</div>
			
					<div class="icon">
						<label class="cd-label" for="cd-textarea" style="height: 50%;">备注：</label>
						<textarea class="message" type="text" name="major_note"></textarea>
					</div>

					<div style="margin-top: 160px">
						<input type="submit" value="添加专业"
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