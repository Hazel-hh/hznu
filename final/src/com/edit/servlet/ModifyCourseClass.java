package com.edit.servlet;

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
 * Servlet implementation class modifyInfo
 */
@WebServlet("/modifyCourseInfo")
public class ModifyCourseClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyCourseClass() {
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
		CourseInfoDAO dao=new CourseInfoDAO();
		
		String className=request.getParameter("className");
		String courseName=request.getParameter("courseName");
		String classID=dao.queryByClassName(className);
		String courseID=dao.queryByCourseName(courseName);
		String courseclassID=request.getParameter("courseclassID");
		String tyear=request.getParameter("tyear");
		int semester=Integer.parseInt(request.getParameter("semester"))  ;
		String modeStr=request.getParameter("mode");
		String[] classNames=request.getParameterValues("newClassNames");
		String oldClassNames=request.getParameter("classNames");
		String classIDs="";
		if(classNames==null){
			classNames=oldClassNames.split(",");
		}
		for(int i=0;i<classNames.length;i++){
			if(i==classNames.length-1){
			    classIDs+=dao.queryByClassName(classNames[i]);
			}else{
				classIDs=dao.queryByClassName(classNames[i])+classIDs+",";
			}
			System.out.println(classNames[i]+" "+classIDs);
		}
	
			
		int mode=0;
		if(modeStr.equals("考试")){
			mode=1;
		}else{
			mode=0;
		}
		String teacherNo=dao.queryByTeacherName1(request.getParameter("teacherID"));
		/*if(dao.queryByccID(courseclassID)!=0){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script language='JavaScript'>alert('课程班名已存在');window.location.href='courseClass.jsp';</script>");
		}else{*/
		    int i=dao.modifyInfo(courseclassID,courseID,teacherNo,semester,tyear,mode, classIDs );
		    if(i<1){
			    response.setContentType("text/html;charset=UTF-8");
			    PrintWriter out=response.getWriter();
			    out.println("<script language='JavaScript'>alert('修改失败');window.location.href='courseClass.jsp';</script>");
		    }else{
			    response.setContentType("text/html;charset=UTF-8");
			    PrintWriter out=response.getWriter();
			    out.println("<script language='JavaScript'>alert('修改成功');window.location.href='courseClass.jsp';</script>");
		    }
		//}
		dao.close();
	}

}
