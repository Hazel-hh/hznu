package com.query.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.database.db.DBConnection;

/**
 * Servlet implementation class CheckMessageFromDB
 */
@WebServlet("/CheckMessageFromDB")
public class CheckMessageFromDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckMessageFromDB() {
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
		DBConnection dbc = new DBConnection();
		dbc.createConnection();
		HttpSession session=request.getSession();
		String teacher_no = session.getAttribute("userNo").toString();
		System.out.println("教师名"+teacher_no);
		String sql = "select * from task where is_read = 0 and is_delete = 0 and teacher_no ='"+teacher_no+"'";
		
		ResultSet rs = dbc.queryForRS(sql);
		int msgCount = 0;
		if(rs != null){
			try {
				rs.last();
				msgCount = rs.getRow();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		System.out.println(msgCount);
		StringBuffer json =new StringBuffer("{");
        
        json.append("'msg':'"+msgCount+"'");
        json.append("}");// 构造json数据格式

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
