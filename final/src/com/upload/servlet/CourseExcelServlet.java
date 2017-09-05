package com.upload.servlet;

import java.util.List;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;

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

import com.database.db.*;
import com.read.*;
/**
 * Servlet implementation class courseExcel
 */
@WebServlet("/courseExcel")
public class CourseExcelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CourseExcelServlet() {
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
		String fileDir = getServletContext().getRealPath("/upload");
		//System.out.println("fileDir: " + fileDir);
		// 指定上传文件的保存地址
		String message = "文件上传成功";
		String address = "";
		String type="";
		String filename=null;//文件名
		String filepath=null;
		int i=0;
		request.setCharacterEncoding("UTF-8");
		if (ServletFileUpload.isMultipartContent(request)) { // 判断是否是上传文件
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(20 * 1024); // 设置内存中允许存储的字节数
			ServletFileUpload upload = new ServletFileUpload(factory); // 创建新的上传文件句柄

			int size = 5 * 1024 * 1024; // 指定上传文件的大小
			List formlists = null; // 创建保存上传文件的集合对象
			try {
				formlists = upload.parseRequest(request); // 获取上传文件集合
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			Iterator iter = formlists.iterator(); // 获取上传文件迭代器
			while (iter.hasNext()) {
				FileItem formitem = (FileItem) iter.next(); // 获取每个上传文件
				if (!formitem.isFormField()) { // 忽略不是上传文件的表单域
					String name = formitem.getName(); // 获取上传文件的名称
					if (formitem.getSize() > size) { // 如果上传文件大于规定的上传文件的大小
						message = "您上传的文件太大，请选择不超过2M的文件";
		
						break; // 退出程序
					}
					String adjunctsize = new Long(formitem.getSize())
							.toString(); // 获取上传文件的大小
					if ((name == null) || (name.equals(""))
							&& (adjunctsize.equals("0"))) // 如果上传文件为空
						continue; // 退出程序
					filename = name.substring(name.lastIndexOf("\\") + 1,
							name.length());
					
					address = fileDir + "\\" + filename; // 创建上传文件的保存地址
					File saveFile = new File(address); // 根据文件保存地址，创建文件
					try {
						formitem.write(saveFile); // 向文件写数据						
						
						System.out.println(address);

						ReadCourse.readExcel(address);

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		if(i<1){
			message+="...文件信息保存失败";
		}
			request.setAttribute("course", message); // 将提示信息保存在request对象中

			RequestDispatcher requestDispatcher = request
					.getRequestDispatcher("courseClass.jsp"); // 设置相应返回地址
			requestDispatcher.forward(request, response);
		}
		
}
