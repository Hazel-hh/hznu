/**
 * 
 */
function validate() {
	if (form1.file.value == "") {
		alert("请选择要上传的文件");
		return false;
	}
}
$('#newClassNames1').select2({
	placeholder: "请选择",
	tags:true,
	createTag:function (decorated, params) {
		return null;
	},
	width:'256px'
});
$('#newClassNames2').select2({
	placeholder: "请选择",
	tags:true,
	createTag:function (decorated, params) {
		return null;
	},
	width:'256px'
});
function closeLogin() {
	document.getElementById("addCourseClass").style.display = "none";
	document.getElementById("modifyCourseInfo").style.display = "none";
	document.getElementById("back").style.display = "none";
}

function deleteClassInfo() {
	var boxs = document.getElementsByName("id");
	var ccIDs;

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == true) {
			ccIDs += boxs[i].value + ",";
		}
	}
	if (ccIDs != null ) {
		ccIDs = ccIDs.substring(9, ccIDs.length - 1); // 把最后一个逗号去掉
		if (window.confirm("确定删除？")) {
			$.ajax({
				type : "post",
				url : 'deleteCourseClass?ccIDs=' + ccIDs,
				success : function(data) {
					alert("删除成功");
					window.location.href = "courseClass.jsp";
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
function addCourseInfo() {
	$("#addCourseClass").show();
	$("#back").show();
}
function modifyCourseClass(element) {
	$("#modifyCourseInfo").show();
	$("#back").show();
	var node = element.parentNode.parentNode;
	document.getElementById("courseName").value = node.children[2].innerHTML;
	document.getElementById("courseclassID").value = node.children[3].innerHTML;
	document.getElementById("classNames").value = node.children[4].innerHTML;
	document.getElementById("teacherName").value = node.children[5].innerHTML;
	document.getElementById("tyear").value = node.children[6].innerHTML;
	document.getElementById("semester").value = node.children[7].innerHTML;
	document.getElementById("mode").value = node.children[8].innerHTML;

}