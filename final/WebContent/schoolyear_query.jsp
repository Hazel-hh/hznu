<!-- 
	作者：谢岚
	日期：2017/5/22
	任务：学年学期管理信息查询
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学年学期查询</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.dataTables.min.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript"
	src="js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="css/theme.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">

<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
 	<!-- 导航 -->
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<link rel="stylesheet" type="text/css" href="css/nav.css">
	<link rel="stylesheet" type="text/css" href="css/left.css">
	<!-- 导航js -->
   	<script src="js/nav.js"></script>
	<script src="js/navChange.js"></script>
	<style type="text/css">
		.main{
			height:900px;
		}
		.left{
			height:600px;
		}
		.left .line{
			height:850px;
		}
	</style>
</head>
<body>
	
	<!-- 检查用户是否登录 -->
	<jsp:include page="checkAdmin.jsp"></jsp:include>
	<!-- 检查用户是否登录结束 -->
	

	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%
		DBConnection dbc4 = new DBConnection();
		dbc4.createConnection();
		String sql = "select * from tyear_sem where is_deleted = 0";
		ResultSet rs = dbc4.queryForRS(sql);
		String taskId = null;
		//int id = 0;
	%>
	<!--header开始-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header结束-->
	
	<!-- main -->
	<div class="main">  
		<div class="left">
		<jsp:include page="left.jsp"></jsp:include>
			</div>  
		<div class="tableArea">
		<div class="cTitle">
				<label>学年学期</label>
			</div>
	<div class="content">
		<div class="main-content">
			<div class="row padding-top">
				<div class="col-md-10 col-md-offset-1">
					<div class="row">
						<div class="col-md-6">

							<%
								String sql2 = "select teaching_year from tyear_sem where now =1 ";
								String sql3 = "select semester from tyear_sem where now =1 ";
								String sql4 = "select start_date,end_date from tyear_sem where now =1 ";
								ResultSet rs2 = dbc4.queryForRS(sql2);
								ResultSet rs3 = dbc4.queryForRS(sql3);
								ResultSet rs4 = dbc4.queryForRS(sql4);
								rs2.last();
								rs3.last();
								rs4.last();
								String nowyear = rs2.getString(1);
								String nowsem = rs3.getString(1);
								Date start_date = rs4.getDate("start_date");
								System.out.println(start_date);
								Date end_date = rs4.getDate("end_date");
								System.out.println(nowyear);
							%>
							<span style="font-size: 28px;"><span
								class="fa fa-paper-plane"></span>现在是<%=nowyear%>学年第<%=nowsem%>个学期</span>
							<address></address>
						</div>
						<div class="pull-right well">
							<table>
								<tbody>
									<tr>
										<td class="pull-right padding-right"><strong><span style="position:relative;top:8px;">学年学期<span></span></strong></td>
										<td><%=nowyear%>-<%=nowsem%></td>
									</tr>
									<tr>
										<td class="pull-right padding-right"><strong><span style="position:relative;top:8px;">开始日期</span></strong></td>
										<td><%=start_date%></td>
									</tr>
									<tr>
										<td class="pull-right padding-right"><strong><span style="position:relative;top:8px;">结束日期</span></strong></td>
										<td><%=end_date%></td>
									</tr>

								</tbody>
							</table>
						</div>
					</div>


					<div class="btn-toolbar list-toolbar">
						<button class="btn btn-primary" href="schoolyear_add.jsp">
							<a href="schoolyear_add.jsp"><i class="fa fa-plus"></i></a>增加学年学期信息
						</button>

						<div class="btn-group"></div>
					</div>
					<div class="row"></div>

					<table class="table" id="tableList">
						<thead>
							<tr id="head">
								<th>学年</th>
								<th>学期</th>
								<th>开始日期</th>
								<th>截止日期</th>
								<th>操作</th>
								<th>删除</th>
								<th>设置</th>
							</tr>
						</thead>
						<tbody>


							<script type="text/javascript">
		/*获取表格中的数据*/
		var array = new Array();
		var k=0;
		<%while (rs.next()) {

				int id = rs.getInt("id");
				Date startDate = rs.getDate("start_date");
				System.out.println(startDate);
				Date endDate = rs.getDate("end_date");
				System.out.println(endDate);
				String year = rs.getString("teaching_year");
				int semester = rs.getInt("semester");
				int isNow = rs.getInt("now");
				String yearSem = year + "-" + semester;
				String finishStr = null;

				//id++;%>
	var t = new Array();
	
	t.push("<%=year%>");
	t.push("<%=semester%>");
	t.push("<%=startDate%>");
	t.push("<%=endDate%>");
	
<%String linkStr = "schoolyear_update.jsp?id=" + id;
				String downloadStr = "<a href='" + linkStr + "'>修改</a>";
				System.out.println(downloadStr);%>
	
	
	t.push("<%=downloadStr%>");
	
	
	<%String linkStr2 = "DeleteSchoolyearServlet?id=" + id;
				String deleteStr = "<a href='" + linkStr2 + "'>删除</a>";
				System.out.println(deleteStr);%>
	
	<%
	String setNowLink2 = "SetSchoolNow?id="+id;
	String src= "images/check.png";
	if (isNow != 0){
		src= "images/check1.png";
	}
		
	String setNowLink = "<a href='" + setNowLink2 + "'><img src='"+src+"'/></a>";
	%>
	t.push("<%=deleteStr%>");
	t.push("<%=setNowLink%>");
	
	
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
																			"sZeroRecords" : "该学年学期信息未被添加",
																			//"sProcessing": "<img src='./loading.gif' />",
																			"bStateSave" : true
																		//保存状态到cookie *************** 很重要 ， 当搜索的时候页面一刷新会导致搜索的消失。使用这个属性就可避免了 
																		}
																	});
												});
							</script>
						</tbody>
					</table>
					</div>
				</div>
			</div>
		</div>
	
	</div>
	</div>
	<hr >
	<!--footer开始-->
	 <jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>

</html>