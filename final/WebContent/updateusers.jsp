<!-- 
	作者：谢岚
	日期：2017/5/14
	任务：对用户信息进行修改（还没完成）(怎么update单选框的checked）
	版本：1.0
 -->
 <!-- 
	作者：谢岚
	日期：2017/5/15
	任务：对用户信息进行修改（还没完成）(实现update单选框的checked，利用equals判断）
	版本：1.1
 -->
<%@ page language="java" import="java.util.*,com.database.db.*" pageEncoding="UTF-8"%>  
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
  <head>  
    <base href="<%=basePath%>">  
      <%
		request.setCharacterEncoding("utf-8");
	%>
    <title>My JSP 'updateUser.jsp' starting page</title>  
      
    <link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"> 
    <!-- 导航栏 -->
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="css/left.css">
  <style type="text/css">
		.main{
			height:760px;
		}
		.left{
			height:760px;
		}
		.left .line{
			height:710px;
		}
	</style>
  </head>  
    
  <body bgcolor="#CED3FE">  
     <!-- 检查用户是否登录 -->
	<jsp:include page="checkAdmin.jsp"></jsp:include>
	<!-- 检查用户是否登录结束 -->
     
     <div class="main">
		<div class="left">
		<jsp:include page="left.jsp"></jsp:include>
			</div>  
	<div class="tableArea">
			<div class="cTitle">
				<label>更新用户</label>
			</div>
	<center>    
    <hr>  
   <h1>修改用户信息</h1>  
   <form action="UsersClServlet?flag=updateUser" method="post">  
   <table >  
   <tr><td bgcolor="pink">用户ID</td><td><input type="text" readonly="readonly" name="userId" value="<%=request.getParameter("userId")%> "/></td></tr>  
   <tr><td bgcolor="pink">用户名</td><td><input type="text" name="userName" value="<%=request.getParameter("userName")%>"/></td></tr>  
   <tr><td bgcolor="silver">密码</td><td><input type="password" name="passwd" value="<%=request.getParameter("passwd") %>"/></td></tr>  
   <tr><td bgcolor="pink">电子邮件</td><td><input type="text" name="email" value="<%=request.getParameter("email") %>"/></td></tr>  
   <tr><td bgcolor="silver">用户级别</td><td><input type="text" name="grade" value="<%=request.getParameter("grade") %>"/></td></tr>  
   
   
    <tr><td bgcolor="silver">用户级别</td><td><input  type="radio" name="level" value="学生" <%if (request.getParameter("grade").equals("学生"))%> checked="checked" <%%>/>学生
<input  type="radio" name="level" value="老师" <%if (request.getParameter("grade").equals("老师"))%> checked="checked"
						<%%>/>老师<input  type="radio" name="level" value="系部管理员用户" <%if (request.getParameter("grade").equals("系部管理员用户"))%> checked="checked"
						<%%> />系部管理员用户</td></tr> 
   
  <tr><td><input type="submit" value="修改用户"></td><td><input type="reset" value="重置"></td></tr>  
   </table>  
   </form>  
    <hr>  
      
    </center>  
    </div>
    </div>
    <hr>
    <!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer 结束-->
  </body>  
</html>  