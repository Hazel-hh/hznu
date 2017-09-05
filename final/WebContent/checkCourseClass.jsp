<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.database.db.*"%>
<%@ page import="com.bean.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看</title>
<link rel="stylesheet" href="font-awesome/css/font-awesome.css">

<!-- footer -->
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
<!-- table -->
<link rel="stylesheet" type="text/css" href="css/tableArea.css">



<link rel="stylesheet" type="text/css" href="css/left.css">
<link rel="stylesheet" type="text/css" href="css/checkCourseClass.css">
<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">


<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>
<style type="text/css">
		.main{
			height:900px;
		}
		.left{
			height:950px;
		}
		.left .line{
			height:880px;
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
	
		<% 
			String courseclassID=request.getParameter("courseclassID");
			CourseInfoDAO dao=new CourseInfoDAO();
			CourseInfo info=new CourseInfo();
			info=dao.queryByCourseclassID(courseclassID);
			String courseID=info.getCourseID();
			String classIDs=info.getClassID();
			String[] classID=classIDs.split(",");
			String classNames="";
			for(int i=0;i<classID.length;i++){
				if(i==classID.length-1){
					classNames+=dao.queryByClassID(classID[i]);
				}else{
					classNames=dao.queryByClassID(classID[i])+classNames+",";
				}
			}
			String courseName=info.getCourseName();
			String teacherName=info.getTeacherName();
			String title=info.getTitle();
			int stuNum=info.getStuNum();
			int mode=info.getMode();
			String modeStr="";
			if(mode==1){
				modeStr="考试";
			}else{
				modeStr="考核";
			}
			int startWeek=info.getStartWeek();
			int endWeek=info.getEndWeek();
			String start_end=startWeek+"-"+endWeek;
			int theoryHours=info.getTheoryHours();
			int experimentHours=info.getExperimentHours();
			int totalHours=theoryHours+experimentHours;
			int weekHours=totalHours/(endWeek-startWeek+1);
			double credit=info.getCredit();
		%>
	<div class="main">
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>
		<div class="tableArea">
			<div class="cTitle">
				<label>课程信息</label>
			</div>
		<h3>课程信息</h3>
		<div class="content" class="panel">
			<div class="cnt">
				<div>
					课程代码：<input value=<%=courseID%> tabindex="1" style="border: none;"
						readonly>
				</div>
				<div>
					考核方式：<input type="text" value=<%=modeStr%> tabindex="7"
						style="border: none;" readonly />
				</div>
				<div>
					班级名称：<input value=<%=classNames%> tabindex="3"
						style="border: none;" readonly />
				</div>
				<div>
					学分：<input type="text" value="<%=credit%>" style="border: none;"
						readonly />
				</div>
				<div>
					教师姓名：<input value=<%=teacherName%> tabindex="4"
						style="border: none;" readonly />
				</div>
				<div>
					职称：<input value=<%=title%> tabindex="5" style="border: none;"
						readonly />
				</div>
				<div>
					人数：<input type="text" value=<%=stuNum%> tabindex="6"
						style="border: none;" readonly />
				</div>
			</div>
			<div class="cnt">
				<div>
				        课程名称：<input value=<%=courseName%> tabindex="2"
						style="border: none;" readonly>
					
				</div>
				<div>
					起止周：<input type="text" value="<%=start_end%>" tabindex="8"
						style="border: none;" readonly />
				</div>
				<div>
					总学时：<input type="text" value="<%=totalHours%>"
						style="border: none;" readonly />
				</div>
				<div>
					周学时：<input type="text" value="<%=weekHours%>" style="border: none;"
						readonly />
				</div>
				<div>
					理论：<input type="text" value="<%=theoryHours%>"
						style="border: none;" readonly />
				</div>
				<div>
					实验：<input type="text" value="<%=experimentHours%>"
						style="border: none;" readonly />
				</div>
			</div>
		</div>
		</div>
	</div>
	<hr />
	<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
	<!--footer 结束-->
</body>
</html>