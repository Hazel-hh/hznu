package com.read;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import com.database.db.*;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

public class ReadCourse {
	public static void readExcel(String pathname){
		//���浽���ݿ�
		try{
			//���ļ�
			Workbook book=Workbook.getWorkbook(new File(pathname));
			//��ȡ��һ��sheet
			Sheet sheet=book.getSheet(0);
			//ȡ������
			int rows=sheet.getRows();
			//System.out.println(rows);
		    importCourseInfo(sheet,rows);
			//�ر��ļ�
			book.close();
		}catch(BiffException e){
			e.printStackTrace();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

//����γ���Ϣ
	public static void importCourseInfo(Sheet sheet, int rows) {
		CourseInfoDAO dao=new CourseInfoDAO();
		int k=1;
		//��ȡ����
		for(int i=0;i<rows;i++){
			String courseID=sheet.getCell(0,i).getContents();
			String courseName=sheet.getCell(1, i).getContents();
			String courseClass=sheet.getCell(2, i).getContents();
			String teacherName=sheet.getCell(3, i).getContents();
			String teacherTitle=sheet.getCell(4, i).getContents();
			int stuNum=Integer.parseInt(sheet.getCell(5, i).getContents());
			String exaMode=sheet.getCell(6, i).getContents();
			int mode=0;
			if(exaMode.equals("����")){
				mode=1;
			}
			
			String start_end=sheet.getCell(7, i).getContents();
			String period=sheet.getCell(8, i).getContents();
			int totalPeriod=Integer.parseInt(sheet.getCell(9, i).getContents());
			int weekPeriod=Integer.parseInt(sheet.getCell(10, i).getContents());
			double credit=Double.parseDouble(sheet.getCell(11, i).getContents());
			int theoryHours=Integer.parseInt(sheet.getCell(12, i).getContents());
			int experimentHours=Integer.parseInt(sheet.getCell(13, i).getContents());
			boolean is_delete = false;
			//�嵽���ݿ�
			String[] className=courseClass.split(",");
			String[] weeks=start_end.split("-");
			int startWeek=Integer.parseInt(weeks[0]);
			int endWeek=Integer.parseInt(weeks[1]);
			//���뵽course����
			//dao.insertCourse(courseID, courseName, mode, startWeek, endWeek, credit, theoryHours, experimentHours,stuNum);
			
			String teacherNo=dao.queryByTeacherName1(teacherName);
			int semester=2;
			String classID="";
			//String classIDStr="";
			String courseClassID="";
			for(int j=0;j<className.length;j++){
				//k=k+j;
				
				String num=String.format("%04d",k);  
				courseClassID="CL"+num;
				//dao.insertCourseClass(teacherNo, "2016-2017", semester, classID, courseClassID,courseID,mode);
				
				if(j==className.length-1){
					classID+=dao.queryByClassName(className[j]);
				}else{
					classID+=dao.queryByClassName(className[j])+",";
				}
					//classIDStr+=classID;
				//}else{
					//classIDStr+=classID+",";
				//}
				//System.out.println("�༶"+classIDStr);
			}
			dao.insertCourseClass(teacherNo, "2016-2017", semester, classID, courseClassID,courseID,mode);
			k++;
			
			
			
			
		}
		dao.close();
	}
	
}
