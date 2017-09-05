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
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet(description = "DeleteUserServlet", urlPatterns = { "/DeleteUserServlet" })
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		// TODO Auto-generated method stub
				request.setCharacterEncoding("UTF-8");
				DBConnection dbc = new DBConnection();
				System.out.println("创建对象成功");
				dbc.createConnection();
				String username = request.getParameter("userName");
				System.out.println(username);
				//String[] materialId = materialIds.split(",");
				int isSuccess = 0;
				
				String sql = "update users set is_deleted = 1 where username ='"+username+"'";
				System.out.println(sql);
				isSuccess = dbc.update(sql);
				
				System.out.println("文件不存在");
	        	response.setCharacterEncoding("UTF-8");
	    		String CONTENT_TYPE = "text/html; charset=UTF-8";
	    		response.setContentType(CONTENT_TYPE);
	        	PrintWriter out = response.getWriter();
				//update users set setted = 0 where username = '12346';
				if(isSuccess == 1){
					System.out.println("isSuccess");					
		        	out.print("<script language='JavaScript'>alert('删除成功');window.location.href='users_query.jsp';</script>");
				}else{
		        	out.print("<script language='JavaScript'>alert('删除失败');window.location.href='users_query.jsp';</script>");
				}
				dbc.close();
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
		String username = request.getParameter("username");
		System.out.println(username);
		//String[] materialId = materialIds.split(",");
		int isSuccess = 0;
		
		
		String sql = "update users set is_deleted = 1 where username =' "+username+"'";
		//update users set setted = 0 where username = '12346';
		if(isSuccess == 1){
			System.out.println("删除成功");
		}
		dbc.close();
	}

}
