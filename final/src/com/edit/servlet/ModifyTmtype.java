package com.edit.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.*;
/**
 * Servlet implementation class modify
 */
@WebServlet("/modifyTmtype")
public class ModifyTmtype extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyTmtype() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		TmtypeDAO dao=new TmtypeDAO();
		String tmtypeID = request.getParameter("tmtypeID");
		String ismustsubStr=request.getParameter("ismustsub");
		String isdeleteStr=request.getParameter("isdelete");
		String tmtypeName=request.getParameter("tmtypeName");
		String typeIntro=request.getParameter("typeIntro");
		String typeNote=request.getParameter("typeNote");
		boolean ismustsub=false;
		boolean isdelete=false;
		if(ismustsubStr.equals("是")){
			ismustsub=true;
		}else if(ismustsubStr.equals("否")){
			ismustsub=false;
		}
		int i=dao.updateTmtype(tmtypeID,
				tmtypeName,typeIntro,
				ismustsub,typeNote,isdelete
				);
		System.out.println("i="+i);
		dao.close();
		
		
		
		if(i>0){
			request.getRequestDispatcher("tmtype.jsp?tmtypeID="+tmtypeID).forward(request,
					response);
			
		}else{
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();        	
        	out.print("<script language='JavaScript'>alert('修改失败');window.location.href='tmtype.jsp';</script>");
			//out.println("用户数据修改失败-"+tmtypeID);
		}
	}
}
