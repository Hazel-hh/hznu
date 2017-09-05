package com.delete.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class DeleteSchoolyearServlet
 */
@WebServlet(description = "DeleteSchoolyearServlet", urlPatterns = { "/DeleteSchoolyearServlet" })
public class DeleteSchoolyearServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteSchoolyearServlet() {
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
		String id = request.getParameter("id");
		System.out.println(id);
		//String[] materialId = materialIds.split(",");
		int isSuccess = 0;
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
    	String sql2 = "select * from tyear_sem where is_deleted = 0 and  id ="+id;
		ResultSet rs = dbc.queryForRS(sql2);
		try {
			rs.last();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			int isNow = rs.getInt("now");
			System.out.println(isNow);
		if (isNow == 1)
			out.print("<script language='JavaScript'>alert('不能删除当前学年的信息，请先重新设定当前学年学期');window.location.href='schoolyear_query.jsp';</script>");
		else {
	
		
		
		String sql = "update tyear_sem set is_deleted = 1 where id ='"+id+"'";
		System.out.println(sql);
		isSuccess = dbc.update(sql);
		
		//update users set setted = 0 where username = '12346';
		if(isSuccess == 1){
			System.out.println("isSuccess");
			out.print("<script language='JavaScript'>alert('删除成功');window.location.href='schoolyear_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('删除失败');window.location.href='schoolyear_query.jsp';</script>");
		}
		}
		dbc.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
