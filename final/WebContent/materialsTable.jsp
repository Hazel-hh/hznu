<!-- 
	作者：何红春
	日期：2017/5/20
	任务：教学材料管理页面
	版本：1.3
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教学材料</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">

<!-- <link rel="stylesheet" href="font-awesome/css/font-awesome.css"> -->
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<script src="js/table.js"></script>
<style type="text/css">
		.main{
			height:1200px;
		}
		.left{
			height:1200px;
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

	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.net.URLEncoder"%>
	<%
		DBConnection dbc4 = new DBConnection();
		dbc4.createConnection();

		String sql = "select * from materials join tmtype on materials.tm_type_id = tmtype.tm_type_id "
				+ "join teacher on teacher.teacher_no = materials.teacher_no "
				+ "join course on materials.course_id = course.course_id " + "and materials.is_delete = 0 order by materials.id";

		ResultSet rs = dbc4.queryForRS(sql);
		String materialId = null;
		int id = 0;
	%>
	<div class="main">
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>
		<div class="tableArea">
			<div class="cTitle">
				<label>教学材料</label>
			</div>
			<table class="table" id="tableList">
				<thead>
					<tr id="head">
						<td>序号</td>
						<td>课程名</td>
						<td>材料类型</td>
						<td>教师</td>
						<td>提交日期</td>
						<td>文件名</td>
						<td>操作</td>
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
				materialId = rs.getString("id");
				String taskType = rs.getString("tm_type_name");
				String teacher = rs.getString("teacher_name");
				String subDate = rs.getString("sub_date");
				String address = rs.getString("address");
				String addressStr = "";
				if(address.length() > 16){
					addressStr = address.substring(0,16)+"...";
				}else{
					addressStr = address;
				}
				id++;%>
			var t = new Array();
			t.push(<%=id%>);
			t.push("<%=courseName%>");
			t.push("<%=taskType%>");
			t.push("<%=teacher%>");
			t.push("<%=subDate%>");
			t.push("<%=addressStr%>");	
			<%
			String fileName = URLEncoder.encode(address,"UTF-8");
			String linkStr = "DownloadServlet?fileName="+fileName;
			String downloadStr = "<a href='"+linkStr+"'>下载</a>";
			
			//System.out.println(downloadStr);
			%>
			t.push("<%=downloadStr %>");
			t.push("<input type='checkbox' name='id' value='<%=materialId%>' />");
			console.log(t);
			array[k] = t;
			k++;
			<%}
			dbc4.close();%>
			$(document).ready(function() {
				$('#tableList').DataTable({
					data : array,
					"bLengthChange" : false, //每页显示的记录数
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
					"bStateSave" : true,	//保存状态到cookie  当搜索的时候页面一刷新会导致搜索的消失。使用这个属性就可避免了 
					}
				});
			});
			</script>
			</tbody>
			</table>
		<div class="operate">
			
			<a href="#statisticMaterials" class="releaseTask"
				style="color: blue; margin-top: 1px; margin-right: 8px;">[材料统计]</a>
			<button type="button" onclick="swapCheck()" class="operateBtn">[全选/取消]</button>
			<button type="submit" class="operateBtn" onclick="deleteMaterials();">[删除]</button>
			<button type="submit" onclick="batchDownload();">[下载]</button>
			<a href="allDownload" class="releaseTask" style="color: blue; margin-top: 1px; margin-left:4px;">[全部下载]</a>
		</div>
		
		<!-- <div class="hr"></div> -->
		
		<!-- 统计图表 -->
		<jsp:include page="materialStatistics.jsp"></jsp:include>
		<!-- 统计图表结束 -->
		</div>
		<!-- tableArea结束 -->
	</div>
	<hr />
	<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer 结束-->
</body>

</html>