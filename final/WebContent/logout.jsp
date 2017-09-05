<!-- 
	作者：何红春
	日期：2017/5/9
	任务：注销页
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	/*
	*销毁用户名session并返回到首页
	*/
	session.removeAttribute("userNo");
	session.removeAttribute("userType");
	response.sendRedirect("index.jsp");
	%>
</body>
</html>