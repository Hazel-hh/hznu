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
 * Servlet implementation class AddDeptServlet
 */
@WebServlet(description = "AddDeptServlet", urlPatterns = { "/AddDeptServlet" })
public class AddDeptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddDeptServlet() {
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
		String dept_id = request.getParameter("dept_id"); //从表单获得 
		String dept_name = request.getParameter("dept_name"); //从表单获得 
		String dept_introduction = request.getParameter("dept_introduction"); //从表单获得 
		String dept_note = request.getParameter("dept_note"); //从表单获得 
		System.out.println(dept_note);
		//String[] materialId = materialIds.split(",");
		int isSuccess = 0;
		int is_deleted=0;		
		
		  String insert_sql = "insert into dept values(null,'" + dept_id + "','" +dept_name+ "','" + dept_introduction + "','"
					+ dept_note + "','"+ is_deleted + "')";

		System.out.println(insert_sql);
		isSuccess = dbc.update(insert_sql);
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(isSuccess == 1){
			System.out.println("isSuccess");
			out.print("<script language='JavaScript'>alert('成功添加系部');window.location.href='dept_query.jsp';</script>");
			//out.print();
		}else{
			System.out.println("Failed to add ");	    	
			out.print("<script language='JavaScript'>alert('Failed to add');history.go(-1);</script>");
		}
		dbc.close();
		
		//response.sendRedirect("dept_query.jsp");
	}

}
