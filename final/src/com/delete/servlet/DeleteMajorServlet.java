package com.delete.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class DeleteMajorServlet
 */
@WebServlet(description = "DeleteMajorServlet", urlPatterns = { "/DeleteMajorServlet" })
public class DeleteMajorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteMajorServlet() {
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
		System.out.println("��������ɹ�");
		dbc.createConnection();
		String id = request.getParameter("id");
		System.out.println(id);
		//String[] materialId = materialIds.split(",");
		int isSuccess = 0;
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
		String sql = "update major set is_deleted = 1 where id ='"+id+"'";
		System.out.println(sql);
		isSuccess = dbc.update(sql);
		
		//update users set setted = 0 where username = '12346';
		if(isSuccess == 1){
			out.print("<script language='JavaScript'>alert('ɾ���ɹ�');window.location.href='major_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('ɾ��ʧ��');window.location.href='major_query.jsp';</script>");
		}
		dbc.close();
		//response.sendRedirect("major_query.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
