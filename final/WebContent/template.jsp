<!-- 
	作者：张梦婕
	日期：2017/5/6
	任务：材料类型模板管理页面
	版本：1.3
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.database.db.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教学材料的模板管理</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">

<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>


<script type="text/javascript" language="javascript" src="js/table.js"></script>

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
				<label>材料模板</label>
			</div>
			<table class="table" id="tableList">
			<thead>
				<tr id="head">
					<td style="width: 6%;">序号</td>
					<td>模板ID</td>
					<td>模板名</td>
					<td>模板类型</td>
					<td>上传日期</td>
					<td>下载</td>
					<td>替换</td>
					<td>选择</td>
				</tr>
			</thead>
			<tbody>
			<script type="text/javascript">
			/*获取表格中的数据*/
			var array = new Array();
			var k=0;
			<%
				TemplateDAO dao = new TemplateDAO();
				ArrayList<Map<String,String>> templates=dao.queryAll();
				int i=0;
				if(templates != null)	
				for (Map<String, String> template : templates) {
				String templateID=template.get("template_id");
			    String templateName=template.get("template_name");
			    String tmtypeName=template.get("tm_type_name");
			    String date=template.get("date");
			    String time=template.get("time");
			    String dataTime=date+" "+time;
			    String path=template.get("path");
			    String downloadlink="downloadTemplate?templateName="+URLEncoder.encode(templateName, "UTF-8");
			    String downloadStr="<a href='"+downloadlink+"'>下载</a>";%> 
	            var t=new Array();
	            
					t.push(<%=++i%>);
					t.push("<%=templateID%>")
					t.push("<%=templateName%>");
					t.push("<%=tmtypeName%>");
					t.push("<%=dataTime%>");
					t.push("<%=downloadStr%>");
					t.push("<input type='button' class='editBtn' name='replace' value='替换' onclick='replace(this)'/>");
					t.push("<input type='checkbox' name='id' value='<%=templateID%>' />");
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
		<div id="back" id=back
			style="display: none; POSITION: absolute; left: 0; top: 0; width: 100%; height: 120%; background-color: #525252; filter: alpha(opacity = 10); opacity: 0.60; z-index: 10">
		</div>
			<div id="replaceinfo" style="display: none; POSITION: absolute; background-color: #f1f1f1; left: 60%; top: 50%; width: 500px; height: 320px; margin-left: -300px; margin-top: -200px; text-align: center; z-index: 11;">
			<a href="javascript:closeLogin();"><img src="images/nav/cancle.png" style="width:4%;height:6%;margin-left:482px"/></a>
				<form action="replaceTemplate" method="post" enctype="multipart/form-data" name="form1" id="form1" onsubmit="return validate()">
					<table style="margin-left: 120px; margin-right: auto;margin-top:40px;">
					    <tr>
							<td>模板ID：</td>
							<td><input type="text" id="templateID" name="templateID" style="border: none;background-color: #f1f1f1;" readonly /></td>
						</tr>
						<tr>
							<td>模板名：</td>
							<td><input type="text" id="templateName" name="templateName" style="border: none;background-color: #f1f1f1;" readonly /></td>
						</tr>
						<tr>
				    <td>模板类型：</td>
				    <td>
				    <input name="tmtypeName" id="tmtypeName" style="border: none;background-color: #f1f1f1;" readonly  /> 
				    </td>
				    </tr>
                    </table>
					<div style="margin-left:120px;margin-top:10px;">
						<input type="file" name="file" value="" id="file"/>
					</div>
					<div style="margin-top:40px;">
						<input type="submit" name="Submit" value="上传" /> 
						<input type="reset" name="Submit2" value="重置" />
					</div>
					
				</form>
			</div>
			<div class="operate">
			<button type="button" value="上传文件" name="uploadBtn" class="operateBtn">[上传文件]</button>
			<button type="button" onclick="swapCheck()" class="operateBtn">[全选/反选]</button>
			<button type="submit" class="operateBtn" onclick="deleteTemplates();">[删除]</button>
			</div>
		
			
			
		<div id="upload" style="display: none; POSITION: absolute; background-color: #f1f1f1; left: 60%; top: 50%; width: 500px; height: 320px; margin-left: -300px; margin-top: -200px; text-align: center; z-index: 11;">
		    <a href="javascript:closeLogin();"><img src="images/nav/cancle.png" style="width:4%;height:6%;margin-left:482px"/></a>
			<form action="uploadTemplate" method="post" enctype="multipart/form-data" name="form1" id="form1" onsubmit="return uploadValidate()">
				<table style="margin-left: 120px; margin-right: auto;margin-top:50px;">
				    <tr>
				    <td>模板类型：</td>
				    <td>
				    <input list="tmtypeType" placeholder="模板类型" class="input" type="text" name="tmtypeType" required /> 
				           <datalist id="tmtypeType">			
							<%
							TmtypeDAO tmtypedao=new TmtypeDAO();
							ArrayList<Map<String, String>> tmtypeList = tmtypedao.queryAll();
							if(tmtypeList != null){
								for (Map<String, String> tmtypeMap : tmtypeList) {
									String tmtypeName = tmtypeMap.get("tm_type_name");
									String tmtypeID = tmtypeMap.get("tm_type_id");
									%>
									<option label="<%=tmtypeName%>" value="<%=tmtypeID%>" />
							<%
									}
								tmtypedao.close();}
							%>
						</datalist>
				    </td>
				    </tr>
					<tr>
					<td>模板ID：</td>
			 	    <td><input name="templateID" type="text"  required/></td> 
					</tr>
			        </table>
					<div style="margin-left:120px;margin-top:10px;">
						<input type="file" name="file" value="" id="uploadFile"/>
					</div>
					<div style="margin-top:40px;">
						<input type="submit" name="Submit" value="上传" /> 
						<input type="reset" name="Submit2" value="重置" />
					</div>
			</form>		
		</div>
		
		</div>
	
	</div>
	<hr>
	<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer 结束-->
	<script src="js/template.js"></script>
</body>
</html>