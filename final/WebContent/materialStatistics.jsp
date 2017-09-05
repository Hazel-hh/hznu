<!-- 
	作者：何红春
	日期：2017/5/20
	任务：教学材料汇总
	版本：1.3
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 图表统计 -->
<div class="statistics" id="statisticMaterials">
	
	<%@ page import="com.database.db.DBConnection"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%
		DBConnection dbc = new DBConnection();
		System.out.println("创建对象成功");
		dbc.createConnection();
		String sql = "select * from materials join tmtype on materials.tm_type_id = tmtype.tm_type_id and materials.is_delete=0";
		ResultSet rs = dbc.queryForRS(sql);
		int totalCount = 0;
		int type1 = 0;
		int typeFinish1 = 0;
		int type2 = 0;
		int typeFinish2 = 0;
		int type3 = 0;
		int typeFinish3 = 0;
		int type4 = 0;
		int typeFinish4 = 0;
		int type5 = 0;
		int typeFinish5 = 0;
		int type6 = 0;
		int typeFinish6 = 0;
		int type7 = 0;
		int typeFinish7 = 0;
		while (rs.next()) {
			totalCount++;
			String taskType = rs.getString("tm_type_name");
			if (taskType.equals("教学大纲")) {
				type1++;
			}
			if (taskType.equals("课程教学进度表")) {
				type2++;
			}
			if (taskType.equals("实验教学进度表")) {
				type3++;
			}
			if (taskType.equals("网络课程统计表")) {
				type4++;
			}
			if (taskType.equals("过程性评价申请表")) {
				type5++;
			}
			if (taskType.equals("过程性评价总结材料")) {
				type6++;
			}
			if (taskType.equals("其他材料")) {
				type7++;
			}
		}
		System.out.println("材料总数：" + totalCount);

		dbc.close();
	%>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	<div id="chart"
		style="height: 400px; width: 1000px; margin: 0 auto; position:relative;top: 35px;"></div>
	
	<!-- ECharts单文件引入 -->
	<script src="echarts/dist/echarts.js"></script>
	
	<script type="text/javascript">
		// 路径配置
		require.config({
			paths : {
				echarts : 'echarts/dist'
			}
		});

		// 使用
		require([ 'echarts', 'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
		], function(ec) {
			// 基于准备好的dom，初始化echarts图表
			var myChart = ec.init(document.getElementById('chart'));

			var option = {
				tooltip : {
					show : true
				},
				legend : {
					data : [ '材料类型' ]
				},
				xAxis : [ {
					type : 'category',
					data : [ "教学大纲", "课程教学进度表", "实验教学进度表", "网络课程统计表",
							"过程性评价申请表", "过程性评价总结材料", "其他" ]
				} ],
				yAxis : [ {
					type : 'value',
				} ],
				series : [ {
					"name" : "材料类型",
					"type" : "bar",
					"data" : [<%=type1%>,<%=type2%>,<%=type3%>,	<%=type4%>,<%=type5%>,<%=type6%>,<%=type7%>]
				} ]
			};
			// 为echarts对象加载数据 
			myChart.setOption(option);
		});
	</script>
	<div class="countArea" >
		材料总数：<span><%=totalCount%></span>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
</div>
<!-- 图表统计结束 -->