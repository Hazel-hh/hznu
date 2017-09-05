<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教师上传资料</title>
 <link href="css/bootstrap.min.css" rel="stylesheet">
<link href="http://cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/upload/default.css">
<link href="css/upload/fileinput.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<link rel="stylesheet" href="css/teacherTask.css">
<link rel="stylesheet" href="css/teacherForm.css">
<script src="http://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"
	type="text/javascript"></script>
<script>window.jQuery || document.write('<script src="js/upload/jquery-1.11.0.min.js"><\/script>')</script>
<script src="js/upload/fileinput.js" type="text/javascript"></script>
<!--简体中文-->
<script src="js/upload/locales/zh.js" type="text/javascript"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<style type="text/css">
	.main{
		height:800px;
	}
	.left{
		height:700px;
	}
	.left .line{
		height:750px;
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
			}else
				session.setAttribute("teacher_no", teacher_no);
		}
	%><!-- 判断用户是否登录结束 -->

	<!--header开始-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header结束-->
	
	
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.net.URLEncoder"%>	
	<%@ page import="java.text.SimpleDateFormat"%>
	
	<%
		request.setCharacterEncoding("UTF-8");
		String taskId = request.getParameter("taskID");
		System.out.println("id");
		int id = Integer.parseInt(taskId);
		DBConnection dbc = new DBConnection();
		System.out.println("任务详情页创建对象成功");
		dbc.createConnection();
	
		//更新为已读		
		String updateSql = "update task set is_read = 1 where id = "+taskId;
		int isUpdate = dbc.update(updateSql);
		if(isUpdate == 1){
			System.out.println("更新任务表成功");
		}else{
			System.out.println("更新任务表失败");
		}
		dbc.close(); 
		
		dbc.createConnection();
		//查询语句
		String sql = "select * from task join course "
						+"on task.course_id = course.course_id "
						+"join tmtype on task.tm_type_id = tmtype.tm_type_id "
						+"join template on task.tm_type_id = template.tm_type_id "
						+" where task.id ="+id;		
		ResultSet rs = dbc.queryForRS(sql);
		String title="";
		String maTypeId = "";
		String courseId = "";
		String maTypeName = "";
		String courseName = "";
		String templatePath = "";
		String templateName = "";
		int isFinished = 0;
		
		//获取当前日期（年-月-日）
		Date now = new Date(); 					
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(now); 
		int isOverDate = 0;
		
		if(rs != null){
			rs.next();
			title = rs.getString("task_name");
			String startDate = rs.getString("start_date");
			String endDate = rs.getString("end_date");
			String remark = rs.getString("remark");
			if(remark == null || remark.equals("")){
				remark = "无";
			}
			maTypeId = rs.getString("task.tm_type_id");
			courseId = rs.getString("task.course_id");
			maTypeName = rs.getString("tm_type_name");
			courseName = rs.getString("course_name");
			templatePath = rs.getString("path");
			templateName = rs.getString("template_name");	
			isFinished = rs.getInt("is_finished");
	%>
	<div class="main">
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
			</div>  
		<div class="tableArea">
		<div class="cTitle">
				<label>提交材料</label>
			</div> 
		<!-- <div class="functionNav">				
				<ul id="breadcrumbs-one">
				    <li><a href = "teacherTask.jsp" class="current">任务列表</a></li>
				    <li><a href="teacherMaterials.jsp">教学材料</a></li>
				    <li><a href="downloadTemplate.jsp" >材料模板</a></li>
				</ul>
		</div> -->
		
		<div class="container kv-main">
			<div class="oneRow">
				<div class="oneRow-left">
					<span class="leftName">任务名称：</span>
				</div>
				<div class="oneRow-right">
					<span class="right"><%=title %></span>
				</div>
			</div>
			<div class="oneRow">
				<div class="oneRow-left">
					<span class="leftName">课&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;程：</span>
				</div>
				<div class="oneRow-right">
					<span class="right"><%=courseName %></span>
				</div>
			</div>
			<div class="oneRow">
				<div class="oneRow-left">
					<span class="leftName">材料类型：</span>
				</div>
				<div class="oneRow-right">
					<span class="right"><%=maTypeName%></span>	
				</div>
			</div>
			<div class="oneRow">
				<div class="oneRow-left">
					<span class="leftName">开始时间：</span>
				</div>
				<div class="oneRow-right">
					<span class="right"><%=startDate %></span>	
				</div>
			</div>
			<div class="oneRow">
				<div class="oneRow-left">
					<span class="leftName">结束时间：</span>
				</div>
				<div class="oneRow-right">
					<span class="right"><%=endDate %></span>
				</div>
			</div>
			<div class="oneRow">
				<div class="oneRow-left">
					<span class="leftName">任务说明：</span>
				</div>
				<div class="oneRow-right">
					<span class="right"><%=remark %></span>
				</div>
			</div>
			<%

			int todayYear = Integer.parseInt(today.substring(0,4));
			int endYear = Integer.parseInt(endDate.substring(0,4));
			System.out.println(todayYear);
			if(todayYear <= endYear){
				int todayMonth = Integer.parseInt(today.substring(5,7));
				int endMonth = Integer.parseInt(endDate.substring(5,7));
				System.out.println(todayMonth);
				if(todayMonth <= endMonth){
					int todayDay = Integer.parseInt(today.substring(8,10));
					int endDay = Integer.parseInt(endDate.substring(8,10));
					System.out.println(todayDay);
					if(todayDay <= endDay)
						isOverDate = 0;
					else
						isOverDate = 1;
				}else{
					isOverDate = 1;
				}
			}else
				isOverDate = 1;
			System.out.println("过期"+isOverDate);
			}
			dbc.close();
			
			session.setAttribute("id", id);
			session.setAttribute("title", title);
			session.setAttribute("course_id", courseId);
			session.setAttribute("tm_type_id", maTypeId);
			
			
			
	
			String linkStr = "downloadTemplate?templateName="+URLEncoder.encode(templateName,"UTF-8");;
			
			
			%>	
			<div class="oneRow">
				<div class="oneRow-left">
					<span class="leftName">材料模板：</span>
				</div>
				<div class="oneRow-right">
					<span class="right"><a href="<%=linkStr %>"><%=templateName %></a></span>
				</div>
			</div>	
		<div class="oneRow">
				<div class="oneRow-left">
					<span class="leftName">完成状态：</span>
				</div>
				<div class="oneRow-right">
					<span class="right"><%if(isFinished == 1) {%>已完成<%}else %>未完成</span>
				</div>
			</div>
			
		<form enctype="multipart/form-data" <%if(isOverDate == 1)%> style="display:none;" <% %> action="UploadMaterials" method="post" class="finishForm" onsubmit="return check()">
	  		<div class="uploadArea">
	  			<div class="oneRow">
						<div class="oneRow-left">
							<span class="leftName">选择文件：</span>
						</div>
						<div class="oneRow-right">
							<div class="form-group">
	                  			<input id="file-5" class="file" name="file" type="file" data-preview-file-type="any" data-upload-url="#">
	             			</div>
						</div>
				</div>	
			</div>
			<div class="uploadBtn">
			
				<button type="submit" class="btn btn-primary" style="width:80px;"><%if(isFinished == 1){%>重新编辑<%}else %>提交</button>
				<button type="reset" class="btn btn-default" style="width:80px;">重置</button>
			</div>
		</form>
		</div>
	</div>
	</div>
	<hr>
	<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
	
</body>
<script>
	function check(){
		var file = document.getElementById("file-5").value;
		if(file.length==0)
		{
			alert("请选择文件");
			return false;
		}
		return true;
	}
</script>
</html>