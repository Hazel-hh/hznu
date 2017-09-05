package com.database.db;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Map;


import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

public class ExportExcel {
	public static WritableFont font1 =new WritableFont(WritableFont.createFont("微软雅黑"), 10 ,WritableFont.BOLD);
	public static WritableFont font2 =new WritableFont(WritableFont.createFont("微软雅黑"), 9 ,WritableFont.NO_BOLD);
	public static WritableCellFormat wcf = new WritableCellFormat(font1);
	public static WritableCellFormat wcf2 = new WritableCellFormat(font2);
	public static WritableCellFormat wcf3 = new WritableCellFormat(font2);//设置样式，字体
	static DecimalFormat df = new DecimalFormat("#.00");
	
	public static void exportExcel(String pathname, String type) throws WriteException {
	  try {
	    //	打开文件
		WritableWorkbook book = Workbook.createWorkbook(new File(pathname));
	    //	生成名为“第一页”的工作表，参数0表示这是第一页
		WritableSheet sheet = book.createSheet( "sheet 1 " , 0);
		// 设置样式
	    setStyle(sheet, type);
	    // 填写数据
	    switch(type){
			case "teacher":
				setTeacherData(sheet);
				break;	
			case "student":
				setStudentData(sheet);
				break;
			default:
				break;
		}
		// 开始写数据
		book.write();
		// 关闭表
		book.close();
	   } catch (IOException e) {
		   e.printStackTrace();
	   }
	}
	
	
	public static void setStyle(WritableSheet sheet, String type) throws WriteException{
		SheetSettings ss = sheet.getSettings();
		ss.setVerticalFreeze(1);  // 设置行冻结前2行
		
		wcf.setAlignment(Alignment.CENTRE);  //平行居中
		wcf.setVerticalAlignment(VerticalAlignment.CENTRE);  //垂直居中
		wcf3.setAlignment(Alignment.CENTRE);  //平行居中
		wcf3.setVerticalAlignment(VerticalAlignment.CENTRE);  //垂直居中
		wcf3.setBackground(Colour.LIGHT_ORANGE);
		wcf2.setAlignment(Alignment.CENTRE);  //平行居中
		wcf2.setVerticalAlignment(VerticalAlignment.CENTRE);  //垂直居中
		
		sheet.mergeCells( 1 , 0 , 13 , 0 ); // 合并单元格  			
	}
	
	static void setTeacherData(WritableSheet sheet) throws WriteException{
		System.out.println("asf");
		Label titleLabel = new Label( 1 , 0 , "教师表", wcf);
		//	将定义好的单元格添加到工作表中
		sheet.addCell(titleLabel);
		sheet.setRowView(1, 500); // 设置第一行的高度500
		int[] headerArrHight = {13,10,13,13,20,13,20,50,50,50,20,20,20,20,50,10};
		String headerArr[] = {"姓名","密码","工号","性别","生日","职称","最后学历","最后学历毕业院校","最后学位","最后学位毕业院校","研究方向","电话","手机","邮箱","备注","是否被删除"};
		for (int i = 0; i < headerArr.length; i++) {
			sheet.addCell(new Label( i , 1 , headerArr[i],wcf));
			sheet.setColumnView(i, headerArrHight[i]);
		}
		
		int conut = 2;
		TeacherDao teacherDao = new TeacherDao();
		ArrayList<Map<String, String>> teacherMsgs =teacherDao.queryTeacherList();
		for (Map<String, String> teacherMsg : teacherMsgs) {
			sheet.addCell(new Label( 0 , conut , teacherMsg.get("teacher_no"), wcf2));
			sheet.addCell(new Label( 1 , conut , teacherMsg.get("teacher_name") ,wcf2));
			sheet.addCell(new Label( 2 , conut , teacherMsg.get("password") ,wcf2));
			sheet.addCell(new Label( 3 , conut , teacherMsg.get("gender"), wcf2));
			sheet.addCell(new Label( 4 , conut , teacherMsg.get("birthday") ,wcf2));
			sheet.addCell(new Label( 5 , conut , teacherMsg.get("title") ,wcf2));
			sheet.addCell(new Label( 6 , conut , teacherMsg.get("education"), wcf2));
			sheet.addCell(new Label( 7 , conut , teacherMsg.get("edu_university") ,wcf2));
			sheet.addCell(new Label( 8 , conut , teacherMsg.get("degree") ,wcf2));
			sheet.addCell(new Label( 9 , conut , teacherMsg.get("deg_university") ,wcf2));
			sheet.addCell(new Label( 10 , conut , teacherMsg.get("research_dir") ,wcf2));
			sheet.addCell(new Label( 11 , conut , teacherMsg.get("tel") ,wcf2));
			sheet.addCell(new Label( 12 , conut , teacherMsg.get("mobile") ,wcf2));
			sheet.addCell(new Label( 13 , conut , teacherMsg.get("email") ,wcf2));
			sheet.addCell(new Label( 14 , conut , teacherMsg.get("teacher_note") ,wcf2));
			sheet.addCell(new Label( 15 , conut , teacherMsg.get("is_delete") ,wcf2));
			sheet.setRowView(conut, 370); // 设置第一行的高度
			conut++;
		}
		teacherDao.close();
	}
	
	static void setStudentData(WritableSheet sheet) throws RowsExceededException, WriteException{
		Label titleLabel = new Label( 1 , 0 , "学生表", wcf);
		//	将定义好的单元格添加到工作表中
		sheet.addCell(titleLabel);
		sheet.setRowView(1, 500); // 设置第一行的高度500
		int[] headerArrHight = {13,10,13,13,13,20,13,20,13,20,20,50,10};
		String headerArr[] = {"学号","姓名","密码","性别","生日","系别","专业编号","年级","班级编号","手机","邮箱", "备注","是否被删除"};
		for (int i = 0; i < headerArr.length; i++) {
			sheet.addCell(new Label( i , 1 , headerArr[i],wcf));
			sheet.setColumnView(i, headerArrHight[i]);
		}
		
		int conut = 2;
		StudentDao studentDao = new StudentDao();
		ArrayList<Map<String, String>> studentMsgs =studentDao.queryStudentList();
		for (Map<String, String> studentMsg : studentMsgs) {
			sheet.addCell(new Label( 0 , conut , studentMsg.get("student_no"), wcf2));
			sheet.addCell(new Label( 1 , conut , studentMsg.get("student_name") ,wcf2));
			sheet.addCell(new Label( 2 , conut , studentMsg.get("password") ,wcf2));
			sheet.addCell(new Label( 3 , conut , studentMsg.get("gender"), wcf2));
			sheet.addCell(new Label( 4 , conut , studentMsg.get("birthday") ,wcf2));
			sheet.addCell(new Label( 5 , conut , studentMsg.get("dept_id") ,wcf2));
			sheet.addCell(new Label( 6 , conut , studentMsg.get("major_id"), wcf2));
			sheet.addCell(new Label( 7 , conut , studentMsg.get("grade") ,wcf2));
			sheet.addCell(new Label( 8 , conut , studentMsg.get("class_id") ,wcf2));
			sheet.addCell(new Label( 9 , conut , studentMsg.get("mobile") ,wcf2));
			sheet.addCell(new Label( 10 , conut , studentMsg.get("email") ,wcf2));
			sheet.addCell(new Label( 11 , conut , studentMsg.get("student_note") ,wcf2));
			sheet.addCell(new Label( 12 , conut , studentMsg.get("is_delete") ,wcf2));

			sheet.setRowView(conut, 370); // 设置第一行的高度
			conut++;
		}
		studentDao.close();
	}

}