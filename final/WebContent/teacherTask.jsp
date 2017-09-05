<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="20">
<title>教师端任务页面</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<link rel="stylesheet" href="css/teacherTask.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<!-- 导航栏 -->
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/left.css">
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>

<script src="js/nav.js"></script>
<script src="js/navChange.js"></script>

<style type="text/css">
	.main{
		/*height:800px;*/
	}
</style>
</head>
<body>
	<!-- 判断用户是否登录 -->
	<%
		String username = null;
		if (session.getAttribute("userName") != null) {
			username = session.getAttribute("userName").toString();
		}else{
        	out.print("<script language='JavaScript'>alert('请先登录！');window.location.href='index.jsp';</script>");
		}
		String teacher_no = "";
		if (session.getAttribute("userNo") != null) {
			teacher_no = session.getAttribute("userNo").toString();
		}else{
        	out.print("<script language='JavaScript'>alert('请先登录！');window.location.href='index.jsp';</script>");
		}
		String userType = null;
		if (session.getAttribute("userType") != null) {
			userType = session.getAttribute("userType").toString();
			if (!userType.equals("teacher")) {
				out.print(
						"<script language='JavaScript'>alert('当前模块只对教师开放！');window.history.back();</script>");
			}			
		}
	%><!-- 判断用户是否登录结束 -->

	<!--header开始-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header结束-->
	
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.net.URLEncoder"%>
	
	<%
	request.setCharacterEncoding("UTF-8");
	DBConnection dbc = new DBConnection();
	System.out.println("任务页创建对象成功");
	dbc.createConnection();
	
	String sql = "select * from task where is_delete = 0 and teacher_no ='"+teacher_no+"'";
	
	ResultSet rs = dbc.queryForRS(sql);
	%>
	<div class="main">	
		
		<!-- 课程导航模板 -->
		<div class="functionArea">
			<div class="cTitle" style="width:87%;margin:0 auto;">
				<label>任务列表</label>
			</div>
			<span id="tongzhi" style="display:none">
					<div id="circle">
			      		<p id="tongzhi-content">0</p>
			    	</div>
				</span>
			<ul class="imglist"> 
			   <%
			   	if(rs != null){
			   		int i = 0;
			   		while(rs.next()){
			   			int id = rs.getInt("id");
			   			System.out.println(id);
			   			String title = rs.getString("task_name");
			   			String startDate = rs.getString("start_date");
			   			String endDate = rs.getString("end_date");
			   			Date pubDate = rs.getDate("pub_time");
			   			int is_finish = rs.getInt("is_finished");
			   			int is_read = rs.getInt("is_read");
			   			String isFinishStr = "";
			   			String stateClass = "unFinished";
			   			if(is_finish == 1){
			   				isFinishStr = "已完成";
			   				stateClass="finished";		   				
			   			}else{
			   				isFinishStr = "未完成";
			   				stateClass="unFinished";
			   			}
			   			String remark="";
			   			if(rs.getString("remark")!=null && !rs.getString("remark").trim().equals("")){
			   				remark = rs.getString("remark");
			   			}
			   
			   			//显示图片
			   			String imgUrl= "images/course/course1.jsp";
			   			if((i+1) <= 5 ){
			   				imgUrl = "images/course/course"+(i+1)+".jpg";
			   			}else{
			   				int temp = (i+1) % 5;
			   				imgUrl = "images/course/course"+temp+".jpg";
			   			}
			   			
			   			String newInfoClass = "";
			   			
			   			//消息提示
			   			if(is_read == 0){
			   				newInfoClass = "newInfo";
			   			}
			   			i++;		   			
			    %>
			   	<%
			   	
			   	%>
			    <li>
			      <a href="finishTask.jsp?taskID=<%=URLEncoder.encode(id+"","UTF-8") %>" target="_blank">
			       <%-- <a href="javascript:void(0);" onclick="checkTask(<%=URLEncoder.encode(id+"","UTF-8") %>)" id="taskItem" target="_blank"> --%>
			           <img src="<%=imgUrl %>" />
			           <span class="title"><%=title %> 
				           <div class="<%=newInfoClass %>" id="tongzhi">
		      	    		</div>
	      	    		</span>
			       		<span class="date">开始时间：<%=startDate %></span>
			       		<span class="date">结束时间：<%=endDate %></span>
			        	<span class="<%=stateClass %>"><%=isFinishStr %></span>
			        </a>
			    </li> 
			    
			    <%
					}
			   		
			   	}
				dbc.close();
			    %>
	
			</ul> 
		</div>
		</div>
		<!-- 课程模块结束 -->
		<hr>
		<!--footer开始-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer 结束-->
	
</body>
<script>
setTimeout(function(){
    Push();
//  alert("setTimeout called");
},200);

setInterval(function(){
    Push();
    //alert("setInterval called");
},200);

function Push(){
    $.ajax({
        type:"POST",
        url:"CheckMessageFromDB?dt=" + new Date().getTime()+"&teacher_no="+<%=teacher_no%>,//why getTime and wont use
        data:{},
        beforeSend:function(){},
        success: function(data){
            var obj=eval("("+data+")");//eval使用前要先加括号，才能得到完整的json数据
            if(obj.msg!=0){
                $("#tongzhi-content").html(obj.msg);//更新提示内容中的数量部分
                $("#tongzhi").show();//消息提示内容，整个部分都显示出来
            }else{
                $("#tongzhi").hide();//隐藏整个提示消息部分
            }
        }
    });
}	
</script>
<script type="text/javascript" src="js/teacherTask.js" ></script>
</html>