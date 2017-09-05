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
 * Servlet implementation class UpdateClassServlet
 */
@WebServlet(description = "UpdateClassServlet", urlPatterns = { "/UpdateClassServlet" })
public class UpdateClassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateClassServlet() {
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
		String class_id = request.getParameter("class_id"); //�ӱ���� 
		String class_name = request.getParameter("class_name"); //�ӱ���� 
		String class_note = request.getParameter("class_note"); //�ӱ���� 
		String major_id = request.getParameter("major_id"); //�ӱ���� 
		System.out.println(class_id);
		System.out.println(id);
		int isSuccess = 0;
	
		// �ӽ��� ��ȷ���޸ĺ������
		String sql = "update class set class_id='" + class_id + "'," + "class_name='" + class_name + "',class_note='" + class_note+ "',major_id='" + major_id
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
			out.print("<script language='JavaScript'>alert('���³ɹ�');window.location.href='class_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('����ʧ��');window.location.href='class_query.jsp';</script>");
		}
		dbc.close();
		//response.sendRedirect("class_query.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
