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
		// 获取result页面传递的材料ID
		String materialIds = request.getParameter("materialIds");
		System.out.println("文件ID：" + materialIds);
		String name = URLDecoder.decode(materialIds, "UTF-8");
		System.out.println("批量下载开始");
		String[] materialId = materialIds.split(",");
		String[] materialName = new String[materialId.length];// 获取要请求下载的文件名
		//根据材料ID查出材料名
		for (int i = 0; i < materialId.length; i++) {
			DBConnection dbc = new DBConnection();
			System.out.println("创建对象成功");
			dbc.createConnection();
			
			String selectSql = "select address from materials where id ='" + materialId[i]+"'";
			System.out.println(materialId[i]);
			ResultSet materialNameRs = dbc.queryForRS(selectSql);
			if (materialNameRs != null) {
				try {
					if (materialNameRs.next()) {
						System.out.println("有数据");
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
		response.setHeader("Content-Disposition", "attachment;filename=materials.zip"); // filename参数指定下载的文件名
		//文件路径
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
		System.out.println("批量下载成功");
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
	 *  制作 zip 文件
	 * @param file 文件
	 * @param baseName 文件根包名
	 * @param zos zip 输出流
	 * @throws IOException 
	 */
	private void makeZip(File file, String baseName, ZipOutputStream zos)
			throws IOException {
		if(file.exists()) {
			if (file.isFile()) {
				//如果是文件，写入到 zip 流中
				zos.putNextEntry(new ZipEntry(baseName + file.getName()));
				FileInputStream fis = new FileInputStream(file);
				byte[] buffer = new byte[1024];
				int r = 0;
				while ((r = fis.read(buffer)) != -1) {
					zos.write(buffer, 0, r);
				}
				zos.flush();
				//文件读取完后记得关闭！
				fis.close();
			} else {
				//如果是目录。递归查找里面的文件
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
