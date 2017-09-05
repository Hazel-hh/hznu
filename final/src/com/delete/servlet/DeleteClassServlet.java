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
 * Servlet implementation class DeleteClassServlet
 */
@WebServlet(description = "DeleteClassServlet", urlPatterns = { "/DeleteClassServlet" })
public class DeleteClassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteClassServlet() {
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
		
		String sql = "update class set is_delete = 1 where id ='"+id+"'";
		System.out.println(sql);
		isSuccess = dbc.update(sql);
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
		//update users set setted = 0 where username = '12346';
		if(isSuccess == 1){
			System.out.println("isSuccess");
			out.print("<script language='JavaScript'>alert('删除成功');window.location.href='class_query.jsp';</script>");
		}else{
        	out.print("<script language='JavaScript'>alert('删除失败');window.history.back();';</script>");
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
