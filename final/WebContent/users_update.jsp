<!-- 
	作者：谢岚
	日期：2017/5/22
	任务：对用户信息进行修改（还没完成）(怎么update单选框的checked）
	版本：1.0
 -->

<%@ page language="java" import="java.util.*,com.database.db.*"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<%
	request.setCharacterEncoding("utf-8");
%>
<title>My JSP 'updateUser.jsp' starting page</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/modernizr.js"></script>
<script type="text/javascript">
	function panduan() {
		var mima1 = document.getElementById("mima1").value
		//取出第一个文本框里输如的值密码一 
		var mima2 = document.getElementById("mima2").value
		//取出第二个文本框里输如的值密码二 
		if (mima1 == mima2)
		//2个值比较，做判断 
		{
			alert("修改成功")
			//输出对话框提示
			document.getElementById("mima1").focus()
			//焦点定位 
		} else
		//否则
		{
			alert("密码和密码确认不同，请重新输入")
			//输出对话框提示 
			document.getElementById("mima1").focus()
			//焦点定位 
		}
	}
</script>
  <!-- 导航 -->
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<link rel="stylesheet" type="text/css" href="css/nav.css">
	<link rel="stylesheet" type="text/css" href="css/left.css">
	<!-- 表格样式 -->
	<link rel="stylesheet" type="text/css" href="css/tableArea.css">
	<!-- 导航js -->
   	<script src="js/nav.js"></script>
	<script src="js/navChange.js"></script>
	<style type="text/css">
		.main{
			height:950px;
		}
		.left{
			height:760px;
		}
		.left .line{
			height:900px;
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
				<label>用户信息</label>
			</div>
			<%
		DBConnection dbc = new DBConnection();
		dbc.createConnection();
	%>
	<div class="zzsc-container"
			style="margin-top: 50px; margin-bottom: 20px; height: 70%">

			<form class="cd-form floating-labels" action="UpdateUserServlet"
				method="post">

				<%
				String p_username = request.getParameter("userName");
					System.out.println(p_username);
					String pass = null;
					try {

						String sql = "select username,password,email,level FROM users where userName='" + p_username + "';";
						System.out.println(sql);
						ResultSet rs = dbc.queryForRS(sql);
						rs.last();
						int size = rs.getRow();

						int count = 0;
						do {
							String passwd = rs.getString("password"); //从表单获得 
							String email = rs.getString("email"); //从表单获得 
							String grades = rs.getString("level"); //从表单获得 
				%>
				<fieldset>
					<legend>修改用户信息</legend>

					<div class="icon" style="margin-top: 30px;">
							<label class="cd-label" for="cd-name">用户名：</label> <input
								class="user" type="text" name="userName" style="height: 50px;" value="<%=p_username%>"
								readonly>
						</div>

						<div class="icon" style="margin-top: 30px;">
							<label class="cd-label" for="cd-company">密码：</label> <input
								class="company" type="password" id="mima1" name="passwd"value="<%=passwd%>" style="height: 50px;width:100%" value="<%=passwd%>"
								required>
						</div>
						
												<div class="icon" style="margin-top: 30px;">
							<label class="cd-label" for="cd-company">确认密码:</label> <input
								class="company" type="password" id="mima2" name="passwd2" value="<%=passwd%>" style="height: 50px;width:100%" value="<%=passwd%>"
								required>
						</div>

						<div class="icon">
							<label class="cd-label" for="cd-textarea" style="height: 50%;">电子邮件：</label>
							<input class="email" type="email" name="email" 
								style="height: 50px;" value="<%=email%>"  required>
						</div>



						<div style="align:center">
							<h4 style="font-weight: bold;">用户级别</h4>
							<ul class="cd-form-list">
								<li><input type="radio" name="level" value="教师"
									sytle="font:14px;"  
						<%if (grades.equals("教师"))%> checked="checked" <%%>/> <label for="cd-radio-1"
									sytle="font:14px;" >教师</label></li>

								<li><input type="radio" name="level" value="学生"  <%if (grades.equals("学生"))%> checked="checked" <%%>/> <label
									for="cd-radio-2">学生</label></li>

								<li><input type="radio" name="level" value="系部管理员用户" 
						<%if (grades.equals("系部管理员用户"))%> checked="checked" <%%>/>
									<label for="cd-radio-3">系部管理员用户</label></li>
							</ul>
						</div>

					<div style="margin-top: 160px">
						<input type="submit" value="确认修改"
							style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1; margin-top: -200px;"
							class="btn btn-primary"> <input type="reset" value="取消"
							style="color: white; font-weight: bold; font-size: 16px; background: #42a2e1; margin-top: -200px;"
							class="btn btn-primary" href="users_query.jsp">
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
	</div><!-- main结束 -->
	<hr>
		<!--footer开始-->
		  <jsp:include page="footer.html"></jsp:include>
		  <!--footer 结束-->
</body>
<script src="js/main.js"></script>
</html>
