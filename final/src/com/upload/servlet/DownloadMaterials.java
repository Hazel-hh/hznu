package com.upload.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class DownloadServlet
 */
@WebServlet("/DownloadServlet")
public class DownloadMaterials extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DownloadMaterials() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//��ȡresultҳ�洫�ݵ�fileName
		String fileName = request.getParameter("fileName");
		System.out.println("�ļ�����"+fileName);
        String n=URLDecoder.decode(fileName,"UTF-8");
        //�ļ�·��
        String fullFilePath = this.getServletContext().getRealPath("/upload") +"/materials/"+ fileName;
        //����File����
        File file = new File(fullFilePath);        
        if (file.exists()) {
        	//�ļ�����
            String filename = URLEncoder.encode(file.getName(), "UTF-8");
            response.reset();
            response.setContentType("application/x-msdownloade");
            response.addHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
            int fileLength = (int) file.length();
            response.setContentLength(fileLength);
            //�ļ����ȴ���0
            if (fileLength != 0) {
                //����������
                InputStream inStream = new FileInputStream(file);
                byte[] buf = new byte[4096];
                //���������
                ServletOutputStream servletOS = response.getOutputStream();
                int readLength;
                while ((readLength = inStream.read(buf)) != -1) {
                    servletOS.write(buf, 0, readLength);
                }
                //�ر�
                inStream.close();
                servletOS.flush();
                servletOS.close();
            }
        }else{
        	System.out.println("�ļ�������");
        	response.setCharacterEncoding("UTF-8");
    		String CONTENT_TYPE = "text/html; charset=UTF-8";
    		response.setContentType(CONTENT_TYPE);
        	PrintWriter out = response.getWriter();
        	//window.location.href='materialsTable.jsp'
        	out.print("<script language='JavaScript'>window.history.back();alert('�ļ�������');;</script>");
        }
        
  	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
