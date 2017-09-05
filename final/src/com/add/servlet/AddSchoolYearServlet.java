package com.add.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class AddSchoolYearServlet
 */
@WebServlet(description = "AddSchoolYearServlet", urlPatterns = { "/AddSchoolYearServlet" })
public class AddSchoolYearServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddSchoolYearServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		DBConnection dbc = new DBConnection();
		System.out.println("创建对象成功");
		dbc.createConnection();
		String teaching_year = request.getParameter("teaching_year"); //从表单获得 
		String semester = request.getParameter("semester"); //从表单获得 
		String start_date = request.getParameter("start_date"); //从表单获得 
		String end_date = request.getParameter("end_date"); //从表单获得 
		System.out.println(teaching_year);
		//String[] materialId = materialIds.split(",");
		int isNow = 0;
		int is_deleted=0;		
		int isSuccess=0;	
		
		  String insert_sql = "insert into tyear_sem values(null,'" + teaching_year + "','" + semester + "','" + start_date + "','"
					+ end_date + "','"+ isNow+ "','"+ is_deleted + "')";

		System.out.println(insert_sql);
		isSuccess = dbc.update(insert_sql);
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
		PrintWriter out = response.getWriter();		
		if(isSuccess == 1){
			System.out.println("isSuccess");
		
			out.print("<script language='JavaScript'>alert('成功添加学年学期信息');window.location.href='schoolyear_query.jsp';</script>");
			//out.print();
		}else{
			System.out.println("Failed to add ");
	    	
			out.print("<script language='JavaScript'>alert('Failed to add');history.go(-1);</script>");
		}
		dbc.close();
		
		//response.sendRedirect("schoolyear_query.jsp");
	}

}
