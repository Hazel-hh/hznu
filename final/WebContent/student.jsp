<!-- 
	作者：余欣
	日期：2017/5/11
	任务：学生信息管理
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="com.database.db.StudentDao"%>
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.net.URLEncoder"%>
	<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>student</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">

<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" href="css/tableArea.css">

<link href="http://cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/upload/default.css">
<link href="css/upload/fileinput.css" rel="stylesheet"
	type="text/css" />
	<script src="http://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"
	type="text/javascript"></script>
	<script>window.jQuery || document.write('<script src="js/upload/jquery-1.11.0.min.js"><\/script>')</script>
<script src="js/upload/fileinput.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/teacherForm.css">
<!--简体中文-->
<script src="js/upload/locales/zh.js" type="text/javascript"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<script src="js/table.js"></script>
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<style type="text/css">
		.main{
			height:1200px;
		}
		.left{
			height:1100px;
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
				<label>学生信息</label>
		</div>
		<table class="table" id="dataTable">
			<thead>
			<tr>
				<td>序号</td>
				<td>学号</td>
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
			    StudentDao dao = new StudentDao();
				ArrayList<Map<String, String>> files = dao.queryAll();
				int i=0;
				String taskId = null;
				for (Map<String, String> file : files) {
					taskId=file.get("student_no");
					String taskIdStr = URLEncoder.encode(taskId,"UTF-8");
					String checkStr="checkStudent.jsp?taskId="+taskIdStr;
					String check="<a href='"+checkStr+"'>查看</a>";					
					String resetStr="resetStudent.jsp?taskId="+taskIdStr;
					String reset="<a href='"+resetStr+"'>修改</a>";
			%>
			var t = new Array();
			t.push("<%=++i%>");
			t.push("<%=file.get("student_no") %>");
			t.push("<%=file.get("student_name") %>");
			t.push("<%=file.get("birthday") %>");
			t.push("<%=file.get("mobile") %>");
			t.push("<%=file.get("email") %>");
			t.push("<%=check%>  <%=reset%>")
			t.push("<input type='checkbox' name='id' value='<%=taskId%>'>");
			console.log(t);
			array[k] = t;
			k++;
			<%
				dao.close();}
			%>
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
						"sZeroRecords" : "没有学生数据",
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
			<button type="submit" class="operateBtn" onclick="deleteStudent();">[删除]</button>
			<button type="button" class="operateBtn" onclick="window.location.href='addStudent.jsp';">
			[添加]</button>
			<%String a="student";%>
			<a href="ExportServlet?datatype=<%=a%>" style="color: blue; margin-top: 1px; margin-right: 8px;">导出</a>
		</div>	
	<%-- <form action="Excel" method="post"
			enctype="multipart/form-data" name="form1" id="form1"
			onsubmit="return validate()">
		 <input type="file" name="file" value="导入"/> 
		 <input type="submit" name="Submit" value="上传" />
		 <input type="button" value="添加" onclick="window.location.href='addStudent.jsp';"/>
		
		
	</form>
	 --%>
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
				<button type="submit" name="Submit" class="btn btn-primary" >提交</button>
				<button type="reset" name="Submit2" class="btn btn-default">重置</button>
		</div>
	</div>
	</div>
	</div>
	<hr>
	<!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>
<script src="js/table.js"></script>
</html>