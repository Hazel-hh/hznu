<!-- 
	作者：何红春
	日期：2017/5/18
	任务：任务管理页汇总图表
	版本：1.3
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="statistics" id="statisticTask">
		<!-- 图表统计 -->
		<%@ page import="com.database.db.DBConnection"%>
		<%@ page import="java.util.*"%>
		<%@ page import="java.sql.*"%>
		<%
			DBConnection dbc = new DBConnection();
			System.out.println("创建对象成功");
			dbc.createConnection();
			String sql = "select * from task join tmtype on task.tm_type_id = tmtype.tm_type_id and task.is_delete=0";
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
					if(taskType.equals("教学大纲")){
						type1++;
						if(rs.getInt("is_finished") == 1){
							typeFinish1++;
						}
					}
					if(taskType.equals("课程教学进度表")){
						type2++;
						if(rs.getInt("is_finished") == 1){
							typeFinish2++;
						}
					}
					if(taskType.equals("实验教学进度表")){
						type3++;
						if(rs.getInt("is_finished") == 1){
							typeFinish3++;
						}
					}
					if(taskType.equals("网络课程统计表")){
						type4++;
						if(rs.getInt("is_finished") == 1){
							typeFinish4++;
						}
					}
					if(taskType.equals("过程性评价申请表")){
						type5++;
						if(rs.getInt("is_finished") == 1){
							typeFinish5++;
						}
					}
					if(taskType.equals("过程性评价总结材料")){
						type6++;
						if(rs.getInt("is_finished") == 1){
							typeFinish6++;
						}
					}
					if(taskType.equals("其他材料")){
						type7++;
						if(rs.getInt("is_finished") == 1){
							typeFinish7++;
						}
					}
			}
			System.out.println("任务总数："+totalCount);
			
			dbc.close();
		%>
		<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
		<div id="chart" style="position:relative;height: 400px; width: 1000px;margin:0 auto;top:32px;"></div>
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
						data : [ '已完成', '未完成' ]
					},
					xAxis : [ {
						type : 'category',
						data : [ "教学大纲", "课程教学进度表", "实验教学进度表", "网络课程统计表",
								"过程性评价申请表", "过程性评价总结材料", "其他" ]
					} ],
					yAxis : [ {
						type : 'value',
						//分隔区域，默认不显示  
						splitArea : {
							show : true
						}
					} ],
					series : [
							{
								"name" : "已完成",
								"type" : "bar",
								"data" : [
		<%=typeFinish1%>
			,
		<%=typeFinish2%>
			,
		<%=typeFinish3%>
			,
		<%=typeFinish4%>
			,
		<%=typeFinish5%>
			,
		<%=typeFinish6%>
			,
		<%=typeFinish7%>
			]
							},
							{
								"name" : "未完成",
								"type" : "bar",
								"data" : [
		<%=type1-typeFinish1%>
			,
		<%=type2-typeFinish2%>
			,
		<%=type3-typeFinish3%>
			,
		<%=type4-typeFinish4%>
			,
		<%=type5-typeFinish5%>
			,
		<%=type6-typeFinish6%>
			,
		<%=type7-typeFinish7%>
			]
							} ]
				};
				// 为echarts对象加载数据 
				myChart.setOption(option);
			});
		</script>
		
		<%
		int finish = typeFinish1+typeFinish2+typeFinish3
				+typeFinish4+typeFinish5+typeFinish6+typeFinish7;
		%>
		<div class="countArea">
		任务总数：<span><%=totalCount %></span>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		已完成：<span><%=finish %></span>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		未完成：<span><%=totalCount-finish %></span>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<!-- 图表统计结束 -->
</div>