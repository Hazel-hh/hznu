package com.add.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.*;
/**
 * Servlet implementation class addTmtype
 */
@WebServlet("/addTmtype")
public class AddTmtype extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTmtype() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		TmtypeDAO dao=new TmtypeDAO();
		String tmtypeID=request.getParameter("tmtypeID");
		System.out.println(tmtypeID);
		String tmtypeName=request.getParameter("tmtypeName");
		String typeIntro=request.getParameter("typeIntro");
		String ismustsubStr=request.getParameter("ismustsub");
		Boolean ismustsub=false;
		
		if(ismustsubStr=="��"){
			ismustsub=true;
		}
		String typeNote=request.getParameter("typeNote");
		
		boolean isdelete=false;
		if(dao.queryByID(tmtypeID)!=null){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script language='JavaScript'>alert('����ID�Ѵ���');window.location.href='tmtype.jsp';</script>");
		}
		else if(dao.queryByName(tmtypeName)!=null){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script language='JavaScript'>alert('���������Ѵ���');window.location.href='tmtype.jsp';</script>");
		}
		else{
			int i=dao.insert(tmtypeID, tmtypeName, typeIntro, ismustsub, typeNote, isdelete);
			if(i<1){
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script language='JavaScript'>alert('���ʧ��');window.location.href='tmtype.jsp';</script>");
			}else{
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script language='JavaScript'>alert('��ӳɹ�');window.location.href='tmtype.jsp';</script>");
			}
		}
	}

}
