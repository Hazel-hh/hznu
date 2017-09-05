<!-- 
	作者：何红春
	日期：2017/5/15
	任务：检查用户是否登录--管理员
	版本：1.0
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 判断用户是否登录 -->
<%
	String userNo = null;
	String userType = null;
	if (session.getAttribute("userNo") != null) {
		userNo = session.getAttribute("userNo").toString();
	} else {
		out.print("<script language='JavaScript'>alert('请先登录！');window.location.href='index.jsp';</script>");
	}
	if (session.getAttribute("userType") != null) {
		userType = session.getAttribute("userType").toString();
		if (!userType.equals("admin")) {
			out.print(
					"<script language='JavaScript'>alert('当前模块只对管理员开放！');window.history.back();</script>");
		}
	}
%><!-- 判断用户是否登录结束 -->