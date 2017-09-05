package com.database.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import com.bean.*;

public class CourseInfoDAO {
	DBConnection dbc;

	public CourseInfoDAO() {
		dbc = new DBConnection();
		dbc.createConnection();
	}
    //向course表添加数据
	public int insertCourse(String courseID,String courseName,int mode,int startWeek,int endWeek,double credit,int theoryHours,int experimentHours,int stuNum){
		int i=0;
		String sql=null;
		if(queryBycourseID(courseID)==1){
			sql = "update course set course_name='" + courseName + "',evaluation_mode=" + mode+ ",start_week=" + startWeek
		             + ",end_week=" + endWeek + ",credit=" + credit + ",theory_Hours=" +theoryHours
		             + ",experiment_hours=" + experimentHours+ ",stu_num="+stuNum+" where course_id='" + courseID+ "'";
			
			
		}else{
			sql = "insert into course(course_id,course_name,evaluation_mode,start_week,end_week,credit,theory_hours,experiment_hours,stu_num)"
					+ "values('" + courseID +"','"+ courseName + "'," + mode + "," + startWeek + "," + endWeek + ","
					+ credit + "," + theoryHours + "," + experimentHours +","+stuNum+ ")";
		}
		System.out.println(sql);
		i = dbc.update(sql);
		 ;
		return i;
	}
	// 向courseclass表从excel导入数据
	public int insertCourseClass(String teacherNo,String academicYear,int semester, String classIDs,String courseClassID,String courseID,int evaluation_mode) {
		int i = 0;
		String sql=null;
		if(queryByccID(courseClassID)==1){
			sql="update courseclass set teacher_no='"+teacherNo+"',academic_year='"+academicYear+"',semester="+semester+
					",class_id='"+classIDs+"',course_id='"+courseID+"',evaluation_mode="+evaluation_mode+" where course_class_id='"+courseClassID+"'";
			
		}else{
			sql = "insert into courseclass(teacher_no,academic_year,semester,class_id,course_class_id,course_id,is_delete,evaluation_mode)"
					+ "values('" + teacherNo+ "','" +academicYear+"','"+ semester + "','" +classIDs+"','"+courseClassID +"','"+courseID+"',"+0+","+evaluation_mode+")";
		}
		System.out.println(sql);
		i = dbc.update(sql);
		 ;
		return i;

	}
	    // 向courseclass表通过添加增加数据
		public int addCourseClass(String teacherNo,String academicYear,int semester, String classID,String courseClassID,String courseID,int evaluation_mode) {
			int i = 0;
			String sql=null;
			if(queryByccID(courseClassID)==1){
				System.out.println("数据已经存在");
				
			}else{
				sql = "insert into courseclass(teacher_no,academic_year,semester,class_id,course_class_id,course_id,is_delete,evaluation_mode)"
						+ "values('" + teacherNo+ "','" +academicYear+"','"+ semester + "','" +classID+"','"+courseClassID +"','"+courseID+"',"+0+","+evaluation_mode+")";
			}
			
			System.out.println(sql);
			i = dbc.update(sql);
			 ;
			return i;

		}
		//根据courseID和教学班ID判断信息是否已经存在
				public int queryByccIDs(String courseID,String classIDs){
					int i=0;
					String sql="select * from courseclass where course_id='"+courseID+"'"+" and class_id='"+classIDs+ "' and is_delete=0";
					System.out.println(sql);
					ResultSet rs= dbc.queryForRS(sql);
					try {
						rs.last();
						if(rs.getRow()!=0){
						  i=1;
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
					 ;
					return i;
				}

	//根据courseID判断信息是否已经存在
	public int queryBycourseID(String courseID){
		int i=0;
		String sql="select * from course where course_id='"+courseID+"'";
		System.out.println(sql);
		ResultSet rs= dbc.queryForRS(sql);
		try {
			rs.last();
			if(rs.getRow()!=0){
			  i=1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 ;
		return i;
	}
	//根据courseClassID和classID判断信息是否已经存在
	public int queryByccID(String courseclassID){
		int i=0;
		String sql="select * from courseclass where course_class_id='"+courseclassID+"' and is_delete=0";
		System.out.println(sql);
		ResultSet rs= dbc.queryForRS(sql);
		try {
			rs.last();
			if(rs.getRow()!=0){
			  i=1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 ;
		return i;
	}
	//查询课程班ID和courseID(修改)
	public String queryBycourseclassID(String courseID){
		String courseclassID="";
		String sql="select * from courseclass where course_id='"+courseID+"' "+courseID;
		//System.out.println(sql);
		ResultSet rs= dbc.queryForRS(sql);
		try {
			while(rs.next()){
				courseclassID=rs.getString("course_class_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 ;
		return courseclassID;
	}
	//根据teacherName和课程代码查询teacherNo
	public String queryByTeacherName(String teacherName,String courseID){
		String teacherNo="";
		String sql="select teacher_no from teacher natural join course where teacher_name='"+teacherName+"' and course_id='"+courseID+"'";
		ResultSet rs=dbc.queryForRS(sql);
		try {
			while(rs.next()){
				teacherNo=rs.getString("teacher_no");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 ;
		return teacherNo;
		
	}
	//根据teacherName和课程代码查询teacherNo
		public String queryByTeacherName1(String teacherName){
			String teacherNo="";
			String sql="select teacher_no from teacher where teacher_name='"+teacherName+"'";
			ResultSet rs=dbc.queryForRS(sql);
			try {
				while(rs.next()){
					teacherNo=rs.getString("teacher_no");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 ;
			return teacherNo;
			
		}

	//根据className查询classID
	public String queryByClassName(String className){
		String classID="";
		String sql="select class_id from class where class_name='"+className+"'";
		ResultSet rs=dbc.queryForRS(sql);
		try {
			while(rs.next()){
				classID=rs.getString("class_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 ;
		return classID;
		
	}
	//根据classID查询className
		public String queryByClassID(String classID){
			String className="";
			String sql="select class_name from class where class_id='"+classID+"'";
			ResultSet rs=dbc.queryForRS(sql);
			try {
				while(rs.next()){
					className=rs.getString("class_name");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 ;
			return className;
			
		}
	//根据courseName查询courseID
		public String queryByCourseName(String courseName){
			String courseID="";
			String sql="select course_id from course where course_name='"+courseName+"'";
			ResultSet rs=dbc.queryForRS(sql);
			try {
				while(rs.next()){
					courseID=rs.getString("course_id");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 ;
			return courseID;
			
		}
	// 查询所有数据
	public ArrayList<Map<String, String>> queryAll() {
		
		
		//String sql = "select * from course join courseclass on course.course_id=courseclass.course_id  join teacher on courseclass.teacher_no=teacher.teacher_no;";
		//String sql="select * from course join courseclass on course.course_id=courseclass.course_id  join teacher on courseclass.teacher_no=teacher.teacher_no join class on courseclass.class_id=class.class_id where courseclass.is_delete=0;";
		//String sql="select * from course";
		String sql = "select * from courseclass join teacher on teacher.teacher_no = courseclass.teacher_no join course on course.course_id = courseclass.course_id where courseclass.is_delete=0";
		return dbc.queryForList(sql);
	}
	//查询课程
	public ArrayList<Map<String, String>> queryCourse(){
		String sql="select course_id,course_name from course";
		return dbc.queryForList(sql);
	}
	//查询班级
	public ArrayList<Map<String, String>> queryClass(){
		String sql="select class_id,class_name from class";
		return dbc.queryForList(sql);
	}
	//查询教师
	public ArrayList<Map<String, String>> queryTeacher(){
		String sql="select teacher_no,teacher_name from teacher";
		return dbc.queryForList(sql);
	}
	//查询学期学年
	public ArrayList<Map<String, String>> queryYearTeam(){
		String sql="select distinct(teaching_year) from tyear_sem";
		return dbc.queryForList(sql);
	}
    //根据ccID删除courseclass
	public int deleteByccID(String ccID){
		String sql = "update courseclass set is_delete=1 where course_class_id='" + ccID + "'";
		System.out.println(sql);
	    int i=dbc.update(sql);
	     ;
	    return i;
	}
	//根据courseclassID查询
	public CourseInfo queryByCourseclassID(String courseclassID){
		CourseInfo info=null;
		String sql="select * from course join courseclass on course.course_id=courseclass.course_id  join teacher on courseclass.teacher_no=teacher.teacher_no where courseclass.is_delete=0 and courseclass.course_class_id='"+courseclassID+"'";
		ResultSet rs=dbc.queryForRS(sql);
		if(rs!=null){
			try{
				if(rs.next()){
					info=new CourseInfo();
					info.setCourseID(rs.getString("course_id"));
					info.setCourseName(rs.getString("course_name"));
					info.setClassID(rs.getString("class_id"));
					info.setTeacherName(rs.getString("teacher_name"));
					info.setTitle(rs.getString("title"));
					info.setStuNum(Integer.parseInt(rs.getString("stu_num")));
					info.setMode(Integer.parseInt(rs.getString("evaluation_mode")));
					info.setStartWeek(Integer.parseInt(rs.getString("start_week")));
					info.setEndWeek(Integer.parseInt(rs.getString("end_week")));
					info.setTheoryHours(Integer.parseInt(rs.getString("theory_hours")));
					info.setExperimentHours(Integer.parseInt(rs.getString("experiment_hours")));
					info.setCredit(Integer.parseInt(rs.getString("credit")));
					
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		 ;
		return info;
		
		
	}
	//修改
	public int modifyInfo(String courseclassID,String courseID,String teacherNo,int semester,String tyear,int evaluation_mode,String classIDs ){
		int i=0;
		//String sql="update courseclass set course_class_id='"+courseclassID+"'course_id='" where class_id='"+classID+"' and course_id='"+courseID+"'";
		String sql="update courseclass set teacher_no='"+teacherNo+"',academic_year='"+tyear+"',semester="+semester+
				",class_id='"+classIDs+"',course_id='"+courseID+"',evaluation_mode="+evaluation_mode+" where course_class_id='"+courseclassID+"'";
		i=dbc.update(sql);
		 ;
		return i;
		
	}
	// 关闭相关资源
	public void close() {
		 dbc.close();
	}
}
