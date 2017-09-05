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
 * Servlet implementation class UpdateSchoolYearServlet
 */
@WebServlet(description = "UpdateSchoolYearServlet", urlPatterns = { "/UpdateSchoolYearServlet" })
public class UpdateSchoolYearServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateSchoolYearServlet() {
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
		String teaching_year = request.getParameter("teaching_year"); //从表单获得 
		String semester = request.getParameter("semester"); //从表单获得 
		String start_date = request.getParameter("start_date"); //从表单获得 
		String end_date = request.getParameter("end_date"); //从表单获得 
		
		System.out.println(id);
		int isSuccess = 0;
	
		// 加禁用 加确认修改后的密码
		String sql = "update tyear_sem set teaching_year='" + teaching_year + "'," + "semester='" + semester + "',start_date='" + start_date+ "',end_date='" + end_date
				+ "' where id='" + id + "'" ;
				System.out.println(sql);
		int i = dbc.update(sql);
		isSuccess = dbc.update(sql);
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();

		if (isSuccess == 1) {
			System.out.println("更新成功");
			out.print("<script language='JavaScript'>alert('更新成功');window.location.href='schoolyear_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('更新失败');window.location.href='schoolyear_query.jsp';</script>");
		}
		dbc.close();
		//response.sendRedirect("schoolyear_query.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
