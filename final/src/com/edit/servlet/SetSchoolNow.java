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
 * Servlet implementation class SetSchoolNow
 */
@WebServlet("/SetSchoolNow")
public class SetSchoolNow extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetSchoolNow() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		DBConnection dbc = new DBConnection();
		System.out.println("��������ɹ�");
		dbc.createConnection();
		String id = request.getParameter("id"); //�ӱ���� 
		System.out.println(id);
		
		System.out.println(id);
		int isSuccess1 = 0;
	
		// �ӽ��� ��ȷ���޸ĺ������
		String sql = "update tyear_sem set now = 0";
		System.out.println(sql);
		int i = dbc.update(sql);
		isSuccess1 = dbc.update(sql);
		dbc.close();
		
		dbc.createConnection();
		String sql2 = "update tyear_sem set now=1 where id='" + id + "'" ;
		System.out.println(sql);
		int isSuccess2 = 0;
		isSuccess2 = dbc.update(sql2);
		dbc.close();
		
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();

		if ((isSuccess1 != 0) && (isSuccess2 != 0)) {
			System.out.println("�޸ĳɹ�");
			out.print("<script language='JavaScript'>alert('�޸ĳɹ�');window.location.href='schoolyear_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('�޸�ʧ��');window.location.href='schoolyear_query.jsp';</script>");
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
