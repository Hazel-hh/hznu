<!-- 
	���ߣ�л�
	���ڣ�2017/5/20
	����ʵ��ͨ���������ݿ�༶��ѯ����ķ�ҳ����
	�汾��1.0
 -->

<%@ page contentType="text/html" pageEncoding="GB2312" language="java"%>
<%@ page import="java.sql.*"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>�༶��ѯ</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css"
		href="css/jquery.dataTables.min.css">
	
	<link rel="stylesheet" href="css/theme.css">
	<script src="js/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript"	src="js/jquery.dataTables.min.js"></script>
	<!-- table -->
	<link rel="stylesheet" type="text/css" href="css/tableArea.css">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<link rel="stylesheet" type="text/css" href="css/nav.css">
	<!-- footer -->
	<link rel="stylesheet" type="text/css" href="css/footer.css">
	<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
	<!-- ����js -->
	<script src="js/nav.js"></script>
	<script src="js/navChange.js"></script>
	<link rel="stylesheet" type="text/css" href="css/left.css">
	<style type="text/css">
		.main{
			height:760px;
		}
		.left{
			height:700px;
		}
		.left .line{
			height:710px;
		}
	</style>

</head>
<%@ page import="com.database.db.DBConnection"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<body class=" theme-blue">
	<!-- ����û��Ƿ��¼ -->
	<jsp:include page="checkAdmin.jsp"></jsp:include>
	<!-- ����û��Ƿ��¼���� -->
	
	<!--header��ʼ-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header����-->
	
	<!-- main -->
	<div class="main">
		<div class="left">
		<jsp:include page="left.jsp"></jsp:include>
		</div>  
		
		<div class="tableArea">
		<div class="cTitle">
				<label>�༶��Ϣ</label>
		</div>
			<div class="btn-toolbar list-toolbar">
				<button class="btn btn-primary">
					<a href="class_add.jsp"><i class="fa fa-plus"></i></a>New Class 
				</button>		
				<div class="btn-group"></div>
			</div>
	
			<table class="table" id="classesquery">
				<%!
			public static final int PAGESIZE = 10;
			int pageCount;
			int curPage = 1;%>
			<!-- �������ݿ� -->
				<%
					DBConnection dbc4 = new DBConnection();
					dbc4.createConnection();
					String sql = "select class.id,class_id,class_name,class_note,major_name FROM class,major where class.is_delete = 0 and class.major_id = major.major_id ";
					ResultSet rs = dbc4.queryForRS(sql);
					String taskId = null;
					//int id = 0;
				%>
			<!-- �������ݿ���� -->
			<!-- �༶��Ϣ��ѯ -->
				<thead>
					<tr>
						<th>id</th>
						<th>�༶id</th>
						<th>�༶����</th>
						<th>����רҵ</th>
						<th style="width: 3.5em;"></th>
						<th style="width: 3.5em;"></th>
					</tr>
				</thead>
		
				<tbody>
					<script type="text/javascript">
				/*��ȡ����е�����*/
				var array = new Array();
				var k=0;
				<%
				if(rs != null)
					while (rs.next()) {
						int id = rs.getInt("id");
						String class_id = rs.getString("class_id");
						String class_name = rs.getString("class_name");
						String class_note = rs.getString("class_note");
						String major_name = rs.getString("major_name");
						//id++;%>
			var t = new Array();	
			t.push("<%=id%>");
			t.push("<%=class_id%>");
			t.push("<%=class_name%>");
			t.push("<%=major_name%>");
		<%String linkStr = "class_update.jsp?id=" + id;
		String downloadStr = "<a href='" + linkStr + "'>�޸�</a>";
		System.out.println(downloadStr);
						%>
			
			t.push("<%=downloadStr%>");	
			
			<%String linkStr2 = "DeleteClassServlet?id=" + id;
						String deleteStr = "<a href='" + linkStr2 + "'>ɾ��</a>";
						System.out.println(deleteStr);%>
			
			t.push("<%=deleteStr%>");
		
						console.log(t);
						array[k] = t;
						k++;
					<%}
					dbc4.close();%>
						$(document)
								.ready(
										function() {
											$('#classesquery')
													.DataTable(
															{
																data : array,
																"bLengthChange" : false, //�ı�ÿҳ��ʾ��������
																"oLanguage" : {
																	"sLengthMenu" : "ÿҳ��ʾ _MENU_ ����¼",
																	"sZeroRecords" : "��Ǹ�� û���ҵ�",
																	"sInfo" : "�� _START_ �� _END_ /�� _TOTAL_ ������",
																	"sInfoEmpty" : "û������",
																	"sInfoFiltered" : "(�� _MAX_ �������м���)",
																	"sSearch" : "����",
																	"oPaginate" : {
																		"sFirst" : "��ҳ",
																		"sPrevious" : "ǰһҳ",
																		"sNext" : "��һҳ",
																		"sLast" : "βҳ"
																	},
																	"sZeroRecords" : "��δ�а༶ѡ��",
																	//"sProcessing": "<img src='./loading.gif' />",
																	"bStateSave" : true
																//����״̬��cookie *************** ����Ҫ �� ��������ʱ��ҳ��һˢ�»ᵼ����������ʧ��ʹ��������ԾͿɱ����� 
																}
															});
		
											$('button')
													.click(
															function() {
																var data = table
																		.$(
																				'input, select')
																		.serialize();
																alert("The following data would have been submitted to the server: \n\n"
																		+ data.substr(
																				0, 120)
																		+ '...');
																return false;
															});
										});
					</script>
				</tbody>
			</table>
		</div><!-- tableArea���� -->
	</div>
	<hr>
		<!--footer��ʼ-->
		<jsp:include page="footer.html"></jsp:include>
		<!--footer ����-->


</body>
</html>
