package com.add.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.StudentDao;

/**
 * Servlet implementation class addStudent
 */
@WebServlet("/addStudent")
public class AddStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddStudent() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String student_no=request.getParameter("student_no");
		String student_name=request.getParameter("student_name");
		String password=request.getParameter("password");
		String gender=request.getParameter("gender");
		String birthday=request.getParameter("birthday");
		String dept_id=request.getParameter("dept_id");
		String major_id=request.getParameter("major_id");
		String grade=request.getParameter("grade");	
		String class_id=request.getParameter("class_id");
		String mobile=request.getParameter("mobile");
		String email=request.getParameter("email");
		String student_note=request.getParameter("student_note");
		int is_delete=0;
		
		StudentDao dao=new StudentDao();
		int isSuccess=dao.insertStudent(student_no, student_name, password, gender, birthday, dept_id, major_id, grade, class_id, mobile, email, student_note, is_delete);
		if(isSuccess == 1){
			System.out.println("添加成功");
        	out.print("<script language='JavaScript'>alert('添加成功');window.location.href='student.jsp';</script>");
		}else{
			System.out.println("添加失败");
        	out.print("<script language='JavaScript'>alert('添加失败');history.go(-1);</script>");
		}
	}

}
