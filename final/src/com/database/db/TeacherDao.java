package com.database.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import com.bean.Teacher;
import com.database.db.DBConnection;

public class TeacherDao {
	String sql="";
	DBConnection dbCon;
	public TeacherDao() {
		dbCon=new DBConnection();//数据库连接对象
		dbCon.createConnection();
	
	}
	
	public Teacher getTeacher(String sql){
		Teacher teacher=null;
		//将结果放到结果集
		ResultSet rs=dbCon.queryForRS(sql);
		if(rs!=null){
			try{
				if(rs.next()){					
					teacher=new Teacher();
					teacher.setTeacher_name(rs.getString("teacher_name"));
					teacher.setTeacher_no(rs.getString("teacher_no"));
					teacher.setPassword(rs.getString("password"));
					teacher.setGender(rs.getString("gender"));
					teacher.setBirthday(rs.getString("birthday"));
					teacher.setEducation(rs.getString("education"));
					teacher.setTitle(rs.getString("title"));
					teacher.setEdu_university(rs.getString("edu_university"));
					teacher.setDegree(rs.getString("degree"));
					teacher.setDeg_university(rs.getString("deg_university"));
					teacher.setResearch_dir(rs.getString("research_dir"));
					teacher.setTel(rs.getString("tel"));
					teacher.setMobile(rs.getString("mobile"));
					teacher.setEmail(rs.getString("email"));
					teacher.setTeacher_note(rs.getString("teacher_note"));
					teacher.setIs_delete(rs.getInt("is_delete"));
					
				}
			}catch(SQLException e){
				e.printStackTrace();
				
			}
		}
		return teacher;
	}

	//添加用户
			public int insertTeacher(String teacher_no, String password, String teacher_name, String gender, String birthday,
					String education, String title, String edu_university, String degree, String deg_university,
					String research_dir, String tel, String mobile, String email, String teacher_note,int is_delete) {
				
				//System.out.println(teacher_no);
				if(findByTeacher_no(teacher_no)==1){
					//JOptionPane.showMessageDialog(null, "教师已存在");
				}
				else {
					// 插入到数据库
					sql = "insert into teacher(teacher_no, teacher_name, password, gender,birthday,education,title,edu_university,degree,deg_university,research_dir,tel,mobile,email,teacher_note,is_delete)"
							+ "values('"+teacher_no+"','"+teacher_name+"','"+password+"','"+gender+"','"+birthday+"','"+education+"','"+title+"','"+edu_university+"','"+degree+"','"+deg_university+"','"+research_dir+"','"+tel+"','"+mobile+"','"+email+"','"+teacher_note+"','"+is_delete+"')";
				}
				//System.out.println(sql);
				return dbCon.update(sql);
			}

	public int addTeacher(String teacher_no, String password, String teacher_name, String gender, String birthday,
			String education, String title, String edu_university, String degree, String deg_university,
			String research_dir, String tel, String mobile, String email, String teacher_note,int is_delete) {
		
		//System.out.println(teacher_no);
		if(findByTeacher_no(teacher_no)==1){
			password="123456";
			sql = "update teacher set teacher_name='" + teacher_name + "',password='" + password + "',gender='" + gender 
		             + "',birthday='" + birthday + "',education='" + education + "',title='" + title 
		             + "',edu_university='" + edu_university + "',degree='"+ degree + "',deg_university='"+ deg_university+ "',research_dir='"+ research_dir+ "',tel='"+ tel+ "',mobile='"+ mobile+ "',email='" + email+ "',teacher_note='" + teacher_note+ "',is_delete='" +is_delete  
		             +"' where teacher_no='" + teacher_no+ "'";
		}
		else {
			password="123456";
			// 插入到数据库
			sql = "insert into teacher(teacher_no, teacher_name, password, gender,birthday,education,title,edu_university,degree,deg_university,research_dir,tel,mobile,email,teacher_note,is_delete)"
					+ "values('"+teacher_no+"','"+teacher_name+"','"+password+"','"+gender+"','"+birthday+"','"+education+"','"+title+"','"+edu_university+"','"+degree+"','"+deg_university+"','"+research_dir+"','"+tel+"','"+mobile+"','"+email+"','"+teacher_note+"','"+is_delete+"')";
		}
		//System.out.println(sql);
		return dbCon.update(sql);
	}
	//根据工号查询教师信息
	public int findByTeacher_no(String teacher_no) {
		sql = "select * from teacher where teacher_no='" + teacher_no + "'";
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

	//根据姓名查询教师信息
	public Teacher findByTeacher_name(String teacher_no) {
		DBConnection dbCon=new DBConnection();
		dbCon.createConnection();
		sql = "select * from teacher where teacher_no='" + teacher_no + "'";
		
		//System.out.println(sql);
		return getTeacher(sql);
	}
	//修改用户数据
	public int updateByTeacher_no(String teacher_no, String teacher_name, String gender, String birthday,
			String education, String title, String edu_university, String degree, String deg_university,
			String research_dir, String tel, String mobile, String email, String teacher_note,int is_delete) {
		
		sql = "update teacher set teacher_name='" + teacher_name + "',gender='" + gender 
			             + "',birthday='" + birthday + "',education='" + education + "',title='" + title 
			             + "',edu_university='" + edu_university + "',degree='"+ degree + "',deg_university='"+ deg_university+ "',research_dir='"+ research_dir+ "',tel='"+ tel+ "',mobile='"+ mobile+ "',email='" + email+ "',teacher_note='" + teacher_note+ "',is_delete='"+ is_delete 
			             +"' where teacher_no='" + teacher_no+ "'";
		return dbCon.update(sql);
		}
	//根据工号删除数据
	public int deleteByTeacher_no(String teacher_no) {
		sql = "delete from teacher where teacher_no='" + teacher_no + "'";
		return dbCon.update(sql);
	}	
	// 从数据库里面选出所有记录
	public ArrayList<Map<String,String>> queryTeacherList(){
		sql="select * from teacher";
		return dbCon.queryForList(sql);
	}
		
	public ArrayList<Map<String,String>> queryAll(){
		DBConnection dbCon=new DBConnection();
		dbCon.createConnection();
		String sql="select * from teacher where is_delete=0";
		ArrayList<Map<String,String>> list=dbCon.queryForList(sql);
		return list;
	}
	public void close() {
		dbCon.close();
		
	}

}
