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
@WebServlet(description = "UpdateUserServlet", urlPatterns = { "/UpdateUserServlet" })
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateUserServlet() {
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
		System.out.println("创建对象成功doget");
		dbc.createConnection();

		String username = request.getParameter("userName");
		System.out.println(username);
		String level = request.getParameter("level");
		String email = request.getParameter("email");
		String password = request.getParameter("passwd");
		String password2 = request.getParameter("passwd2");

		int isSuccess = 0;
		// for(int i = 0; i < materialId.length; i++){
		// String sql = "update materials set is_delete = 1 where materials_id
		// ='"+materialId[i]+"'";
		// isSuccess = dbc.update(sql);
		// }

		// 加禁用 加确认修改后的密码
		String sql = "update users set level='" + level + "'," + "email='" + email + "',password='" + password
				+ "' where userName='" + username + "'" + "and setted = 1 ;";
		System.out.println(sql);
		int i = dbc.update(sql);
		isSuccess = dbc.update(sql);
		// update users set setted = 0 where username = '12346';
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
		if (isSuccess == 1) {
			System.out.println("更新成功");
			out.print("<script language='JavaScript'>alert('更新成功');window.location.href='users_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('更新失败');window.location.href='users_query.jsp';</script>");
		}
		dbc.close();
		//response.sendRedirect("users_query.jsp");

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
		System.out.println("创建对象成功doget");
		dbc.createConnection();

		String username = request.getParameter("userName");
		System.out.println(username);
		String level = request.getParameter("level");
		String email = request.getParameter("email");
		String password = request.getParameter("passwd");
		String password2 = request.getParameter("passwd2");

		int isSuccess = 0;
		// for(int i = 0; i < materialId.length; i++){
		// String sql = "update materials set is_delete = 1 where materials_id
		// ='"+materialId[i]+"'";
		// isSuccess = dbc.update(sql);
		// }

		// 加禁用 加确认修改后的密码
		String sql = "update users set level='" + level + "'," + "email='" + email + "',password='" + password
				+ "' where userName='" + username + "'"; /*+ "and setted = 1 ;"*/;
		System.out.println(sql);
		int i = dbc.update(sql);
		isSuccess = dbc.update(sql);
		// update users set setted = 0 where username = '12346';
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
		if (isSuccess == 1) {
			System.out.println("更新成功");
			out.print("<script language='JavaScript'>alert('更新成功');window.location.href='users_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('更新失败');window.location.href='users_query.jsp';</script>");
		}
		dbc.close();

	}
}
