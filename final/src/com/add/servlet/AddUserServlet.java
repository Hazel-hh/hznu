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
 * Servlet implementation class AddUserServlet
 */
@WebServlet(description = "AddUserServlet", urlPatterns = { "/AddUserServlet" })
public class AddUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		
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
		String name = request.getParameter("userName"); //从表单获得 
		String password = request.getParameter("passwd"); //从表单获得 
		String email = request.getParameter("email"); //从表单获得 
		String level = request.getParameter("level"); //从表单获得
		System.out.println(name);

		int isSuccess = 0;
		int setted=1;		
		int is_deleted =0;
		
		  String insert_sql = "insert into users values('" + name + "','" + level + "','" + email + "','"
					+ password + "','"+ setted +  "','"+ is_deleted+"')";

		System.out.println(insert_sql);
		isSuccess = dbc.update(insert_sql);
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
		PrintWriter out = response.getWriter();	
		//update users set setted = 0 where username = '12346';
		if(isSuccess == 1){
			out.print("<script language='JavaScript'>alert('成功添加用户信息');window.location.href='users_query.jsp';</script>");
			//out.print();
		}else{
			System.out.println("Failed to add ");	    	
			out.print("<script language='JavaScript'>alert('添加失败');window.location.href='users_query.jsp';</script>");
		}
		dbc.close();
		
		//response.sendRedirect("users_query.jsp");
		
		
		

}
}
