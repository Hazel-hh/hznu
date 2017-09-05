<!-- 
	作者：谢岚
	日期：2017/5/20
	任务：实现通过连接数据库班级查询界面的分页功能
	版本：1.0
 -->

<%@ page contentType="text/html" pageEncoding="GB2312" language="java"%>  
<%@ page import="java.sql.*"%>  
<!doctype html>
<html lang="en"><head>
    <meta charset="utf-8">
    <title>系部查询</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
    <script src="js/jquery.min.js" type="text/javascript"></script>
  <script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
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
	<div class="main">
		<div class="left">
		<jsp:include page="left.jsp"></jsp:include>
			</div>  
      <div class="tableArea">
			<div class="cTitle">
				<label>系部信息</label>
			</div>    
		<div class="btn-toolbar list-toolbar">
		    <button class="btn btn-primary"><a href="dept_add.jsp"><i class="fa fa-plus"></i></a> New Dept</button>
		   
		  <div class="btn-group">
		  </div>
		</div>
		<table class="table" id="classesquery">



	<%!  
	    public static final int PAGESIZE = 10;  
	    int pageCount;  
	    int curPage = 1;  
	%>  
	<%DBConnection dbc4 = new DBConnection();
				dbc4.createConnection();
	
				String sql =  "select dept.id,dept_id,dept_name,dept_introduction,dept_note FROM dept where dept.is_deleted = 0 ";  
				ResultSet rs = dbc4.queryForRS(sql);
				String taskId = null;
				//int id = 0;
					%>
	  <thead>
	    <tr>
	     <th>id</th>  
	     <th>系部 ID</th>  
	     <th>系部名称</th>  
	     <th>系部说明</th>  
	     <th>备注</th>                     
	     <th style="width: 3.5em;"></th>
	      <th style="width: 3.5em;"></th>
	    </tr>
	  </thead>
	
	  <tbody>
	<script type="text/javascript">
			/*获取表格中的数据*/
			var array = new Array();
			var k=0;
			<%
				while (rs.next()) {
					int id = rs.getInt("id");
					String dept_id = rs.getString("dept_id");
					//System.out.println(taskName);
					
					String dept_name = rs.getString("dept_name");
					String dept_introduction= rs.getString("dept_introduction");
					
					String dept_introductionStr = dept_introduction;
					if(dept_introduction.length() > 14)
						dept_introductionStr = dept_introduction.substring(0,16)+"...";
					String dept_note = rs.getString("dept_note");		
					String dept_noteStr = dept_note;
					if(dept_note.length() > 14)
						dept_noteStr = dept_note.substring(0,16)+"...";
					//id++;
				
			%>
		var t = new Array();
		
		t.push("<%=id%>");
		t.push("<%=dept_id%>");
		t.push("<%=dept_name%>");
		t.push("<%=dept_introductionStr%>");
		t.push("<%=dept_noteStr%>");
	<%
		
		String linkStr = "dept_update.jsp?id="+id;
		String downloadStr = "<a href='"+linkStr+"'>修改</a>";
		System.out.println(downloadStr);
		%>
		
		
		t.push("<%=downloadStr %>");
		
		
		<%
		
		String linkStr2 = "DeleteDeptServlet?id="+id;
		String deleteStr = "<a href='"+linkStr2+"'>删除</a>";
		System.out.println(deleteStr);
		%>
		
		t.push("<%=deleteStr %>");
	
		
	
			console.log(t);
			array[k] = t;
			k++;
			<%}
				dbc4.close();%>			
				$(document).ready(function() {
					$('#classesquery').DataTable({
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
							"sZeroRecords" : "没有此系别信息",
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
  <hr />
	<!--footer开始-->
	  <jsp:include page="footer.html"></jsp:include>	  
	  <!--footer 结束-->

    <script src="js/bootstrap.js"></script>
    <script type="text/javascript">
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
    </script>
    
  
</body>
</html>
