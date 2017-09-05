package com.edit.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class UpdateUserServlet
 */
@WebServlet(description = "UpdateUserPassServlet", urlPatterns = { "/UpdateUserPassServlet" })
public class UpdateUserPassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateUserPassServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		
		
		request.setCharacterEncoding("UTF-8");
		DBConnection dbc = new DBConnection();
		System.out.println("创建批量删除用户成功");
		dbc.createConnection();
		String userIds = request.getParameter("userIds");
		System.out.println(userIds);
		String[] userId = userIds.split(",");
		int isSuccess = 0;
		for(int i = 0; i < userId.length; i++){
			String sql =  "update users set password='123456' where username ='"+userId[i]+"'";
			isSuccess = dbc.update(sql);
		}
		
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
		if (isSuccess == 1) {
			System.out.println("更新成功");
			out.print("<script language='JavaScript'>alert('重置密码成功');window.location.href='users_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('重置失败');window.location.href='users_query.jsp';</script>");
		}
		dbc.close();
		response.sendRedirect("users_query.jsp");

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub


		
		request.setCharacterEncoding("UTF-8");
		DBConnection dbc = new DBConnection();
		System.out.println("创建批量删除用户成功");
		dbc.createConnection();
		String userIds = request.getParameter("userIds");
		System.out.println(userIds);
		String[] userId = userIds.split(",");
		int isSuccess = 0;
		for(int i = 0; i < userId.length; i++){
			String sql =  "update users set password='123456' where username ='"+userId[i]+"'";
			isSuccess = dbc.update(sql);
		}
		if (isSuccess == 1) {
			System.out.println("更新成功");
		}
		dbc.close();
		response.sendRedirect("users_query.jsp");

	}
}
