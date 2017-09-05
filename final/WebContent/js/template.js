/*
 *	作者：张梦婕
 *	日期：2017/5/20
 *	任务：材料模板处理
 *	版本：1.3
*/

/*
 * 材料类型模板管理
 */
$("button[name=uploadBtn]").click(function() {
	//$("#upload").show();
	$("input[name=uploadBtn]").hide();
	document.getElementById("upload").style.display = "";
	document.getElementById("back").style.display = "";

});
function validate() {
	var file = document.getElementById("file").value;
	if(file.length==0)
	{
		alert("请选择上传文件");
		return false;
	}
	return true;
}
/*
 * 教学材料模板替换
 */
function replace(element){
	//$("#replaceinfo").show();
	document.getElementById("replaceinfo").style.display = "";
	document.getElementById("back").style.display = "";
	var node = element.parentNode.parentNode;
	document.getElementById("templateID").value=node.children[1].innerHTML;
	document.getElementById("templateName").value=node.children[2].innerHTML;
	document.getElementById("tmtypeName").value=node.children[3].innerHTML;
	//document.getElementById("path").value=node.children[6].innerHTML;
	
}
function closeLogin() {
	document.getElementById("upload").style.display = "none";
	document.getElementById("replaceinfo").style.display = "none";
	document.getElementById("back").style.display = "none";
}

