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
		//�������ݿ�
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Connection conn = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp", "root", "root");
			System.out.println("�������ݿ�ɹ�");
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
		// ���񣬵�commit����ύ����
		try {
			conn.setAutoCommit(false);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PreparedStatement pstmt = null;
		
		//��ȡ����
		HttpSession session=request.getSession();
		String course_id = session.getAttribute("course_id").toString(); 
		String title = session.getAttribute("title").toString();
		String maTypeId = session.getAttribute("tm_type_id").toString();
		String teacher_no = session.getAttribute("teacher_no").toString();
		int taskId = Integer.parseInt(session.getAttribute("id").toString());
		
		String adjunctname = null;
		//�ļ������λ��
		String fileDir = getServletContext().getRealPath("/upload/materials");
		//System.out.println("fileDir: " + fileDir);
		String message = "�ļ��ϴ��ɹ�";
		String address = "";
		request.setCharacterEncoding("UTF-8");
		if (ServletFileUpload.isMultipartContent(request)) { // �ж��Ƿ����ϴ��ļ�			
			//������������
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(20 * 1024); // �����ڴ�������洢���ֽ���
			ServletFileUpload upload = new ServletFileUpload(factory); // �����µ��ϴ��ļ����
			// ָ���ϴ��ļ��Ĵ�С
			int size = 5 * 1024 * 1024; 
			 // ���������ϴ��ļ��ļ��϶���
			List formlists = null;
			try {
				formlists = upload.parseRequest(request); // ��ȡ�ϴ��ļ�����
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			
			// ��ȡ�ϴ��ļ�������
			Iterator iter = formlists.iterator(); 
			System.out.println("ok");
			while (iter.hasNext()) {
				// ��ȡÿ���ϴ��ļ�
				FileItem formitem = (FileItem) iter.next(); 
				if (!formitem.isFormField()) {
					// �ϴ��ļ�������
					String name = formitem.getName(); 
					if (formitem.getSize() > size) { 
						// ����ϴ��ļ����ڹ涨���ϴ��ļ��Ĵ�С���˳�
						message = "���ϴ����ļ�̫����ѡ�񲻳���2M���ļ�";
						break;
					}
					String adjunctsize = new Long(formitem.getSize()).toString(); // ��ȡ�ϴ��ļ��Ĵ�С
					if ((name == null) || (name.equals("")) && (adjunctsize.equals("0"))) 
						// ����ϴ��ļ�Ϊ�գ��˳�
						continue;
					adjunctname = name.substring(name.lastIndexOf("\\") + 1, name.length());
					// �����ϴ��ļ��ı����ַ��·��+�ļ�����
					address = fileDir + "\\" + adjunctname; 
					
					System.out.println(adjunctname+"��ַ"+address);
					
					// �����ļ������ַ�������ļ�
					File saveFile = new File(address); 
					
					try {
						// ���ļ�д����
						formitem.write(saveFile); 
						request.setAttribute("filepath", "upload/materials/" + adjunctname);
						System.out.println("ok");
					} catch (Exception e) {
						e.printStackTrace();
					}
					//��ȡ��ǰ���ڣ���-��-�գ�
					Date now = new Date(); 					
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String date = sdf.format(now); 
					System.out.println(date); 
					
					// �������
					String sql = "insert into materials(id,course_id,tm_type_id,address, teacher_no,is_delete,sub_date) values(?,?,?,?,?,?,?)";
					System.out.println(sql);
					try {
						pstmt = conn.prepareStatement(sql);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					try {// ��������
						pstmt.setInt(1, 0);//�����ļ���
						pstmt.setString(2, course_id);//����γ�id
						System.out.println(course_id+maTypeId+adjunctname+teacher_no+date);
						pstmt.setString(3, maTypeId);//�����������id
						pstmt.setString(4, adjunctname);//�����ļ���
						pstmt.setString(5, teacher_no);//�����ʦ����
						pstmt.setInt(6, 0);//����״̬
						pstmt.setString(7, date);//����״̬
					
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}					
				}
			}
		}
		
		// ִ��sql���
		int isSucceed = 0;
		try {
			isSucceed = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// �����ύ
		try {
			conn.commit();
			// ����ع�
			conn.rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// �ر�����
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
		int isUpdate = 0;//����������Ƿ�ɹ�
		if (conn != null)
			try {
				conn.close();
				DBConnection dbc = new DBConnection();
				dbc.createConnection();
				String updateSql = "update task set is_read = 1, is_finished = 1 where id = "+taskId;
				isUpdate = dbc.update(updateSql);
				if(isUpdate == 1){
					System.out.println("���������ɹ�");
				}else{
					System.out.println("���������ʧ��");
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
		if (isSucceed > 0 && isUpdate > 0) {//����ɹ�
			System.out.println("��ӳɹ�");
			//ɾ��session
			session.removeAttribute("tm_type_id");
			session.removeAttribute("course");
			session.removeAttribute("title");
			session.removeAttribute("teacher_no");
			// ҳ���ض���
			out.print("<script language='JavaScript'>window.location.href='teacherTask.jsp';alert('�ύ�ɹ�');;</script>");
		} else {//����ʧ��
			System.out.println("���ʧ��");
        	
        	//window.location.href='materialsTable.jsp'
        	out.print("<script language='JavaScript'>window.history.back();alert('�ύʧ��');;</script>");
		}
	}
}
