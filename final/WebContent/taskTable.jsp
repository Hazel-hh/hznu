<!-- 
	作者：何红春
	日期：2017/5/18
	任务：任务管理页
	版本：1.3
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>任务表</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>

<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
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
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.io.*" %>
	<!-- 检查用户是否登录 -->
	<jsp:include page="checkAdmin.jsp"></jsp:include>
	<!-- 检查用户是否登录结束 -->
	
	<!--header开始-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header结束-->
	
	<%
		DBConnection dbc4 = new DBConnection();
		dbc4.createConnection();

		String sql = "select * from task join tmtype on task.tm_type_id = tmtype.tm_type_id "
				+ "join teacher on teacher.teacher_no = task.teacher_no "
				+ "join course on task.course_id = course.course_id " + "and task.is_delete = 0 order by task.id";

		ResultSet rs = dbc4.queryForRS(sql);
		String taskName = null;
		int id = 0;
	%>
	
	<div class="main">
	<div class="left">
	<jsp:include page="left.jsp"></jsp:include>
			</div>  
		<div class="tableArea">
			<div class="cTitle">
				<label>任务信息</label>
			</div>
			<table class="table" id="tableList">
				<thead>
					<tr id="head">
						<td>序号</td>
						<td>任务名</td>
						<td>课程名</td>
						<td>材料类型</td>
						<td>教师</td>
						<td>开始日期</td>
						<td>截止日期</td>
						<td>学年学期</td>
						<td>状态</td>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<script type="text/javascript">
		/*获取表格中的数据*/
		var array = new Array();
		var k=0;
		
		<%while (rs.next()) {
				String courseName = rs.getString("course_name");
				//System.out.println(taskName);
				int taskId = rs.getInt("id");
				taskName = rs.getString("task_name");
				String taskType = rs.getString("tm_type_name");
				String teacher = rs.getString("teacher_name");
				Date startDate = rs.getDate("start_date");
				Date endDate = rs.getDate("end_date");
				String year = rs.getString("teaching_year");
				int semester = rs.getInt("semester");
				int isFinished = rs.getInt("is_finished");
				String yearSem = year + "-" + semester;

				String finishStr = null;
				if (isFinished == 1) {
					finishStr = "已完成";
				} else {
					finishStr = "未完成";
				}
				String task = "";
				if (taskName.length() > 9) {
					task = taskName.substring(0,9)+"...";
				} else {
					task = taskName;
				}
				id++;%>
	var t = new Array();
	t.push(<%=id%>);
	t.push("<%=task%>");
	t.push("<%=courseName%>");
	t.push("<%=taskType%>");
	t.push("<%=teacher%>");
	t.push("<%=startDate%>");
	t.push("<%=endDate%>");
	t.push("<%=yearSem%>");
	t.push("<%=finishStr%>");
	t.push("<input type='checkbox' name='id' value='<%=taskId%>' />");
						console.log(t);
						array[k] = t;
						k++;
					<%}
			dbc4.close();%>
						$(document)
								.ready(
										function() {
											$('#tableList')
													.DataTable(
															{
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
																	"sZeroRecords" : "还未发布任何任务",
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
			<a href="releaseTask.jsp" class="releaseTask"
				style="color: blue; margin-top: 1px; margin-right: 16px;">[发布任务]</a>
			<a href="#statisticTask" class="releaseTask"
				style="color: blue; margin-top: 1px; margin-right: 8px;">[任务统计]</a>
			<button type="button" onclick="swapCheck()" class="operateBtn">[全选/取消]</button>
			<button type="submit" class="operateBtn" onclick="deleteTasks();">[删除]</button>
		</div>

		<!-- 统计图表 -->
		<jsp:include page="taskStatistics.jsp"></jsp:include>
		<!-- 统计图表结束 -->
		</div>
		<!-- tableArea结束 -->
	</div>
		
		<hr>
		<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer 结束-->
	

</body>
<script src="js/table.js"></script>
</html>