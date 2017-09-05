/*
 *	作者：何红春
 *	日期：2017/5/20
 *	任务：表格处理
 *	版本：1.3
*/



/**
 * 多选
 */

$(function() {
	$("#tableList tr").click(function() {
		var input = $(this).find("input[type=checkbox]");// 获取checkbox
		// 判断当前checkbox是否为选中状态
		if (input.is(":checked")) {
			input.prop("checked", false);
		} else {
			input.prop("checked", true);
		}
	})
	
//	$("#tableList tr:even").css("background-color", "#d4e3e5");
})

// checkbox 全选/取消全选
var isCheckAll = false;
function swapCheck() {
	if (isCheckAll) {
		$("input[type='checkbox']").each(function() {
			this.checked = false;
		});
		isCheckAll = false;
	} else {
		$("input[type='checkbox']").each(function() {
			this.checked = true;
		});
		isCheckAll = true;
	}
}
/*
 * 批量删除任务
 * 
 */
function deleteTasks() {
	var boxs = document.getElementsByName("id");
	var taskIds="";

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			taskIds += boxs[i].value + ",";
		}
	}
	if (taskIds != "" && taskIds != null) {
		taskIds = taskIds.substring(0, taskIds.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定删除？")) {
			$.ajax({
				type : "post",
				url : 'deleteTask?taskIds=' + taskIds,
				success : function(data) {
					alert("删除成功");
					window.location.href = "taskTable.jsp";
				},
				error : function(data) {
					alert("删除失败");
				}
			});
		}
	} else {
		alert("请选择行");
	}
}
/*
 * 批量删除材料
 */
function deleteMaterials() {
	var boxs = document.getElementsByName("id");
	var materialIds="";

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			materialIds += boxs[i].value + ",";
		}
	}
	if (materialIds != "" && materialIds!= null) {
		materialIds = materialIds.substring(0, materialIds.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定删除？")) {
			$.ajax({
				type : "post",
				url : 'deleteMaterials?materialIds=' + materialIds,
				success : function(data) {
					alert("删除成功");
					window.location.href = "materialsTable.jsp";
				},
				error : function(data) {
					alert("删除失败");
				}
			});
		}
	} else {
		alert("请选择行");
	}
}
/*
 * 批量删除学生
 * 
 */
function deleteStudent() {
	
	var boxs = document.getElementsByName("id");
	var taskIds;

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			taskIds += boxs[i].value + ",";
		}
	}
	if (taskIds != "") {
		taskIds = taskIds.substring(9, taskIds.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定删除？")) {
			$.ajax({
				type : "post",
				url : 'deleteStudent?taskIds=' + taskIds,
				success : function(data) {
					alert("删除成功");
					window.location.href = "student.jsp";
				},
				error : function(data) {
					alert("删除失败");
				}
			});
		}
	} else {
		alert("请选择行");
	}
}
/*
 * 批量删除教师
 * 
 */
function deleteTasksT() {
	
	var boxs = document.getElementsByName("id");
	var taskIds;

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			taskIds += boxs[i].value + ",";
		}
	}
	if (taskIds != "") {
		taskIds = taskIds.substring(9, taskIds.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定删除？")) {
			$.ajax({
				type : "post",
				url : 'deleteTeacher?taskIds=' + taskIds,
				success : function(data) {
					alert("删除成功");
					window.location.href = "teacher.jsp";
				},
				error : function(data) {
					alert("删除失败");
				}
			});
		}
	} else {
		alert("请选择行");
	}
}
/*
 * 批量下载材料
 */
function batchDownload(){
	var boxs = document.getElementsByName("id");
	var materialIds="";

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			materialIds += boxs[i].value + ",";
		}
	}
	if (materialIds != "" && materialIds!= null) {
		materialIds = materialIds.substring(0, materialIds.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定下载？")) {
			window.location.href = "BatchDownload?materialIds=" + materialIds;
		}
	} else {
		alert("请选择行");
	}
}
/*
 * 批量删除模板类型
 * 
 */
function deleteTmtypes() {
	var boxs = document.getElementsByName("id");
	var tmtypeIDs;

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			tmtypeIDs += boxs[i].value + ",";
		}
	}
	if (tmtypeIDs != "") {
		tmtypeIDs = tmtypeIDs.substring(9, tmtypeIDs.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定删除？")) {
			$.ajax({
				type : "post",
				url : 'deleteTmtype?tmtypeIDs=' + tmtypeIDs,
				success : function(data) {
					alert("删除成功");
					window.location.href = "tmtype.jsp";
				},
				error : function(data) {
					alert("删除失败");
				}
			});
		}
	} else {
		alert("请选择行");
	}
}
/*
 * 批量删除模板
 * 
 */
function deleteTemplates() {
	var boxs = document.getElementsByName("id");
	var templateIDs;

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			templateIDs += boxs[i].value + ",";
		}
	}
	if (templateIDs != "") {
		templateIDs = templateIDs.substring(9, templateIDs.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定删除？")) {
			$.ajax({
				type : "post",
				url : 'deleteTemplate?templateIDs=' + templateIDs,
				success : function(data) {
					alert("删除成功");
					window.location.href = "template.jsp";
				},
				error : function(data) {
					alert("删除失败");
				}
			});
		}
	} else {
		alert("请选择行");
	}
}
/*
 * 材料类型模板管理
 */
$("input[name=uploadBtn]").click(function() {
	$("#upload").show();
	$("input[name=uploadBtn]").hide();

});
function validate() {
	if (form1.file.value == "") {
		alert("请选择要上传的文件");
		return false;
	}
}
/*
 * 教学材料模板替换
 */
function replace(element){
	$("#replaceinfo").show();
	var node = element.parentNode.parentNode;
	document.getElementById("templateID").value=node.children[2].innerHTML;
	document.getElementById("templateName").value=node.children[3].innerHTML;
	document.getElementById("tmtypeName").value=node.children[4].innerHTML;
	document.getElementById("path").value=node.children[6].innerHTML;
	
}
/*
 * 批量删除用户信息
 */
function deleteuserIds() {
	var boxs = document.getElementsByName("checkboxid");
	var userIds="";

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			userIds += boxs[i].value + ",";
		}
	}
	if (userIds != "" && userIds!= null) {
		userIds = userIds.substring(0, userIds.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定删除？")) {
			$.ajax({
				type : "post",
				url : 'DeleteUsersServlet?userIds=' + userIds,
				success : function(data) {
					alert("删除成功");
					window.location.href = "users_query.jsp";
				},
				error : function(data) {
					alert("删除失败");
				}
			});
		}
	} else {
		alert("请选择行");
	}
}


/*
 * 批量重置用户密码
 */
function resetuserpassword() {
	var boxs = document.getElementsByName("checkboxid");
	var userIds="";

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			userIds += boxs[i].value + ",";
		}
	}
	if (userIds != "" && userIds!= null) {
		userIds = userIds.substring(0, userIds.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定重置密码？")) {
			$.ajax({
				type : "post",
				url : 'UpdateUserPassServlet?userIds=' + userIds,
				success : function(data) {
					alert("重置成功密码");
					window.location.href = "users_query.jsp";
				},
				error : function(data) {
					alert("重置失败密码");
				}
			});
		}
	} else {
		alert("请选择行");
	}
}
