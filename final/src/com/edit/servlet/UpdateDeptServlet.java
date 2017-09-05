package com.edit.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class UpdateDeptServlet
 */
@WebServlet(description = "UpdateDeptServlet", urlPatterns = { "/UpdateDeptServlet" })
public class UpdateDeptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateDeptServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		DBConnection dbc = new DBConnection();
		System.out.println("创建对象成功");
		dbc.createConnection();
		String id = request.getParameter("id"); //从表单获得 
		System.out.println(id);
		String dept_id = request.getParameter("dept_id"); //从表单获得 
		String dept_name = request.getParameter("dept_name"); //从表单获得 
		String dept_introduction = request.getParameter("dept_introduction"); //从表单获得 
		String dept_note = request.getParameter("dept_note"); //从表单获得 
		System.out.println(dept_note);
		
		System.out.println(id);
		int isSuccess = 0;
	
		// 加禁用 加确认修改后的密码
		String sql = "update dept set dept_id='" + dept_id + "'," + "dept_name='" + dept_name + "',dept_introduction='" + dept_introduction+ "',dept_note='" + dept_note
				+ "' where id='" + id + "'" ;
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
			out.print("<script language='JavaScript'>alert('更新成功');window.location.href='dept_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('更新失败');window.location.href='dept_query.jsp';</script>");
		}
		dbc.close();
		//response.sendRedirect("dept_query.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
