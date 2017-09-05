package com.database.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.swing.JOptionPane;

import com.bean.Student;
import com.bean.Teacher;

public class StudentDao {
	String sql="";
	DBConnection dbCon;
	
	public StudentDao() {
		dbCon=new DBConnection();//数据库连接对象
		dbCon.createConnection();
		
	}
	public Student getStudent(String sql){
		Student student=null;
		//将结果放到结果集
		ResultSet rs=dbCon.queryForRS(sql);
		if(rs!=null){
			try{
				if(rs.next()){					
					student=new Student();
					student.setStudent_no(rs.getString("student_no"));
					student.setStudent_name(rs.getString("student_name"));
					student.setPassword(rs.getString("password"));
					student.setGender(rs.getString("gender"));
					student.setBirthday(rs.getString("birthday"));
					student.setDept_id(rs.getString("dept_id"));
					student.setDept_name(rs.getString("dept_name"));
					student.setMajor_id(rs.getString("major_id"));
					student.setMajor_name(rs.getString("major_name"));
					student.setGrade(rs.getString("grade"));
					student.setClass_id(rs.getString("class_id"));
					student.setClass_name(rs.getString("class_name"));
					student.setMobile(rs.getString("mobile"));
					student.setEmail(rs.getString("email"));
					student.setStudent_note(rs.getString("student_note"));
					student.setIs_delete(rs.getInt("is_delete"));
					
				}
			}catch(SQLException e){
				e.printStackTrace();
				
			}		}
		return student;
	}
	//批量导入
	public int addStudent(String student_no,String student_name,String password,String gender,String birthday,
			String dept_id,String major_id,String grade,String class_id,String mobile,String email,String student_note,int is_delete){
		
		
		if(findByStudent_no(student_no)==1){
			 password="123456";
			 sql = "update student set student_name='" + student_name + "',password='" + password + "',gender='" + gender 
		             + "',birthday='" + birthday + "',dept_id='" + dept_id + "',major_id='" + major_id 
		             + "',grade='" + grade + "',class_id='"+ class_id + "',mobile='"+ mobile+"',email='" + email+ "',student_note='" + student_note+ "',is_delete='" +is_delete  
		             +"' where student_no='" + student_no+ "'";

		 }
		 else{
			// 插入到数据库
			 password = "123456";
			sql = "insert into student(student_no, student_name, password, gender,birthday,dept_id,major_id,grade,class_id,mobile,email,student_note,is_delete)"
				+ "values('"+student_no+"','"+student_name+"','"+password+"','"+gender+"','"+birthday+"','"+dept_id+"','"+major_id+"','"+grade+"','"+class_id+"','"+mobile+"','"+email+"','"+student_note+"','"+is_delete+"')";

		 }
		 //System.out.println(sql);
		 return dbCon.update(sql);
	}
	//修改用户
	public int resetStudent(String student_no,String student_name,String gender,String birthday,
			String dept_id,String major_id,String grade,String class_id,String mobile,String email,String student_note,int is_delete){
	
			 sql = "update student set student_name='" + student_name + "',gender='" + gender 
		             + "',birthday='" + birthday + "',dept_id='" + dept_id + "',major_id='" + major_id 
		             + "',grade='" + grade + "',class_id='"+ class_id + "',mobile='"+ mobile+"',email='" + email+ "',student_note='" + student_note+ "',is_delete='" +is_delete  
		             +"' where student_no='" + student_no+ "'";

		 return dbCon.update(sql);
	}
	//增加用户
	public int insertStudent(String student_no,String student_name,String password,String gender,String birthday,
			String dept_id,String major_id,String grade,String class_id,String mobile,String email,String student_note,int is_delete){
		if(findByStudent_no(student_no)==1){
			JOptionPane.showMessageDialog(null, "学生已存在");
		 }
		 else{
			// 插入到数据库
			sql = "insert into student(student_no, student_name, password, gender,birthday,dept_id,major_id,grade,class_id,mobile,email,student_note,is_delete)"
				+ "values('"+student_no+"','"+student_name+"','"+password+"','"+gender+"','"+birthday+"','"+dept_id+"','"+major_id+"','"+grade+"','"+class_id+"','"+mobile+"','"+email+"','"+student_note+"','"+is_delete+"')";

		 }
		 //System.out.println(sql);
		 return dbCon.update(sql);
	}
	
	//根据学号查询学生信息
	private int findByStudent_no(String student_no) {
		sql = "select * from student where student_no='" + student_no + "'";
		//System.out.println(sql);
		ResultSet rs= dbCon.queryForRS(sql);
		int i=0;
		try {
			rs.last();
			if(rs.getRow()!=0){
			  i=1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}
	//根据姓名查询学生信息
	public Student findByStudent_name(String student_no) {
			//DBConnection dbCon=new DBConnection();
			dbCon.createConnection();
			sql = "select * from student join dept on student.dept_id = dept.dept_id "
					+" join major on student.major_id = major.major_id "
					+ " join class on student.class_id = class.class_id where student_no='" + student_no + "'";
			System.out.println(sql);
			return getStudent(sql);
		}
	// 从数据库里面选出所有记录
		public ArrayList<Map<String,String>> queryStudentList(){
			sql="select * from student";
			return dbCon.queryForList(sql);
		}
	public ArrayList<Map<String,String>> queryAll(){
		DBConnection dbCon=new DBConnection();
		dbCon.createConnection();
		String sql="select * from student where is_delete=0";
		ArrayList<Map<String,String>> list=dbCon.queryForList(sql);
		return list;
	}
	
	public void close() {
		dbCon.close();		
	}
}
