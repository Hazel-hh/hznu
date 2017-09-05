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
 * Servlet implementation class UpdateMajorServlet
 */
@WebServlet(description = "UpdateMajorServlet", urlPatterns = { "/UpdateMajorServlet" })
public class UpdateMajorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMajorServlet() {
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
		String id = request.getParameter("id"); //�ӱ���� 
		System.out.println(id);
		String major_id= request.getParameter("major_id"); //�ӱ���� 
		String major_name = request.getParameter("major_name"); //�ӱ���� 
		String major_introduction = request.getParameter("major_introduction"); //�ӱ���� 
		String dept_id = request.getParameter("dept_id"); //�ӱ���� 
		String major_note = request.getParameter("major_note"); //�ӱ���� 
		String dept_name = request.getParameter("dept_name"); //�ӱ���� 
		System.out.println(major_name);
		System.out.println(id);
		int isSuccess = 0;
	
		// �ӽ��� ��ȷ���޸ĺ������
		String sql = "update major set major_id='" + major_id + "'," + "major_name='" + major_name + "',major_introduction='" +major_introduction+ "',dept_id='" + dept_id+ "',major_note='" + major_note
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
			System.out.println("���³ɹ�");
			out.print("<script language='JavaScript'>alert('���³ɹ�');window.location.href='major_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('����ʧ��');window.location.href='major_query.jsp';</script>");
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
