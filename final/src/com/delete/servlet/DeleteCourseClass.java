package com.delete.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.*;

/**
 * Servlet implementation class deleteClass
 */
@WebServlet("/deleteCourseClass")
public class DeleteCourseClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCourseClass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String ccIDs=request.getParameter("ccIDs");
		System.out.println(ccIDs);
		CourseInfoDAO dao=new CourseInfoDAO();
		String[] ccID = ccIDs.split(",");
		for(int i=0;i<ccID.length;i++){
			dao.deleteByccID(ccID[i]);
		}
		dao.close();
		//response.sendRedirect("courseClass.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
