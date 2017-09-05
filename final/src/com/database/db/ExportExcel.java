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
	public static WritableFont font1 =new WritableFont(WritableFont.createFont("΢���ź�"), 10 ,WritableFont.BOLD);
	public static WritableFont font2 =new WritableFont(WritableFont.createFont("΢���ź�"), 9 ,WritableFont.NO_BOLD);
	public static WritableCellFormat wcf = new WritableCellFormat(font1);
	public static WritableCellFormat wcf2 = new WritableCellFormat(font2);
	public static WritableCellFormat wcf3 = new WritableCellFormat(font2);//������ʽ������
	static DecimalFormat df = new DecimalFormat("#.00");
	
	public static void exportExcel(String pathname, String type) throws WriteException {
	  try {
	    //	���ļ�
		WritableWorkbook book = Workbook.createWorkbook(new File(pathname));
	    //	������Ϊ����һҳ���Ĺ���������0��ʾ���ǵ�һҳ
		WritableSheet sheet = book.createSheet( "sheet 1 " , 0);
		// ������ʽ
	    setStyle(sheet, type);
	    // ��д����
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
		// ��ʼд����
		book.write();
		// �رձ�
		book.close();
	   } catch (IOException e) {
		   e.printStackTrace();
	   }
	}
	
	
	public static void setStyle(WritableSheet sheet, String type) throws WriteException{
		SheetSettings ss = sheet.getSettings();
		ss.setVerticalFreeze(1);  // �����ж���ǰ2��
		
		wcf.setAlignment(Alignment.CENTRE);  //ƽ�о���
		wcf.setVerticalAlignment(VerticalAlignment.CENTRE);  //��ֱ����
		wcf3.setAlignment(Alignment.CENTRE);  //ƽ�о���
		wcf3.setVerticalAlignment(VerticalAlignment.CENTRE);  //��ֱ����
		wcf3.setBackground(Colour.LIGHT_ORANGE);
		wcf2.setAlignment(Alignment.CENTRE);  //ƽ�о���
		wcf2.setVerticalAlignment(VerticalAlignment.CENTRE);  //��ֱ����
		
		sheet.mergeCells( 1 , 0 , 13 , 0 ); // �ϲ���Ԫ��  			
	}
	
	static void setTeacherData(WritableSheet sheet) throws WriteException{
		System.out.println("asf");
		Label titleLabel = new Label( 1 , 0 , "��ʦ��", wcf);
		//	������õĵ�Ԫ����ӵ���������
		sheet.addCell(titleLabel);
		sheet.setRowView(1, 500); // ���õ�һ�еĸ߶�500
		int[] headerArrHight = {13,10,13,13,20,13,20,50,50,50,20,20,20,20,50,10};
		String headerArr[] = {"����","����","����","�Ա�","����","ְ��","���ѧ��","���ѧ����ҵԺУ","���ѧλ","���ѧλ��ҵԺУ","�о�����","�绰","�ֻ�","����","��ע","�Ƿ�ɾ��"};
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
			sheet.setRowView(conut, 370); // ���õ�һ�еĸ߶�
			conut++;
		}
		teacherDao.close();
	}
	
	static void setStudentData(WritableSheet sheet) throws RowsExceededException, WriteException{
		Label titleLabel = new Label( 1 , 0 , "ѧ����", wcf);
		//	������õĵ�Ԫ����ӵ���������
		sheet.addCell(titleLabel);
		sheet.setRowView(1, 500); // ���õ�һ�еĸ߶�500
		int[] headerArrHight = {13,10,13,13,13,20,13,20,13,20,20,50,10};
		String headerArr[] = {"ѧ��","����","����","�Ա�","����","ϵ��","רҵ���","�꼶","�༶���","�ֻ�","����", "��ע","�Ƿ�ɾ��"};
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

			sheet.setRowView(conut, 370); // ���õ�һ�еĸ߶�
			conut++;
		}
		studentDao.close();
	}

}