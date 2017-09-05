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
 * Servlet implementation class AddClassServlet
 */
@WebServlet(description = "AddClassServlet", urlPatterns = { "/AddClassServlet" })
public class AddClassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddClassServlet() {
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
	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		DBConnection dbc = new DBConnection();
		System.out.println("��������ɹ�");
		dbc.createConnection();
		String class_id = request.getParameter("class_id"); //�ӱ���� 
		String class_name = request.getParameter("class_name"); //�ӱ���� 
		String class_note = request.getParameter("class_note"); //�ӱ���� 
		String major_id = request.getParameter("major_id"); //�ӱ���� 
		System.out.println(class_id);
		//String[] materialId = materialIds.split(",");
		int isSuccess = 0;
		int is_deleted=0;		
		
		  String insert_sql = "insert into class values(null,'" + class_id + "','" + class_name + "','" + class_note + "','"
					+ major_id + "','"+ is_deleted + "')";

		System.out.println(insert_sql);
		isSuccess = dbc.update(insert_sql);
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
		PrintWriter out = response.getWriter();		
		if(isSuccess == 1){
			System.out.println("isSuccess");
		
			out.print("<script language='JavaScript'>alert('�ɹ���Ӱ༶');window.location.href='class_query.jsp';</script>");
			//out.print();
		}else{
			System.out.println("Failed to add ");
	    	
			out.print("<script language='JavaScript'>alert('Failed to add');history.go(-1);</script>");
		}
		dbc.close();
	}
}
