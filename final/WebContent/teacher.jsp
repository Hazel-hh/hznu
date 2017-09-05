<!-- 
	作者：余欣
	日期：2017/5/11
	任务：教师信息管理
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="com.database.db.TeacherDao"%>
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.net.URLEncoder"%>
	<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>teacher</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<link rel="stylesheet" href="css/tableArea.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<script src="js/table.js"></script>
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<script src="js/ExportExcel.js"></script>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="http://cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/upload/default.css">
<link href="css/upload/fileinput.css" rel="stylesheet"
	type="text/css" />
	<script src="http://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"
	type="text/javascript"></script>
	<script>window.jQuery || document.write('<script src="js/upload/jquery-1.11.0.min.js"><\/script>')</script>
<script src="js/upload/fileinput.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/teacherForm.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!--简体中文-->
<script src="js/upload/locales/zh.js" type="text/javascript"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<style type="text/css">
		.main{
			height:1200px;
		}
		.left{
			height:700px;
		}
		.left .line{
			height:1150px;
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
				<label>教师信息</label>
			</div>
		<table class="table" id="dataTable">
		<thead>
			<tr>
				<td>序号</td>
				<td>教师工号</td>
				<td>姓名</td>
				<td>生日</td>
				<td>手机</td>
				<td>邮箱</td>
				<td>操作</td>
				<td>删除</td>
			</tr>
			</thead>
			<tbody>
			<script type="text/javascript">
			var array = new Array();
			var k=0;
			<%
				
			    TeacherDao dao = new TeacherDao();
				ArrayList<Map<String, String>> files = dao.queryAll();
				int id = 0;
				String taskId = null;
				for (Map<String, String> file : files) {
					taskId=file.get("teacher_no");
					String checkStr="checkTeacher.jsp?taskId="+taskId;
					String check="<a href='"+checkStr+"'>查看</a>";
					String resetStr="resetTeacher.jsp?taskId="+taskId;
					String reset="<a href='"+resetStr+"'>修改</a>";
	
			%>
			
			var t = new Array();
			t.push("<%=++id%>");
			t.push("<%=file.get("teacher_no") %>");
			t.push("<%=file.get("teacher_name") %>");
			t.push("<%=file.get("birthday") %>");
			t.push("<%=file.get("mobile") %>");
			t.push("<%=file.get("email") %>");
			t.push("<%=check%>  <%=reset%>");
			t.push("<input type='checkbox' name='id' value='<%=taskId%>'>");
			console.log(t);
			array[k] = t;
			k++;
			
		<% dao.close();} %>
		
		$(document).ready(function() {
			$('#dataTable').DataTable({
				data : array,
				"bLengthChange" : false, //改变每页显示数据数量
				"oLanguage" : {
					"sLengthMenu" : "每页显示 _MENU_ 条记录",
					"sZeroRecords" : "抱歉， 没有找到",
					"sInfo" : "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
					"sInfoEmpty" : "没有数据",
					"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
					"sSearch" : "搜索",
					"oPaginate" : {
						"sFirst" : "首页",
						"sPrevious" : "前一页",
						"sNext" : "后一页",
						"sLast" : "尾页"
					},
					"sZeroRecords" : "没有教师数据",
					//"sProcessing": "<img src='./loading.gif' />",
					"bStateSave" : true
				//保存状态到cookie *************** 很重要 ， 当搜索的时候页面一刷新会导致搜索的消失。使用这个属性就可避免了 
				}
			});
		});

	</script>
	
	</tbody>
	</table>		
	 <div class="operate">
		<button type="button" onclick="swapCheck()" class="operateBtn">[全选/反选]</button>
		<button type="submit" class="operateBtn" onclick="deleteTasksT();">[删除]</button>
		<button type="button" onclick="window.location.href='addTeacher.jsp';">[添加]</button>
		<%String a="teacher";%>
		<a href="ExportServlet?datatype=<%=a%>">导出</a>
	</div>
	
	<div class="container kv-main">
		<form enctype="multipart/form-data" id="form1" name="form1" onsubmit="return validate()" action="Excel" method="post" class="finishForm">
		<div class="uploadArea">
	  			<div class="oneRow">
						<div class="oneRow-left">
							<span class="leftName">选择文件：</span>
						</div>
						<div class="oneRow-right">
							<div class="form-group">
	                  			<input id="file-5" name="file" class="file" type="file"  data-upload-url="#">
	             			</div>
						</div>
				</div>	
		</div>
		<div class="uploadBtn">
				<button type="submit" name="Submit" class="btn btn-primary">提交</button>
				<button type="reset" name="Submit2" class="btn btn-default">重置</button>
		</div>
	</form>
	</div>
	</div><!-- tableArea结束 -->	
	 </div><!-- main结束 -->
	 <hr>
	 <!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>
<script src="js/table.js"></script>
</html>