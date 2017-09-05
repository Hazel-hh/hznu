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
 * Servlet implementation class AddMajorServlet
 */
@WebServlet(description = "AddMajorServlet", urlPatterns = { "/AddMajorServlet" })
public class AddMajorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMajorServlet() {
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
		System.out.println("��������ɹ�");
		dbc.createConnection();
		String major_id= request.getParameter("major_id"); //�ӱ���� 
		String major_name = request.getParameter("major_name"); //�ӱ���� 
		String major_introduction = request.getParameter("major_introduction"); //�ӱ���� 
		String dept_id = request.getParameter("dept_id"); //�ӱ���� 
		String major_note = request.getParameter("major_note"); //�ӱ���� 
		String dept_name = request.getParameter("dept_name"); //�ӱ���� 
		System.out.println(major_name);
		//String[] materialId = materialIds.split(",");
		int isSuccess = 0;
		int is_deleted=0;		
		
		  String insert_sql = "insert into major values(null,'" + major_id+ "','" +major_name+ "','" + major_introduction + "','"
					+ dept_id + "','" +major_note + "','"+ is_deleted + "')";

		System.out.println(insert_sql);
		isSuccess = dbc.update(insert_sql);	
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
		PrintWriter out = response.getWriter();	
		if(isSuccess == 1){
			System.out.println("isSuccess");		
			out.print("<script language='JavaScript'>alert('�ɹ����רҵ');window.location.href='major_query.jsp';</script>");
			//out.print();
		}else{
			System.out.println("Failed to add ");	    	
			out.print("<script language='JavaScript'>alert('���ʧ�ܣ��������Ƿ���Ϲ淶');window.location.href='major_query.jsp';</script>");
		}
		dbc.close();
	
		
		//response.sendRedirect("major_query.jsp");
	}

}
