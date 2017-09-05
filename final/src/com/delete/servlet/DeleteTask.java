package com.delete.servlet;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class deleteTask
 */
@WebServlet("/deleteTask")
public class DeleteTask extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteTask() {
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
		DBConnection dbc = new DBConnection();
		System.out.println("创建对象成功");
		dbc.createConnection();
		String taskIds = request.getParameter("taskIds");
		System.out.println("任务名称"+taskIds);
		String[] taskId = taskIds.split(",");
		int isSuccess = 0;
		for(int i = 0; i < taskId.length; i++){
			String sql = "update task set is_delete = 1 where id ="+taskId[i];
			System.out.println("删除语句"+sql);
			isSuccess = dbc.update(sql);
		}
		if(isSuccess == 1){
			System.out.println("删除成功");
		}else{
			System.out.println("删除失败");
		}
		dbc.close();
	}

}
