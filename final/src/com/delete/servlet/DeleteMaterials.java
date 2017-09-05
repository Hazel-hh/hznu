package com.delete.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class deleteMaterials
 */
@WebServlet("/deleteMaterials")
public class DeleteMaterials extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteMaterials() {
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
		DBConnection dbc = new DBConnection();
		System.out.println("创建对象成功");
		dbc.createConnection();
		String materialIds = request.getParameter("materialIds");
		System.out.println("材料id"+materialIds);
		String[] materialId = materialIds.split(",");
		int isSuccess = 0;
		for(int i = 0; i < materialId.length; i++){
			String sql = "update materials set is_delete = 1 where id ='"+materialId[i]+"'";
			isSuccess = dbc.update(sql);
		}
		if(isSuccess == 1){
			System.out.println("删除成功");
		}
		dbc.close();
	}

}
