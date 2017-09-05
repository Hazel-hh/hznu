package com.edit.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.TeacherDao;

/**
 * Servlet implementation class reset
 */
@WebServlet("/resetTeacher")
public class ResetTeacher extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetTeacher() {
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
		String number=request.getParameter("taskId");
		//System.out.println(number);
		String teacher_no=request.getParameter("teacher_no");
		String teacher_name=request.getParameter("teacher_name");
		//String password=request.getParameter("password");
		String gender=request.getParameter("gender");
		String birthday=request.getParameter("birthday");
		String title=request.getParameter("title");
		String education=request.getParameter("education");
		String edu_university=request.getParameter("edu_university");	
		String research_dir=request.getParameter("research_dir");
		String degree=request.getParameter("degree");
		String deg_university=request.getParameter("deg_university");
		String tel=request.getParameter("tel");
		String mobile=request.getParameter("mobile");
		String email=request.getParameter("email");
		String teacher_note=request.getParameter("teacher_note");
		int is_delete=0;
		
		TeacherDao dao=new TeacherDao();
		PrintWriter out = response.getWriter();
		int isSuccess=dao.updateByTeacher_no(teacher_no, teacher_name, gender, birthday, education, title, edu_university, degree, deg_university, research_dir, tel, mobile, email, teacher_note, is_delete);
		if(isSuccess == 1){
			System.out.println("修改成功");
        	out.print("<script language='JavaScript'>alert('修改成功');window.location.href='teacher.jsp';</script>");
		}else{
			System.out.println("修改失败");
        	out.print("<script language='JavaScript'>alert('修改失败');history.go(-1);</script>");
		}
		dao.close();
	}

}
