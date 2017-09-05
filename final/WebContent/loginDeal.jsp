<!-- 
	作者：何红春
	日期：2017/5/9
	任务：登录处理页
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
<link rel="stylesheet" type="text/css" href="css/login.css" />
</head>
<body>
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%
		DBConnection dbc = new DBConnection();
		dbc.createConnection();
		String userType = request.getParameter("userType");
		String userno = request.getParameter("userno");
		String password = request.getParameter("password");
		String sql = "";
		System.out.println("创建对象成功");
		String nameType = "";
		if (userType.equals("admin")) {
			sql = "select * from admin where admin_no='" + userno + "' and password='" + password
					+ "' and is_delete = 0";
			nameType = "username";
		} else if (userType.equals("teacher")) {
			sql = "select * from teacher where teacher_no='" + userno + "' and password='" + password
					+ "' and is_delete = 0";
			nameType = "teacher_name";
		}

		ResultSet rs = dbc.queryForRS(sql);
		//查询成功
		System.out.println("查询成功");
		rs.last();
		int count = rs.getRow();//得到的数据行数
		System.out.println(count);
		if (count > 0) {
			//若登录成功，则，创建session
			String userName = rs.getString(nameType);
			session.setAttribute("userNo",userno);
			session.setAttribute("userName", userName);
			session.setAttribute("userType",userType);
			System.out.println("登录成功");
			if(userType.equals("admin"))
				response.sendRedirect("index.jsp");
			else
				response.sendRedirect("teacherTask.jsp");
		} else {
			System.out.println("登录失败");
	%>
	<script>
		alert("用户名或密码错误！");
		window.history.back();
	</script>
	<%
		}
		//关闭连接
		dbc.close();
	%>
</body>

</html>