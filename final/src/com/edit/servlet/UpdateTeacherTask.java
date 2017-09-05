package com.edit.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class UpdateTeacherTask
 */
@WebServlet("/UpdateTeacherTask")
public class UpdateTeacherTask extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateTeacherTask() {
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
		request.setCharacterEncoding("UTF-8");
		String taskId = request.getParameter("taskID");
		System.out.println("id");
		int id = Integer.parseInt(taskId);
		DBConnection dbc = new DBConnection();
		System.out.println("��������ҳ��������ɹ�");
		dbc.createConnection();
	
		//����Ϊ�Ѷ�		
		String updateSql = "update task set is_read = 1 where id = "+taskId;
		int isUpdate = dbc.update(updateSql);
		if(isUpdate == 1){
			
			System.out.println("���������ɹ�");
		}else{
			System.out.println("���������ʧ��");
		}
		StringBuffer json =new StringBuffer("{");
        
        json.append("'msg':'"+isUpdate+"'");
        json.append("}");// ����json���ݸ�ʽ

        try {
            PrintWriter out = response.getWriter();
            out.write(json.toString());
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
		dbc.close();
	}

}
