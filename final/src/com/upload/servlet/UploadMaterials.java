package com.upload.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.database.db.DBConnection;

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/UploadMaterials")
public class UploadMaterials extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadMaterials() {
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
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//连接数据库
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Connection conn = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp", "root", "root");
			System.out.println("连接数据库成功");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Statement stmt = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 事务，当commit后才提交事务
		try {
			conn.setAutoCommit(false);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PreparedStatement pstmt = null;
		
		//获取参数
		HttpSession session=request.getSession();
		String course_id = session.getAttribute("course_id").toString(); 
		String title = session.getAttribute("title").toString();
		String maTypeId = session.getAttribute("tm_type_id").toString();
		String teacher_no = session.getAttribute("teacher_no").toString();
		int taskId = Integer.parseInt(session.getAttribute("id").toString());
		
		String adjunctname = null;
		//文件保存的位置
		String fileDir = getServletContext().getRealPath("/upload/materials");
		//System.out.println("fileDir: " + fileDir);
		String message = "文件上传成功";
		String address = "";
		request.setCharacterEncoding("UTF-8");
		if (ServletFileUpload.isMultipartContent(request)) { // 判断是否是上传文件			
			//创建工厂对象
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(20 * 1024); // 设置内存中允许存储的字节数
			ServletFileUpload upload = new ServletFileUpload(factory); // 创建新的上传文件句柄
			// 指定上传文件的大小
			int size = 5 * 1024 * 1024; 
			 // 创建保存上传文件的集合对象
			List formlists = null;
			try {
				formlists = upload.parseRequest(request); // 获取上传文件集合
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			
			// 获取上传文件迭代器
			Iterator iter = formlists.iterator(); 
			System.out.println("ok");
			while (iter.hasNext()) {
				// 获取每个上传文件
				FileItem formitem = (FileItem) iter.next(); 
				if (!formitem.isFormField()) {
					// 上传文件的名称
					String name = formitem.getName(); 
					if (formitem.getSize() > size) { 
						// 如果上传文件大于规定的上传文件的大小，退出
						message = "您上传的文件太大，请选择不超过2M的文件";
						break;
					}
					String adjunctsize = new Long(formitem.getSize()).toString(); // 获取上传文件的大小
					if ((name == null) || (name.equals("")) && (adjunctsize.equals("0"))) 
						// 如果上传文件为空，退出
						continue;
					adjunctname = name.substring(name.lastIndexOf("\\") + 1, name.length());
					// 创建上传文件的保存地址（路径+文件名）
					address = fileDir + "\\" + adjunctname; 
					
					System.out.println(adjunctname+"地址"+address);
					
					// 根据文件保存地址，创建文件
					File saveFile = new File(address); 
					
					try {
						// 向文件写数据
						formitem.write(saveFile); 
						request.setAttribute("filepath", "upload/materials/" + adjunctname);
						System.out.println("ok");
					} catch (Exception e) {
						e.printStackTrace();
					}
					//获取当前日期（年-月-日）
					Date now = new Date(); 					
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String date = sdf.format(now); 
					System.out.println(date); 
					
					// 插入语句
					String sql = "insert into materials(id,course_id,tm_type_id,address, teacher_no,is_delete,sub_date) values(?,?,?,?,?,?,?)";
					System.out.println(sql);
					try {
						pstmt = conn.prepareStatement(sql);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					try {// 插入数据
						pstmt.setInt(1, 0);//插入文件名
						pstmt.setString(2, course_id);//插入课程id
						System.out.println(course_id+maTypeId+adjunctname+teacher_no+date);
						pstmt.setString(3, maTypeId);//插入材料类型id
						pstmt.setString(4, adjunctname);//插入文件名
						pstmt.setString(5, teacher_no);//插入教师工号
						pstmt.setInt(6, 0);//插入状态
						pstmt.setString(7, date);//插入状态
					
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}					
				}
			}
		}
		
		// 执行sql语句
		int isSucceed = 0;
		try {
			isSucceed = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 事务提交
		try {
			conn.commit();
			// 事务回滚
			conn.rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 关闭连接
		try {
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		int isUpdate = 0;//更新任务表是否成功
		if (conn != null)
			try {
				conn.close();
				DBConnection dbc = new DBConnection();
				dbc.createConnection();
				String updateSql = "update task set is_read = 1, is_finished = 1 where id = "+taskId;
				isUpdate = dbc.update(updateSql);
				if(isUpdate == 1){
					System.out.println("更新任务表成功");
				}else{
					System.out.println("更新任务表失败");
				}
				dbc.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		response.setCharacterEncoding("UTF-8");
		String CONTENT_TYPE = "text/html; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
    	PrintWriter out = response.getWriter();
		if (isSucceed > 0 && isUpdate > 0) {//插入成功
			System.out.println("添加成功");
			//删除session
			session.removeAttribute("tm_type_id");
			session.removeAttribute("course");
			session.removeAttribute("title");
			session.removeAttribute("teacher_no");
			// 页面重定向
			out.print("<script language='JavaScript'>window.location.href='teacherTask.jsp';alert('提交成功');;</script>");
		} else {//插入失败
			System.out.println("添加失败");
        	
        	//window.location.href='materialsTable.jsp'
        	out.print("<script language='JavaScript'>window.history.back();alert('提交失败');;</script>");
		}
	}
}
