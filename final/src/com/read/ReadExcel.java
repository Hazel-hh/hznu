package com.read;

import java.io.File;
import java.io.IOException;

import com.database.db.StudentDao;
import com.database.db.TeacherDao;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;



public class ReadExcel{
	public static void readExcel(String pathname,String type){
		//保存到数据库
		try{
			//打开文件
			Workbook book=Workbook.getWorkbook(new File(pathname));
			//获取第一个sheet
			Sheet sheet=book.getSheet(0);
			//取得行数
			int rows=sheet.getRows();
			//System.out.println(rows);
			if(type.equals("teacherExcel"))
				importTeacherMsg(sheet,rows);
			else if(type.equals("studentExcel"))
				importStudentMsg(sheet,rows);
			//关闭文件
			book.close();
		}catch(BiffException e){
			e.printStackTrace();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

//导入教师信息
	public static void importTeacherMsg(Sheet sheet, int rows) {
		TeacherDao teacherDao=new TeacherDao();
		for(int i=1;i<rows;i++){
			String teacher_name=sheet.getCell(0,i).getContents();
			String password=sheet.getCell(1, i).getContents();
			String teacher_no=sheet.getCell(2, i).getContents();
			String gender=sheet.getCell(3, i).getContents();
			String birthday=sheet.getCell(4, i).getContents();
			String education=sheet.getCell(6, i).getContents();
			String title=sheet.getCell(5, i).getContents();
			String edu_university=sheet.getCell(7, i).getContents();
			String degree=sheet.getCell(8, i).getContents();
			String deg_university=sheet.getCell(9, i).getContents();
			String research_dir=sheet.getCell(10, i).getContents();
			String tel=sheet.getCell(11, i).getContents();
			String mobile=sheet.getCell(12, i).getContents();
			String email=sheet.getCell(13, i).getContents();
			String teacher_note=sheet.getCell(14, i).getContents();
			String is_deleteStr=sheet.getCell(15, i).getContents();
			int is_delete = Integer.parseInt(is_deleteStr);
			//插到数据库
			//System.out.println(teacher_no+teacher_name);
			teacherDao.addTeacher(teacher_no,password,teacher_name,gender,birthday,education,title,edu_university,degree,deg_university,research_dir,tel,mobile,email,teacher_note,is_delete);
			
		}
		teacherDao.close();
	}
	//导入学生信息
	private static void importStudentMsg(Sheet sheet, int rows) {
		StudentDao studentDao =new StudentDao();
		for(int i=1;i<rows;i++){
			String student_no=sheet.getCell(0,i).getContents();
			String student_name=sheet.getCell(1, i).getContents();
			String password=sheet.getCell(2, i).getContents();
			String gender=sheet.getCell(3, i).getContents();
			String birthday=sheet.getCell(4, i).getContents();
			String dept_id=sheet.getCell(5, i).getContents();
			String major_id=sheet.getCell(6, i).getContents();
			String grade=sheet.getCell(7, i).getContents();
			String class_id=sheet.getCell(8, i).getContents();
			String mobile=sheet.getCell(9, i).getContents();
			String email=sheet.getCell(10, i).getContents();
			String student_note=sheet.getCell(11, i).getContents();
			String is_deleteStr=sheet.getCell(12, i).getContents();
			int is_delete = Integer.parseInt(is_deleteStr);
			//插到数据库
			System.out.println(student_no+student_name);
			studentDao.addStudent(student_no,student_name,password,gender,birthday,dept_id,major_id,grade,class_id,mobile,email,student_note,is_delete);
			
		}
		studentDao.close();
		
	}
}

