package com.database.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import com.bean.TmtypeInfo;

public class TmtypeDAO {
	DBConnection dbc;
	public TmtypeDAO(){
		dbc=new DBConnection();
		dbc.createConnection();
	}
	//�������
	public int insert(String tmtypeID,String tmtypeName,String typeIntro,Boolean ismustsub,String tmtypeNote,Boolean isdelete){
		int i=0;
		String sql="insert into tmtype(tm_type_id,tm_type_name,tm_type_introduction,is_must_sub,remark,is_delete)"
				+" values('"
				+tmtypeID
				+"','"
				+tmtypeName
				+ "','"
				+typeIntro
				+"',"
				+ismustsub
				+",'"
				+tmtypeNote
				+"',"
				+isdelete+")";
		System.out.println(sql);
		i=dbc.update(sql);
		return i;
	}
    //���ݽ�ѧ����IDɾ������
	public int deleteByName(String tmtypeID){
		String sql = "update tmtype set is_delete=1 where tm_type_id='" + tmtypeID + "'";
		System.out.println(sql);
	    int i=dbc.update(sql);
	    return i;
	}
	//��ѯ��������
	public ArrayList<Map<String,String>>queryAll(){
		String sql="select * from tmtype where is_delete=0";
		return dbc.queryForList(sql);
	}
	//���ݽ�ѧ����ID��ѯ��ѧ��������
	public TmtypeInfo queryByID(String tmtypeID){
		TmtypeInfo info=null;
		String sql = "select * from tmtype where tm_type_id='" + tmtypeID + "'and is_delete=0";
		System.out.println(sql);
		ResultSet rs=dbc.queryForRS(sql);
		if(rs!=null){
			try{
				if(rs.next()){
					info=new TmtypeInfo();
					info.setTmtypeID(rs.getString("tm_type_id"));
					info.setTmtypeName(rs.getString("tm_type_name"));
					info.setTypeIntro(rs.getString("tm_type_introduction"));
					info.setIsmustsub(rs.getBoolean("is_must_sub"));
					info.setTmtypeNote(rs.getString("remark"));
					info.setIsdelete(rs.getBoolean("is_delete"));
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return info;
	}
	//���ݽ�ѧ�������ֲ�ѯ��ѧ��������
		public TmtypeInfo queryByName(String tmtypeName){
			TmtypeInfo info=null;
			String sql = "select * from tmtype where tm_type_name='" + tmtypeName + "'and is_delete=0";
			System.out.println(sql);
			ResultSet rs=dbc.queryForRS(sql);
			if(rs!=null){
				try{
					if(rs.next()){
						info=new TmtypeInfo();
						info.setTmtypeID(rs.getString("tm_type_id"));
						info.setTmtypeName(rs.getString("tm_type_name"));
						info.setTypeIntro(rs.getString("tm_type_introduction"));
						info.setIsmustsub(rs.getBoolean("is_must_sub"));
						info.setTmtypeNote(rs.getString("remark"));
						info.setIsdelete(rs.getBoolean("is_delete"));
					}
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
			return info;
		}
	//�޸�����
	public int updateTmtype(String tmtypeID,String tmtypeName,String typeIntro,Boolean ismustsub,String tmtypeNote,Boolean isdelete){
		String sql = "update tmtype set tm_type_id='"+ tmtypeID+"',"+"tm_type_name='"+tmtypeName
				+"',tm_type_introduction='"+typeIntro+"',"+"is_must_sub="+ismustsub+","
				+"remark='"+tmtypeNote+"',"+"is_delete="+isdelete+" where tm_type_id='"+tmtypeID
				+"'";
		int i=dbc.update(sql);
		System.out.println(sql);
		return i;
	}
	//�ر������Դ
		public void close(){
			dbc.close();
		}
}
