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
@WebServlet(description = "UpdateSettedServlet", urlPatterns = { "/UpdateSettedServlet" })
public class UpdateSettedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateSettedServlet() {
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
		System.out.println("改变禁止启用状态");
		dbc.createConnection();

		String sql = "select userName,password,email,level,setted FROM users where  is_deleted=0";
		ResultSet rs = dbc.queryForRS(sql);

		String username = request.getParameter("userName");
		System.out.println(username);
		int setted =2;
		try {
				rs.next();
			 setted = rs.getInt("setted");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("获取的"+setted);
		if(setted== 1)
			setted = 2;
		else{
			setted = 1;
		}
		System.out.println("相反的"+setted);
		

		int isSuccess = 0;
		
		// 加禁用 加确认修改后的密码
		String sql2 = "update users set setted=" + setted +" where userName ='"+username+"'";
		System.out.println(sql2);
		int i = dbc.update(sql2);
		isSuccess = dbc.update(sql2);
		
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
		if (isSuccess == 1) {
			System.out.println("更新成功");
			out.print("<script language='JavaScript'>alert('更改成功');window.location.href='users_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('更改失败');window.location.href='users_query.jsp';</script>");
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
		System.out.println("改变禁止启用状态");
		dbc.createConnection();

		String username = request.getParameter("userName");
		System.out.println(username);
		String setted = request.getParameter("setted");
		System.out.println(setted);
		if(setted.equals("1"))
			setted = "2";
		else
			setted = "1";
		System.out.println(setted);
		

		int isSuccess = 0;
		
		// 加禁用 加确认修改后的密码
		String sql = "update users set setted=" + setted +"where username ='"+username+"'";
		System.out.println(sql);
		int i = dbc.update(sql);
		isSuccess = dbc.update(sql);
		
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
		if (isSuccess == 1) {
			System.out.println("更新成功");
			out.print("<script language='JavaScript'>alert('操作成功');window.location.href='users_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('操作失败');window.location.href='users_query.jsp';</script>");
		}
		dbc.close();
		//response.sendRedirect("users_query.jsp");

	}
}
