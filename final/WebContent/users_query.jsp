<!-- 
	作者：谢岚
	日期：2017/5/16
	任务：实现通过连接数据库用户查询界面的分页功能
	版本：1.0
 -->
<!-- 
	作者：谢岚
	日期：2017/5/17
	任务：进行css优化，可在查询页面上进行修改或者删除按钮。
	版本：1.1
 -->
<!-- 
	作者：谢岚
	日期：2017/5/19
	任务：全部修改改为datatables，改删还未实现
	版本：1.1
 -->
<!-- 
	作者：谢岚
	日期：2017/5/31
	任务：密码部分修改的重新设计，
	版本：1.1
 -->
<%@ page contentType="text/html" pageEncoding="utf-8" language="java"%>
<%@ page import="java.sql.*"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>用户管理查询</title>
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.dataTables.min.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script charset="utf-8" language="javascript" src="js/table.js"
	type="text/javascript"></script>
<script type="text/javascript" language="javascript"
	src="js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="css/theme.css">
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<!-- 导航js -->
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<style type="text/css">
.main {
	height: 760px;
}

.left {
	height: 760px;
}

.left .line {
	height: 710px;
}
</style>

<!-- <!-- 修改增加用户链接样式 
<style type="text/css">
a {
	color: white;
	text-decoration: none;
}

a:hover {
	color: white;
	text-decoration: underline;
}

a:active {
	color: white;
}
</style> -->



</head>
<%@ page import="com.database.db.DBConnection"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<body class=" theme-blue">
	<!-- 检查用户是否登录 -->
	<jsp:include page="checkAdmin.jsp"></jsp:include>
	<!-- 检查用户是否登录结束 -->
	
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
				<label>用户信息</label>
			</div>
			<div class="btn-toolbar list-toolbar">
				<button class="btn btn-primary">
					<a href="users_add.jsp"><i class="fa fa-plus"></i></a> New User

				</button>

				<div class="btn-group"></div>
			</div>
			<table class="table" id="usersquery">


				<%
			DBConnection dbc4 = new DBConnection();
			dbc4.createConnection();

			String sql = "select userName,password,email,level,setted FROM users where  is_deleted=0";
			ResultSet rs = dbc4.queryForRS(sql);
			String taskId = null;
			int id = 0;
		%>
				<thead>
					<tr>
						<th>用户名</th>
						<th>用户级别</th>
						<th>email</th>

						<th>启用或禁用</th>
						<th style="width: 3.5em;"></th>
						<th style="width: 3.5em;"></th>
						<th style="width: 3.5em;"></th>
						<th style="width: 1.5em;"></th>
					</tr>
				</thead>

				<tbody>
					<script type="text/javascript">
		/*获取表格中的数据*/
		var array = new Array();
		var k=0;
		<%
			if(rs != null)
			while (rs.next()) {
				
				String name = rs.getString("userName");
				//System.out.println(taskName);
				String level = rs.getString("level");
				String email = rs.getString("email");
				String password = rs.getString("password");
				int setted = rs.getInt("setted");
				String finishStr = null;
				String a_finishStr = null;
				if (setted == 1) {
					finishStr = "启用";
					a_finishStr ="禁用";
					
				} else {
					finishStr = "禁用";
					a_finishStr = "启用";
				}
				id++;%>
	var t = new Array();	
	t.push("<%=name%>");
	t.push("<%=level%>");
	t.push("<%=email%>");	
	t.push("<%=finishStr%>");
	//t.push("<a href="updateusers.jsp"><i class="fa fa-pencil"></i></a>");
	//t.push("<a href="#myModal" role="button" data-toggle="modal"><i class="fa fa-trash-o"></i></a>");	
	<%String linkStr3 = "UpdateSettedServlet?userName=" + name;
				String settedStr = "<a href='" + linkStr3 + "'>"+a_finishStr+"</a>";
				System.out.println(settedStr);%>	
	t.push("<%=settedStr%>");	
	<%String linkStr = "users_update.jsp?userName=" + name;
				String downloadStr = "<a href='" + linkStr + "'>修改</a>";
				System.out.println(downloadStr);%>	
	t.push("<%=downloadStr%>");	
	<%String linkStr2 = "DeleteUserServlet?userName=" + name;
				String deleteStr = "<a href='" + linkStr2 + "'>删除</a>";
				System.out.println(deleteStr);%>	
	t.push("<%=deleteStr%>");
	
	
	t.push("<input type='checkbox' name='checkboxid' value='<%=name%>'/>");
					<%System.out.println("checkbox" + name);%>
						console.log(t);
						array[k] = t;
						k++;
					<%}
			dbc4.close();%>
						$(document)
								.ready(
										function() {
											$('#usersquery')
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
																	"sZeroRecords" : "还未有用户选择",
																	//"sProcessing": "<img src='./loading.gif' />",
																	"bStateSave" : true
																//保存状态到cookie *************** 很重要 ， 当搜索的时候页面一刷新会导致搜索的消失。使用这个属性就可避免了 
																}
															});
										});
					</script>
				</tbody>
			</table>

		
			<div style="float: right" class="operate">
				<button type="button" onclick="swapCheck()" class="operateBtn">[全选/取消]</button>
				<button type="submit" class="operateBtn" onclick="deleteuserIds();">[删除]</button>
				<button type="submit" class="operateBtn"
					onclick="resetuserpassword();">[重置密码]</button>

			</div>
			</br>
		</div>
	</div>
	<hr>
	<!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->

</body>
</html>
