package com.upload.servlet;


import java.io.File;
import java.io.IOException;
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

import com.read.ReadExcel;







/**
 * Servlet implementation class ReadExcel
 */
@WebServlet("/Excel")
public class Excel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Excel(){
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		String fileDir = getServletContext().getRealPath("/upload");
		System.out.println("fileDir: " + fileDir);
		// ָ���ϴ��ļ��ı����ַ
		String message = "�ļ��ϴ��ɹ�";
		String address = "";
		String type="";
		String filename=null;//�ļ���
		String filepath=null;
		int i=0;
		request.setCharacterEncoding("UTF-8");
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
					filename = name.substring(name.lastIndexOf("\\") + 1,
							name.length());
					
					address = fileDir + "\\" + filename; // �����ϴ��ļ��ı����ַ
					File saveFile = new File(address); // �����ļ������ַ�������ļ�
					try {
						formitem.write(saveFile); // ���ļ�д����						
						
						System.out.println(address);
						if(filename.equals("teacher.xls")){
							type="teacherExcel";
						}
						else if(filename.equals("student.xls")){
							type="studentExcel";
						}
						ReadExcel.readExcel(address,type);

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		if(i<1){
			message+="...�ļ���Ϣ����ʧ��";
		}
		if(type.equals("teacherExcel")){
			request.setAttribute("teacher", message); // ����ʾ��Ϣ������request������

			RequestDispatcher requestDispatcher = request
					.getRequestDispatcher("teacher.jsp"); // ������Ӧ���ص�ַ
			requestDispatcher.forward(request, response);
		}
		else if(type.equals("studentExcel")){
			request.setAttribute("student", message); // ����ʾ��Ϣ������request������

			RequestDispatcher requestDispatcher = request
					.getRequestDispatcher("student.jsp"); // ������Ӧ���ص�ַ
			requestDispatcher.forward(request, response);
		}
		
		
	}

}
