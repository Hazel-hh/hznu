<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.database.db.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>下载教学模板</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<link rel="stylesheet" href="css/teacherTask.css">
<link rel="stylesheet" href="css/tableArea.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>

<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<link rel="stylesheet" href="css/teacherForm.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">

<link href="css/page.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="js/page.js"></script>
<script type="text/javascript">
    function tt(dd){
        //alert(dd);
    }
    var GG = {
        "kk":function(mm){
            //alert(mm);
        }
    }

    $("#page").initPage(100,1,GG.kk);
</script>
<style type="text/css">
		.main{
			height:600px;
		}
		.left{
			height:500px;
		}
		.left .line{
			height:550px;
		}
	</style>

</head>
<body >
<div class="body">


	<!-- 判断用户是否登录 -->
	<%
		String username = null;
		if (session.getAttribute("userName") != null) {
			username = session.getAttribute("userName").toString();
		}else{
        	out.print("<script language='JavaScript'>alert('请先登录！');window.location.href='index.jsp';</script>");
		}
		String teacher_no = "";
		if (session.getAttribute("userNo") != null) {
			teacher_no = session.getAttribute("userNo").toString();
		}else{
        	out.print("<script language='JavaScript'>alert('请先登录！');window.location.href='index.jsp';</script>");
		}
		String userType = null;
		if (session.getAttribute("userType") != null) {
			userType = session.getAttribute("userType").toString();
			if (!userType.equals("teacher")) {
				out.print(
						"<script language='JavaScript'>alert('当前模块只对教师开放！');window.history.back();</script>");
			}			
		}
	%><!-- 判断用户是否登录结束 -->

	<!--header开始-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header结束-->	
	
	<div class="main">	
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>
		<div class="tableArea">
			<div class="cTitle">
				<label>材料模板</label>
			</div> 
		
		<ul class="list">
		<%
			TemplateDAO dao = new TemplateDAO();
			ArrayList<Map<String, String>> templates = dao.queryAll();
			int i = 0;

			for (Map<String, String> template : templates) {
				String templateName = template.get("template_name");
				String date = template.get("date");
				String time = template.get("time");
				String dateTime = date + " " + time;

		%>		
			<li class="listItem">
					<a href='downloadTemplate?templateName=<%=URLEncoder.encode(templateName, "UTF-8") %>'><span class="listItem-left"><%=templateName %></span><span class="listItem-right"><%=dateTime %></span></a>
			</li>
		<%} %>
	</ul>		
	</div><!-- tableArea结束 -->
	</div><!-- main结束 -->
	
	<hr />
	<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
	</div>
</body>


</html>