package com.upload.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class allDownload
 */
@WebServlet("/allDownload")
public class AllDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AllDownload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment;filename=allMaterials.zip"); // filename����ָ�����ص��ļ���
		//�ļ�·��
		String path = this.getServletContext().getRealPath("/upload/materials") + "/";
		ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
		File file = new File(path);
		makeZip(file, "", zos);
		zos.flush();
		zos.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	/**
	 *  ���� zip �ļ�
	 * @param file �ļ�
	 * @param baseName �ļ�������
	 * @param zos zip �����
	 * @throws IOException 
	 */
	private void makeZip(File file, String baseName, ZipOutputStream zos)
			throws IOException {
		if(file.exists()) {
			if (file.isFile()) {
				//������ļ���д�뵽 zip ����
				zos.putNextEntry(new ZipEntry(baseName + file.getName()));
				FileInputStream fis = new FileInputStream(file);
				byte[] buffer = new byte[1024];
				int r = 0;
				while ((r = fis.read(buffer)) != -1) {
					zos.write(buffer, 0, r);
				}
				zos.flush();
				//�ļ���ȡ���ǵùرգ�
				fis.close();
			} else {
				//�����Ŀ¼���ݹ����������ļ�
				String dirName = baseName + file.getName() + "/";
				zos.putNextEntry(new ZipEntry(dirName));
				File[] subs = file.listFiles();
				for (File f : subs) {
					makeZip(f, dirName, zos);
				}
			}
		}
	}
}
