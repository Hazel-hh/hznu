package com.upload.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.database.db.TemplateDAO;

/**
 * Servlet implementation class uploadTemplate
 */
@WebServlet("/uploadTemplate")
public class UploadTemplate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadTemplate() {
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
		//doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		String templateDir = getServletContext().getRealPath("/upload/template");
		//System.out.println("fileDir: " + templateDir);
		// ָ���ϴ��ļ��ı����ַ
		String message = "�ļ��ϴ��ɹ�";
		String address = "";
		String templatename=null;//�ļ���
		String templatepath=null;
		String templateID=null;
		String tmtypeID=null;
		
		int i=0;
		TemplateDAO dao=new TemplateDAO();
		
		if (ServletFileUpload.isMultipartContent(request)) { // �ж��Ƿ����ϴ��ļ�
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(20 * 1024); // �����ڴ�������洢���ֽ���
			ServletFileUpload upload = new ServletFileUpload(factory); // �����µ��ϴ��ļ����
			

			int size = 5 * 1024 * 1024; // ָ���ϴ��ļ��Ĵ�С
			List formlists = null; // ���������ϴ��ļ��ļ��϶���
			try {
				formlists = upload.parseRequest(request); // ��ȡ�ϴ��ļ�����
				
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			Iterator iter = formlists.iterator(); // ��ȡ�ϴ��ļ�������
			while (iter.hasNext()) {
				FileItem formitem = (FileItem) iter.next(); // ��ȡÿ���ϴ��ļ�
				if (!formitem.isFormField()) { // ���Բ����ϴ��ļ��ı���
					String name = formitem.getName(); // ��ȡ�ϴ��ļ�������
					if (formitem.getSize() > size) { // ����ϴ��ļ����ڹ涨���ϴ��ļ��Ĵ�С
						message = "���ϴ����ļ�̫����ѡ�񲻳���2M���ļ�";
		
						break; // �˳�����
					} 
					String adjunctsize = new Long(formitem.getSize())
							.toString(); // ��ȡ�ϴ��ļ��Ĵ�С
					if ((name == null) || (name.equals(""))
							&& (adjunctsize.equals("0"))) // ����ϴ��ļ�Ϊ��
						continue; // �˳�����
					templatename = name.substring(name.lastIndexOf("\\") + 1,
							name.length());
					
					address = templateDir + "\\" + templatename; // �����ϴ��ļ��ı����ַ
					File saveFile = new File(address); // �����ļ������ַ�������ļ�
					try {
						formitem.write(saveFile); // ���ļ�д����						
						templatepath="upload/" + templatename;
					} catch (Exception e) {
					    e.printStackTrace();
					}
				}else{
					if("tmtypeType".equals(formitem.getFieldName())){
						//����file���͵Ĳ�����ȡ
						tmtypeID = formitem.getString();
					}else if("templateID".equals(formitem.getFieldName())){
						//����file���͵Ĳ�����ȡ
						templateID = formitem.getString();
					}
				}
			}
		}

		//�ж�ģ��ID�Ѵ���
		System.out.println("ģ��ID"+templateID);
		if(dao.queryByID(templateID)!=0){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script language='JavaScript'>alert('ģ��ID�Ѵ���');window.location.href='template.jsp';</script>");
		}else{
			i=dao.insert(templateID,templatename,tmtypeID,templatepath);
			if(i<1){
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script language='JavaScript'>alert('�ϴ�ʧ��');window.location.href='template.jsp';</script>");
			}else{
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script language='JavaScript'>alert('�ϴ��ɹ�');window.location.href='template.jsp';</script>");
			}
		}
		dao.close();
	}

}
