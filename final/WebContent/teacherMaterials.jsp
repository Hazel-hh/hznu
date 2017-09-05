<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<link rel="stylesheet" href="css/teacherTask.css">
<link rel="stylesheet" href="css/tableArea.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>

<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>

<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" href="css/teacherForm.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<style type="text/css">
	.main{
		height:700px;
	}
	.left{
		height:700px;
	}
	.left .line{
		height:650px;
	}
	</style>
</head>
<body>
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
				<label>教学材料</label>
			</div>
			
			<ul class="list">
		<%
			DBConnection dbc = new DBConnection();
			dbc.createConnection();
		
			String sql = "select * from materials where materials.is_delete = 0 and teacher_no = '" + teacher_no+"'";
			ResultSet rs = dbc.queryForRS(sql);
			String materialId = "";
			int id = 0;
			if(rs != null){
				while (rs.next()) {
					materialId = rs.getString("id");
					String subDate = rs.getString("sub_date");
					String address = rs.getString("address");
					String addressStr = "";
					if(address.length() > 26){
						addressStr = address.substring(0,26)+"...";
					}else{
						addressStr = address;
					}
					id++;
					if(subDate != null || subDate.length() > 0){
						subDate = subDate.substring(0,subDate.length() -2);
					}
					String fileName = URLEncoder.encode(address,"UTF-8");
					String linkStr = "DownloadServlet?fileName="+fileName;
					
		%>
		
		
				<li class="listItem">
					<a href="<%=linkStr %>"><span  class="listItem-left"><%=addressStr %></span><span class="listItem-right"><%=subDate %></span></a>
				</li>

		<%
				}
			}
		%>
			</ul>
		</div>
	</div>
	<hr>
		<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer 结束-->
</body>
</html>