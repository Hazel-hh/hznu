package com.upload.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.db.DBConnection;

/**
 * Servlet implementation class batchDownload
 */
@WebServlet("/BatchDownload")
public class BatchDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BatchDownload() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ��ȡresultҳ�洫�ݵĲ���ID
		String materialIds = request.getParameter("materialIds");
		System.out.println("�ļ�ID��" + materialIds);
		String name = URLDecoder.decode(materialIds, "UTF-8");
		System.out.println("�������ؿ�ʼ");
		String[] materialId = materialIds.split(",");
		String[] materialName = new String[materialId.length];// ��ȡҪ�������ص��ļ���
		//���ݲ���ID���������
		for (int i = 0; i < materialId.length; i++) {
			DBConnection dbc = new DBConnection();
			System.out.println("��������ɹ�");
			dbc.createConnection();
			
			String selectSql = "select address from materials where id ='" + materialId[i]+"'";
			System.out.println(materialId[i]);
			ResultSet materialNameRs = dbc.queryForRS(selectSql);
			if (materialNameRs != null) {
				try {
					if (materialNameRs.next()) {
						System.out.println("������");
						try {
							materialName[i] = materialNameRs.getString("address");
						} catch (SQLException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			dbc.close();
			// materialName[i] = material;
			System.out.println(materialName[i]);
		}
		
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment;filename=materials.zip"); // filename����ָ�����ص��ļ���
		//�ļ�·��
		String path = this.getServletContext().getRealPath("/upload") +"/materials/";
		ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
		for (String filename : materialName) {
			File file = new File(path + filename);
			zos.putNextEntry(new ZipEntry(filename));
			FileInputStream fis = new FileInputStream(file);
			try {
				byte b[] = new byte[1024];
				int n = 0;
				while ((n = fis.read(b)) != -1) {
					zos.write(b, 0, n);
				}
			} finally {
				zos.flush();
				fis.close();
			}
		}
		zos.flush();
		zos.close();
		System.out.println("�������سɹ�");
		/*File file = new File(path);
		makeZip(file, "", zos);
		zos.flush();
		zos.close();*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
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
