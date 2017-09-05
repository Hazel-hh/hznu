/*
 *	作者：何红春
 *	日期：2017/5/6
 *	任务：登录按钮点击事件，控制login div的显示以及隐藏以及背景透明度div的显示以及隐藏
 *	版本：1.0
*/
function openLogin() {
	document.getElementById("win").style.display = "";
	document.getElementById("back").style.display = "";
}
function closeLogin() {
	document.getElementById("win").style.display = "none";
	document.getElementById("back").style.display = "none";
}
function check(){
	var checked = [];
	var inputs = document.getElementsByTagName('input');
	for (var i = 0; i < inputs.length; i++) {
		if (inputs[i].type === 'radio' && inputs[i].checked) {
			checked.push(i + 1);
		}
	}
	if(checked == null || checked == ""){
		alert('请选择用户类别！');
		return false;
	}else{
		return true;
	}	
}
