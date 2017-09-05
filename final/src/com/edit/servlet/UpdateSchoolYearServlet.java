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
		System.out.println("��������ɹ�");
		dbc.createConnection();
		String id = request.getParameter("id"); //�ӱ���� 
		System.out.println(id);
		String teaching_year = request.getParameter("teaching_year"); //�ӱ���� 
		String semester = request.getParameter("semester"); //�ӱ���� 
		String start_date = request.getParameter("start_date"); //�ӱ���� 
		String end_date = request.getParameter("end_date"); //�ӱ���� 
		
		System.out.println(id);
		int isSuccess = 0;
	
		// �ӽ��� ��ȷ���޸ĺ������
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
			System.out.println("���³ɹ�");
			out.print("<script language='JavaScript'>alert('���³ɹ�');window.location.href='schoolyear_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('����ʧ��');window.location.href='schoolyear_query.jsp';</script>");
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
