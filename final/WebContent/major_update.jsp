<!-- 
	作者：谢岚
	日期：2017/5/24
	任务：修改专业信息
	版本：1.0
 -->

<%@ page language="java" import="java.util.*,com.database.db.*"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.database.db.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<%
	request.setCharacterEncoding("utf-8");
%>
<title>修改专业信息</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<!-- 
    <link rel="stylesheet" type="text/css" href="styles.css"> 
    -->
<script src="js/jquery.min.js" type="text/javascript"></script>

<link rel="stylesheet" href="font-awesome/css/font-awesome.css">

<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
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
			height:1000px;
		}
		.left{
			height:760px;
		}
		.left .line{
			height:950px;
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
				<label>专业信息</label>
			</div>
			
			<%
		DBConnection dbc = new DBConnection();
		dbc.createConnection();
	%>	
			<div class="zzsc-container"
			style="margin-top: 50px; margin-bottom: 20px; height: 70%">

			<form class="cd-form floating-labels" action="UpdateMajorServlet"
				method="post">

				<%
					String id = request.getParameter("id");
					System.out.println(id);
					String pass = null;
					try {

						String sql = "select * FROM major where id=" + id;
						System.out.println(sql);
						ResultSet rs = dbc.queryForRS(sql);
						rs.last();
						int size = rs.getRow();

						int count = 0;
						do {

							String major_id = rs.getString("major_id"); //从表单获得 
							String major_name = rs.getString("major_name"); //从表单获得 
							String major_introduction = rs.getString("major_introduction"); //从表单获得 
							String dept_id = rs.getString("dept_id"); //从表单获得 
							String major_note = rs.getString("major_note"); //从表单获得
				%>
				<fieldset>
					<legend>修改专业信息</legend>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-name">编号：</label> <input
							class="user" type="text" name="id" value="<%=id%>"
							style="height: 50px;" readonly>
					</div>
					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-name">专业 ID：</label> <input
							class="user" type="text" name="major_id" value="<%=major_id%>"
							style="height: 50px;" required>
					</div>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">专业名称：</label> <input
							class="company" type="text" name="major_name"
							style="height: 50px;" value="<%=major_name%>" required>
					</div>

					<div class="icon" style="margin-top: 30px;">
						<label class="cd-label" for="cd-company">专业说明：</label> <input
							class="company" type="text" name="major_introduction"
							style="height: 50px;" value="<%=major_introduction%>">
					</div>


					<div class="icon" style="margin-top: 30px;">

						<input list="deptList" placeholder="所属系部ID:"
							class="input company "
							style="font-size: 1.1rem; color: #94aab0; font-weight: bold; height: 50px;"
							type="text" name="dept_id" value="<%=dept_id%>" />
						<datalist id="deptList" class="budget"> <%
 			DBConnection dbc1 = new DBConnection();
 			dbc1.createConnection();
 			String deptSql = "select * from dept";//查询材料语句
 			ResultSet deptRs = dbc1.queryForRS(deptSql);
 			if (deptRs != null) {
 				while (deptRs.next()) {
 					String deptName = deptRs.getString("dept_name");
 					String deptID = deptRs.getString("dept_id");
 %>
						<option label="<%=deptName%>" value="<%=deptID%>" />
						<%
							}
									}
									dbc1.close();
						%> </datalist>

					</div>


					<div class="icon">
						<label class="cd-label" for="cd-textarea" style="height: 50%;">备注：</label>
						<input class="message" type="text" name="major_note"
							value="<%=major_note%>"></input>
					</div>



					<div style="margin-top: 160px">
						<input type="submit" value="确认修改"
							style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1; margin-top: -200px;"
							class="btn btn-primary"> <input type="reset" value="取消"
							style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1; margin-top: -200px;"
							class="btn btn-primary" href="major_query.jsp">
					</div>
				</fieldset>



				<%
					} while (rs.next());
						dbc.close();
					} catch (Exception e) {
					}
				%>
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
