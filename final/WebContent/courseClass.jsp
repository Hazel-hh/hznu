<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.database.db.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>排课信息管理</title>

<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
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
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="js/table.js"></script>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/jquery-ui.min.css">
<link rel="stylesheet" href="css/jquery.multiselect.css">
<link rel="stylesheet" href="css/jquery.multiselect.filter.css">	
<script type="text/javascript" language="javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.multiselect.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.multiselect.filter.js"></script>

<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">
 <link rel="stylesheet" href="font-awesome/css/font-awesome.css">
<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">

<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>

<link type="text/css" rel="stylesheet" href="css/select2.min.css"/>
<script type="text/javascript" src="js/select2.js"></script>

<style type="text/css">
		.main{
			height:1350px;
		}
		.left .line{
			height:1300px;
		}
		.left{
			height:1200px;
		}
		#mode{
			width:199px;
			height:28px;
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
				<label>课表管理</label>
			</div>
		<table class="table" id="tableList">
			<thead>
				<tr id="head">
					<td>序号</td>
					<td>课程代码</td>
					<td>课程名称</td>
					<td>课程班</td>
					<td>教学班</td>
					<td>教师</td>
					<td>学期</td>
					<td>学年</td>
					<td>考核</td>
					<td>查看</td>
					<td>修改</td>
					<td>选择</td>
					
				</tr>
			</thead>
			<tbody>
				<script type="text/javascript">
			var array=new Array();
			var k=0;
			<%
			CourseInfoDAO dao=new CourseInfoDAO();
			int i=0;
			ArrayList<Map<String,String>> courseList=dao.queryAll();
			
			if(courseList != null)
			for(Map<String,String> courseMap : courseList){			
				String courseID=courseMap.get("course_id");
				String courseName=courseMap.get("course_name");
			    //String courseclassName=courseMap.get("class_name");
				String teacherName=courseMap.get("teacher_name");
				String courseclassID=courseMap.get("course_class_id");
				String classID=courseMap.get("class_id");
				String tyear=courseMap.get("academic_year");
				String semester=courseMap.get("semester");
				String mode=courseMap.get("evaluation_mode");
				if(mode.equals("1")){
					mode="考核";
				}else{
					mode="考查";
				}
				String checklink="checkCourseClass.jsp?courseclassID="+courseclassID;
				String checkStr="<a href='"+checklink+"'>查看</a>";
				
				
				String className1 = "";
				String[] classIds = null;
				if(classID != null)
					classIds = classID.split(",");
				if(classIds != null)
				for(int j = 0; j < classIds.length;j++){
					DBConnection dbc = new DBConnection();
					dbc.createConnection();
					String sql = "select * from class where class_id = '"+classIds[j]+"'";
					System.out.println(classIds[j]+sql);
					ResultSet rs = dbc.queryForRS(sql);
					if(rs != null){
						while(rs.next()){
						    className1 = className1 + rs.getString("class_name")+",";
						}
					}
					dbc.close();
				}	
				if(className1 != null  && !className1.equals(""))
				className1 = className1.substring(0,className1.length()-1);
				
				%>
			var t=new Array();
            t.push(<%=++i %>);
			t.push("<%=courseID%>");
			t.push("<%=courseName%>");
			t.push("<%=courseclassID%>");
			t.push("<%=className1%>");
			t.push("<%=teacherName%>");
			t.push("<%=tyear%>");
			t.push("<%=semester%>");
			t.push("<%=mode%>");
			t.push("<%=checkStr%>");
			t.push("<input type='button' name='modify' class='editBtn' value='修改' onclick='modifyCourseClass(this)'/>");
			t.push("<input type='checkbox' name='id' value='<%=courseclassID%>'/>");
			
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
		<div class="operate">
			<button type="button"  onclick="addCourseInfo()" class="operateBtn">[添加]</button>
			<button type="button" onclick="swapCheck()" class="operateBtn">[全选/反选]</button>
			<button type="submit" class="operateBtn" onclick="deleteClassInfo();">[删除]</button>
	
		</div>
		<div id="back" id=back
				style="display: none; POSITION: absolute; left: 0; top: 0; width: 100%; height: 100%; background-color: #525252; filter: alpha(opacity = 10); opacity: 0.60; z-index: 10">
		</div>
		<div id="addCourseClass" style="display: none; POSITION: absolute; background-color: #f1f1f1; left: 50%; top: 30%; width: 560px; height: 400px; margin-left: -300px; margin-top: -200px; text-align: center; z-index: 11;">
		<a href="javascript:closeLogin();"><img src="images/nav/cancle.png" style="width:4%;height:6%;margin-left:528px"/></a>
		<table style="margin-left: 120px; margin-right: auto;margin-top:20px;">
			<form id="courseclass" name="form1" method="post" action="addCourseInfo">
			    <tr>
			    <td>课程ID：</td>
			    <td><input list="courseIDList" placeholder="课程ID" class="input" type="text" tabindex="2" name="courseID" required />
					    <datalist id="courseIDList"> 
					    <%CourseInfoDAO coursedao = new CourseInfoDAO();
 	                      ArrayList<Map<String, String>> courseIDList = coursedao.queryCourse();
 	                      if (courseIDList != null) {
 		                      for (Map<String, String> courseIDMap : courseIDList) {
 			                      String courseName = courseIDMap.get("course_name");
 			                      String courseID = courseIDMap.get("course_id");
                        %>
					    <option label="<%=courseName%>" value="<%=courseID%>" />
					    <%
						}
						}
						coursedao.close();
					    %> 
					    </datalist></td>
			   </tr>
			    <tr>
			    <td>课程班ID：</td>
			    <td><input name="courseclassID" type="text" class="input" /></td>
			    </tr>
			    <tr>
			    <td>教师工号：</td>
			    <td><input list="teacherIDList" placeholder="教师工号" class="input" type="text" tabindex="2" name="teacherID" required />
				    <datalist id="teacherIDList"> 
				    <%CourseInfoDAO teacherdao = new CourseInfoDAO();
 	                  ArrayList<Map<String, String>> teacherIDList = teacherdao.queryTeacher();
 	                  if (teacherIDList != null) {
 		                  for (Map<String, String> teacherIDMap : teacherIDList) {
 			                  String teacherName = teacherIDMap.get("teacher_name");
 			                  String teacherID = teacherIDMap.get("teacher_no");
                    %>
				    <option label="<%=teacherName%>" value="<%=teacherID%>" />
				    <%
					}
					}
					teacherdao.close();
				    %> 
				    </datalist></td>
			    </tr>
			    <tr>
			    <td>学年：</td>
			    <td><input list="tyearList" placeholder="学年" class="input" type="text" tabindex="2" name="tyear" required />
				    <datalist id="tyearList"> 
				    <%CourseInfoDAO tyeardao = new CourseInfoDAO();
 	                  ArrayList<Map<String, String>> tyearList = tyeardao.queryYearTeam();
 	                  if (tyearList != null) {
 		                  for (Map<String, String> tyearMap : tyearList) {
 			                  String tyearName = tyearMap.get("teaching_year");
                    %>
				    <option label="<%="学年"%>" value="<%=tyearName%>" />
				    <%
					}
					}
					tyeardao.close();
				    %> 
				    </datalist></td>
			    </tr>
	            <tr>
	            <td>学期：</td>
	            <td><input list="semesterList" placeholder="学期" class="input" type="text" tabindex="2" name="semester" required />
				    <datalist id="semesterList">
				    <option label="<%="学期"%>" value="<%=1%>" />
				    <option label="<%="学期"%>" value="<%=2%>" />
				    </datalist></td>
	            </tr>
	            <tr>
	            <td>考核方式：</td>
	            <td> <select name="mode" id="mode">
					<option value="考查" checked>考查</option>
					<option value="考试">考试</option>
				    </select></td>
	            </tr>
                <tr>
                <td>班级：</td>
                <td ><select name="classNames" id="newClassNames1" class="combox" multiple="multiple">
					<%CourseInfoDAO classdao = new CourseInfoDAO();
					  ArrayList<Map<String, String>> classList = classdao.queryClass();
					  if (classList != null) {
							for (Map<String, String> classMap : classList) {
								String className = classMap.get("class_name");
					%>
					<option value="<%=className%>"><%=className%></option>
					<%
						}
						}
						classdao.close();
					%>
				    </select> </td>
                </tr>
                <tr>
                <td colspan="2" style="text-align: center;">
						<input type="submit" name="Submit" value="提交" /> 
						<input type="reset" name="Submit2" value="重置" style="margin-left:10px;"/></td>
				</td>
				</tr>
				
			</form>
		</table>
		
	</div>		
		<div id="modifyCourseInfo" style="display: none; POSITION: absolute; background-color: #f1f1f1; left: 50%; top: 30%; width: 560px; height: 460px; margin-left: -300px; margin-top: -200px; text-align: center; z-index: 11;">
		<a href="javascript:closeLogin();"><img src="images/nav/cancle.png" style="width:4%;height:6%;margin-left:528px"/></a>
			<table style="margin-left: 120px; margin-right: auto;margin-top:20px;">
			<form id="courseclass" name="form1" method="post" action="modifyCourseInfo">
			    <tr>
			    <td>课程名称：</td>
			    <td><input name="courseName" id="courseName" type="text"
						style="border: none;background-color: #f1f1f1" readonly /></td>
			    </tr>
			  <tr>
			    <td>课程班ID：</td>
			    <td><input name="courseclassID" type="text" id="courseclassID" style="border: none;background-color: #f1f1f1" readonly/></td>
			    </tr>
			    <tr>
			    <td>教师工号：</td>
			    <td><input list="teacherIDList" id="teacherName"
						placeholder="教师" class="input" type="text" tabindex="2"
						name="teacherID" required /> <datalist id="teacherIDList">
						<%
							CourseInfoDAO teacherdao1 = new CourseInfoDAO();
							ArrayList<Map<String, String>> teacherIDList1 = teacherdao1.queryTeacher();
							if (teacherIDList1 != null) {
								for (Map<String, String> teacherIDMap : teacherIDList1) {
									String teacherName = teacherIDMap.get("teacher_name");
									String teacherID = teacherIDMap.get("teacher_no");
						%>
						<option label="<%=teacherName%>" value="<%=teacherID%>" />
						<%
							}
							}
							teacherdao1.close();
						%> </datalist></td>
			    </tr>
                <tr>
			    <td>学年：</td>
			    <td><input list="tyearList" id="tyear" placeholder="学年"
					class="input" type="text" tabindex="2" name="tyear" required /> <datalist
						id="tyearList"> <%
 	CourseInfoDAO tyeardao1 = new CourseInfoDAO();
 	ArrayList<Map<String, String>> tyearList1 = tyeardao1.queryYearTeam();
 	if (tyearList1 != null) {
 		for (Map<String, String> tyearMap : tyearList1) {
 			String tyearName = tyearMap.get("teaching_year");
 %>
					<option label="<%="学年"%>" value="<%=tyearName%>" />
					<%
						}
						}
						tyeardao1.close();
					%> </datalist></td>
			    </tr>
			    <tr>
			    <td>学期：</td>
			    <td><input list="semesterList" id="semester" placeholder="学期"
						class="input" type="text" tabindex="2" name="semester" required />
						<datalist id="semesterList">
						<option label="<%="学期"%>" value="<%=1%>" />
						<option label="<%="学期"%>" value="<%=2%>" />
						</datalist></td>
			    </tr>
			    <tr>
			    <td>考核方式：</td>
			    <td><select name="mode" id="mode">
							<option value="考查">考查</option>
							<option value="考试">考试</option>
					</select></td>
			    </tr>
			    <tr>
			    <td>原来选择班级：</td>
			    <td><input type="text" id="classNames" name="classNames" style="border: none;background-color: #f1f1f1" readonly /></td>
			    </tr>
			    <tr>
			    <td>重新选择班级：</td>
			    <td> <select name="newClassNames" id="newClassNames2" class="combox" multiple="multiple">
								<%
									CourseInfoDAO classdao1 = new CourseInfoDAO();
									ArrayList<Map<String, String>> classList1 = classdao1.queryClass();
									if (classList1 != null) {
										for (Map<String, String> classMap : classList1) {
											String className = classMap.get("class_name");
								%>
								<option value="<%=className%>"><%=className%></option>
								<%
									}
									}
									classdao1.close();
								%>
							</select></td>
			    </tr>
             <tr>
                <td colspan="2" style="text-align: center;">
						<input type="submit" name="Submit" value="提交" /> 
						<input type="reset" name="Submit2" value="重置" style="margin-left:10px;"/></td>
				</td>
				</tr>		
			</form>
		</table>
		
	</div>		
		<div class="container kv-main">
			<form enctype="multipart/form-data" id="form1" name="form1" onsubmit="return validate()" action="courseExcel" method="post" class="finishForm">
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
	</div>
	</div>
	<hr />
	<!--footer开始-->
	<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->	

</body>
<script type="text/javascript" language="javascript" src="js/courseClass.js"></script>
</html>