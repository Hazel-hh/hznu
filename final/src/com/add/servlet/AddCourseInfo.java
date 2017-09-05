package com.add.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.CourseInfoDAO;

/**
 * Servlet implementation class addCourseInfo
 */
@WebServlet("/addCourseInfo")
public class AddCourseInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCourseInfo() {
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
		// TODO Auto-generated method stub
		//doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		String courseID=request.getParameter("courseID");
		String courseclassID=request.getParameter("courseclassID");
		String teacherNo=request.getParameter("teacherID");
		String tyear=request.getParameter("tyear");
		String[] classNames=request.getParameterValues("classNames");
		
		String classIDs="";
		CourseInfoDAO dao=new CourseInfoDAO();
		for(int i=0;i<classNames.length;i++){
			if(i==classNames.length-1){
			    classIDs+=dao.queryByClassName(classNames[i]);
			}else{
				classIDs=dao.queryByClassName(classNames[i])+classIDs+",";
			}
			System.out.println(classNames[i]+" "+classIDs);
		}
		int semester=Integer.parseInt(request.getParameter("semester"));
		String modeStr=request.getParameter("mode");
		int mode=0;
		if(modeStr.equals("øº ‘")){
			mode=1;
		}else{
			mode=0;
		}

		
	/*	dao.addCourseClass(teacherNo, tyear, semester, classIDs, courseclassID, courseID,mode);*/
		if(dao.queryByccIDs(courseID, classIDs)==1){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script language='JavaScript'>alert('ÃÌº” ß∞‹');window.location.href='courseClass.jsp';</script>");
		}else{
			int i=dao.addCourseClass(teacherNo, tyear, semester, classIDs, courseclassID, courseID,mode);
			if(i<1){
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script language='JavaScript'>alert('ÃÌº” ß∞‹');window.location.href='courseClass.jsp';</script>");
			}else{
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script language='JavaScript'>alert('ÃÌº”≥…π¶');window.location.href='courseClass.jsp';</script>");
			}
		}
		dao.close();
	}

}
