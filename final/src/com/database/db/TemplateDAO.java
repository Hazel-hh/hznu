  package com.database.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

public class TemplateDAO {
	DBConnection dbc;
	public TemplateDAO(){
		dbc=new DBConnection();
		dbc.createConnection();
	}
	public int insert(String templateID,String templateName,String tmtypeID, String path){
		// 创建 Calendar 对象
		Calendar cal=Calendar.getInstance();
		//获取当前的日期
		String date=String.format("%4d-%02d-%02d",cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1,cal.get(Calendar.DAY_OF_MONTH));
		//获取当前的时间
		String time=String.format("%2d:%02d:%02d", cal.get(Calendar.HOUR_OF_DAY),cal.get(Calendar.MINUTE),cal.get(Calendar.SECOND));
        
		boolean isdelete=false;
		
		
		
		String sql = "insert into template(template_id,template_name, path, date, time,is_delete,tm_type_id) values('"+templateID+"','"+templateName+"','"+path+"','"+date+"','"+time+"',"+isdelete+",'"+tmtypeID+"')";
		System.out.println(sql);
		int i=dbc.update(sql);
		dbc.close();
		
		return i;
	
	}
	//根据材料模板ID删除数据
	public int deleteByID(String templateID){
		String sql = "update template set is_delete=1 where template_id='" + templateID + "'";
		System.out.println(sql);
	    int i=dbc.update(sql);
	    return i;
	}
	//查询所有数据
	public ArrayList<Map<String,String>> queryAll(){
		DBConnection dbc=new DBConnection();
		dbc.createConnection();
		String sql="select template_id,template_name,path,date,time,tm_type_name from template join tmtype on template.tm_type_id = tmtype.tm_type_id where template.is_delete=0";
		ArrayList<Map<String,String>> list=dbc.queryForList(sql);
		return list;
	}
    //根据模板ID判断是否已经存在
	public int queryByID(String templateID){
		String sql="select * from template where template_id='"+templateID+"' and is_delete=0";
		ResultSet rs=dbc.queryForRS(sql);
		int i=0;
		try {
			rs.last();
			i=rs.getRow();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return i;
	}
	//替换
	public int update(String templateID,String templateName,String path){
		// 创建 Calendar 对象
				Calendar cal=Calendar.getInstance();
				//获取当前的日期
				String date=String.format("%4d-%02d-%02d",cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1,cal.get(Calendar.DAY_OF_MONTH));
				//获取当前的时间
				String time=String.format("%2d:%02d:%02d", cal.get(Calendar.HOUR_OF_DAY),cal.get(Calendar.MINUTE),cal.get(Calendar.SECOND));
		String sql="update template set template_name='"+templateName+"',"+"path='"+path+"',"+"date='"+date+"',"+"time='"+time+"'where template_id='"+templateID
				+"'";
		int i=dbc.update(sql);
		System.out.println(sql);
		return i;
	}
	//关闭相关资源
			public void close(){
				dbc.close();
			}
}
