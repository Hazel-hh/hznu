package com.add.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class addTask
 */
@WebServlet("/addTask")
public class AddTask extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTask() {
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
		String taskName =  request.getParameter("taskName");
		String courseId = request.getParameter("courseId");
		String materialTypeId = request.getParameter("materialType");
		String teacherNo = request.getParameter("teacherNo");
		String startDateStr = request.getParameter("startDate");
		String endDateStr = request.getParameter("endDate");
		String teachingYear = request.getParameter("teachingYear");
		String semesterStr = request.getParameter("semester");
		String remarks = request.getParameter("remarks");
		System.out.println("任务说明"+remarks);
		
		//System.out.println("开始日期："+startDateStr+"  截止日期："+endDateStr);
		
    	PrintWriter out = response.getWriter();		
		int semester = 0;
		if(semesterStr != null && !semesterStr.equals("")){
			semester = Integer.parseInt(semesterStr);
		}
		
		DBConnection dbc = new DBConnection();
		System.out.println("创建对象成功");
		dbc.createConnection();
		
		String sql = "insert into task(task_name,"
				+ "course_id,tm_type_id,teacher_no,"
				+ "start_date,end_date,teaching_year,"
				+ "semester,is_finished,is_delete,"
				+ "remark) values('"
				+taskName+"','"
				+courseId+"','"
				+materialTypeId+"','"
				+teacherNo+"','"
				+startDateStr+"','"
				+endDateStr+"','"
				+teachingYear+"',"
				+semester+",0,0,'"
				+remarks+"')";
		int isSuccess = 0;
		isSuccess = dbc.update(sql);
		if(isSuccess == 1){
			System.out.println("发布成功");
        	out.print("<script language='JavaScript'>alert('任务发布成功');window.location.href='taskTable.jsp';</script>");
		}else{
			System.out.println("发布失败");
        	out.print("<script language='JavaScript'>alert('任务发布失败');history.go(-1);</script>");
		}
		dbc.close();
	}
	

}
