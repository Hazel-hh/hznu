<!-- 
	作者：谢岚
	日期：2017/5/11
	任务：增加班级信息的模块
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.database.db.DBConnection"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>增加班级信息</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<!-- table -->

<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!-- 导航js -->

<script src="js/modernizr.js"></script>

<style type="text/css">
.company {
	height: 40px;
}

.user {
	height: 40px;
}

.icon {
	height: 50px;
}

.main {
	height: 890px;
}

.left {
	height: 800px;
}

.left .line {
	height: 840px;
}
</style>


</head>
<body>


	<!--header开始-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header结束-->

	<div class="main">
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>
		<div class="tableArea">
			<div class="cTitle">
				<label>添加班级</label>
			</div>
			<div class="zzsc-container"
				style="margin-top: 50px; margin-bottom: 20px; height: 70%">
				<form class="cd-form floating-labels" action="AddClassServlet"
				method="post">

				<fieldset>
					<legend>增加班级信息</legend>
					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-name">班级 ID：</label> <input
							class="user" type="text" name="class_id" style="height: 50px;"
							required>
					</div>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company" maxlength="30">班级名称：</label> <input
							class="company" type="text" name="class_name"
							style="height: 50px;" required>
					</div>




					<div class="icon" style="margin-top: 30px;">
					
					<input list="deptList" placeholder="所属专业" maxlength="30" class="input company " style="font-size: 1.1rem;color: #94aab0;font-weight: bold;height: 50px;"
						type="text" tabindex="2"  name="major_id" required />
					<datalist id="deptList" class="budget">						
						<%
						DBConnection dbc1 = new DBConnection();
						dbc1.createConnection();						
						String classSql = "select * from major";//查询材料语句
						ResultSet classRs = dbc1.queryForRS(classSql);
						if(classRs != null){
							while (classRs.next()) {
								String majorName = classRs.getString("major_name");
								String majorID = classRs.getString("major_id");
								%>
								<option label="<%=majorName%>" value="<%=majorID%>" />
						<%
								}
							}
							dbc1.close();
						%>
					</datalist>
					
					</div>
					

					<div class="icon">
						<label class="cd-label" for="cd-textarea" style="height: 50%;">备注：</label>
						<textarea class="message" type="text" name="class_note"></textarea>
					</div>



					<div style="margin-top:160px">
						<input type="submit" value="添加班级"
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
	<hr>
		<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer 结束-->
</body>
<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
<!-- Resource jQuery -->
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
</html>