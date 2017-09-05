<!-- 
	作者：张梦婕
	日期：2017/5/14
	任务：教学材料类型管理
	版本：1.2
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.database.db.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.database.db.*"%>
<%@ page import="com.bean.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教学材料类型管理</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">

	
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="js/table.js"></script>
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
				<label>材料类型</label>
			</div>
		<!-- 教学材料类型表 -->
		<table class="table" id="tableList">
			<thead>
				<!-- <center>教学材料类型表</center> -->
				<tr id="head">
					<td >序号</td>
					<td>类型 ID</td>
					<td>类型名称</td>
					<td>类型说明</td>
					<td>是否必交</td>
					<td>备注</td>
					<td>查看</td>
					<td>修改</td>
					<td>选择</td>
				</tr>
			</thead>
			<tbody>
			<script type="text/javascript">
				/* 获取表格中的数据 */
				var array = new Array();
				var k=0;
				<!-- 初始页面的数据信息显示 -->
				<%
				TmtypeDAO dao = new TmtypeDAO();
				int i = 0;
				
				ArrayList<Map<String, String>> tmtypeList = dao.queryAll();
				for (Map<String, String> tmtypeMap : tmtypeList) {
					//获取材料类型ID,材料类型名称,材料类型介绍,是否必交,备注
					String tmtypeID = tmtypeMap.get("tm_type_id");
					String tmtypeName = tmtypeMap.get("tm_type_name");
					String tmtypeIntro = tmtypeMap.get("tm_type_introduction");
					String ismustsub = tmtypeMap.get("is_must_sub");
					//数据库中为0,1
					if (ismustsub.equals("1"))
						ismustsub = "是";
					else
						ismustsub = "否";
					String tmtypeNote = tmtypeMap.get("remark");
					String tmtypeNameStr = "";
					//使材料类型名称最多显示六个字，大于六个字的部分显示...
					if(tmtypeName.length() > 6){
						tmtypeNameStr = tmtypeName.substring(0,6)+"...";
					}else{
						tmtypeNameStr = tmtypeName;
					}
					String tmtypeIntroStr = "";
					//使材料类型说明最多显示六个字，大于六个字的部分显示...
					if(tmtypeIntro.length() > 6){
						tmtypeIntroStr = tmtypeIntro.substring(0,6)+"...";
					}else{
						tmtypeIntroStr = tmtypeIntro;
					}
					String tmtypeNoteStr = "";
					//使材料类型备注最多显示六个字，大于六个字的部分显示...
					if(tmtypeNote.length() > 6){
						tmtypeNoteStr = tmtypeNote.substring(0,6)+"...";
					}else{
						tmtypeNoteStr = tmtypeNote;
					}
					
				%>  //将数据插入datatable
					var t=new Array();
					t.push(<%=++i%>);
					t.push("<%=tmtypeID%>");
					t.push("<%=tmtypeName%>");
					t.push("<%=tmtypeIntro%>");
					t.push("<%=ismustsub%>");
					t.push("<%=tmtypeNote%>");
					t.push("<input type='button' class='editBtn' name='checkTmtype' value='查看' class='operateBtn' onclick='checkTmtypeInfo(this)'/>");
					t.push("<input type='button' class='editBtn' name='checkTmtype' value='修改' class='operateBtn' onclick='modifyTmtypeInfo(this)'/>");
					t.push("<input type='checkbox' name='id' value='<%=tmtypeID%>' />");
					array[k] = t;
					k++;
					<%dao.close();}%>
					$(document).ready(function() {
						$('#tableList').DataTable({
							
							data : array,
							"bLengthChange" : false, //改变每页显示数据数量
							"oLanguage" : {
								"sLengthMenu" : "每页显示 _MENU_ 条记录",
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
								"sZeroRecords" : "抱歉，没有找到你要的数据",
								"bStateSave" : true
							//保存状态到cookie *************** 很重要 ， 当搜索的时候页面一刷新会导致搜索的消失。使用这个属性就可避免了 
							}
						});
					});
					</script>
	
			</tbody>	
		</table>

		<div id="addTmtype" style="display: none; POSITION: absolute; background-color: #f1f1f1; left: 60%; top: 50%; width: 500px; height: 320px; margin-left: -300px; margin-top: -200px; text-align: center; z-index: 11;">
		    <a href="javascript:closeLogin();"><img src="images/nav/cancle.png" style="width:4%;height:6%;margin-left:482px"/></a>
			<table style="margin-left: 80px; margin-right: auto;margin-top:40px;">
				<form id="form1" name="form1" method="post" action="addTmtype">
					<tr>
						<td>教学材料类型ID：</td>
						<td><input name="tmtypeID" type="text" required/></td>
					</tr>
					<tr>
						<td>材料类型名称：</td>
						<td><input name="tmtypeName" type="text" required/></td>
					</tr>
					<tr>
						<td>类型说明：</td>
						<td><input name="typeIntro" type="text" /></td>
					</tr>
					<tr>
						<td>是否必交：</td>
						<td><input name="ismustsub" type="text" required/></td>
					</tr>
					<tr>
						<td>备注：</td>
						<td><input name="typeNote" type="text" /></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;">
						<input type="submit" name="Submit" value="提交" /> 
						<input type="reset" name="Submit2" value="重置" style="margin-left:10px;"/></td>
					</tr>
				</form>
			</table>
		</div>
		<div id="back" id=back
			style="display: none; POSITION: absolute; left: 0; top: 0; width: 100%; height: 100%; background-color: #525252; filter: alpha(opacity = 10); opacity: 0.60; z-index: 10">
		</div>
	    <div id="checkTmtype" style="display: none; POSITION: absolute; background-color: #f1f1f1; left: 60%; top: 50%; width: 500px; height: 320px; margin-left: -300px; margin-top: -200px; text-align: center; z-index: 11;">
	   	 	<a href="javascript:closeLogin();"><img src="images/nav/cancle.png" style="width:4%;height:6%;margin-left:482px"/></a>
	   	 	<table style="margin-left: 160px; margin-right: auto;margin-top:20px;">
				<tr>
					<td>教学材料类型ID：</td>
					<td><input name="tmtypeID" id="c_tmtypeID" type="text" style="border: none;background-color: #f1f1f1;"  readonly /></td>
				</tr>
				<tr>
					<td>材料类型名称：</td>
					<td><input name="tmtypeName" id="c_tmtypeName" type="text" style="border: none;background-color: #f1f1f1;"  readonly/></td>
				</tr>
				<tr>
					<td>类型说明：</td>
					<td><input name="typeIntro" id="c_typeIntro" type="text" style="border: none;background-color: #f1f1f1;" readonly/></td>
				</tr>
				<tr>
					<td>是否必交：</td>
					<td><input name="ismustsub" id="c_ismustsub" type="text" style="border: none;background-color: #f1f1f1;" readonly/></td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input name="typeNote" id="c_typeNote" type="text" style="border: none;background-color: #f1f1f1;" readonly/></td>
				</tr>
			</table>
	    	
	    </div>
	    <div id="modifyTmtype" style="display: none; POSITION: absolute; background-color: #f1f1f1; left: 60%; top: 50%; width: 500px; height: 320px; margin-left: -300px; margin-top: -200px; text-align: center; z-index: 11;">
	        <a href="javascript:closeLogin();"><img src="images/nav/cancle.png" style="width:4%;height:6%;margin-left:482px"/></a>
	        <table style="margin-left: 100px; margin-right: auto;margin-top:40px;">
			    <form id="form1" name="form1" method="post" action="modifyTmtype">
				    <tr>
					    <td>教学材料类型ID：</td>
					    <td><input name="tmtypeID" id="m_tmtypeID" type="text" style="border: none;background-color: #f1f1f1;"  readonly/></td>
				    </tr>
				    <tr>
					    <td>材料类型名称：</td>
					    <td><input name="tmtypeName" id="m_tmtypeName" type="text" required/></td>
				    </tr>
				    <tr>
					    <td>类型说明：</td>
					    <td><input name="typeIntro" id="m_typeIntro" type="text" /></td>
				    </tr>
				    <tr>
					    <td>是否必交：</td>
					    <td><input name="ismustsub" id="m_ismustsub" type="text" required/></td>
				    </tr>
				    <tr>
					    <td>备注：</td>
					    <td><input name="typeNote" id="m_typeNote" type="text" /></td>
				    </tr>
	                <tr>
					    <td colspan="2" style="text-align: center">
					        <input type="submit" name="Submit" value="提交" /> 
					        <input type="reset" name="Submit2" value="重置" style="margin-left:10px;"/>
					    </td>
				    </tr>
			</form>
		</table>
	    </div>
	   </div><!-- tableArea结束 -->

		<div class="operate">
			<button type="button" onclick="addTmtype()" class="operateBtn">[添加]</button>
			<button type="button" onclick="swapCheck()" class="operateBtn">[全选/反选]</button>
			<button type="submit" class="operateBtn" onclick="deleteTmtypes();">[删除]</button>
		</div>
	</div>
	<hr>
	<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer 结束-->
</body>
<script type="text/javascript" language="javascript" src="js/tmtype.js"></script>
</html>