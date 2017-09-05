/**
 * 材料类型管理
 */
function addTmtype() {
	//$("#addTmtype").show();
	document.getElementById("addTmtype").style.display = "";
	document.getElementById("back").style.display = "";
}
function checkTmtypeInfo(element) {
	//$("#checkTmtype").show();
	document.getElementById("checkTmtype").style.display = "";
	document.getElementById("back").style.display = "";
	var node = element.parentNode.parentNode;
	document.getElementById("c_tmtypeID").value = node.children[1].innerHTML;
	document.getElementById("c_tmtypeName").value = node.children[2].innerHTML;
	document.getElementById("c_typeIntro").value = node.children[3].innerHTML;
	document.getElementById("c_ismustsub").value = node.children[4].innerHTML;
	document.getElementById("c_typeNote").value = node.children[5].innerHTML;
}
function modifyTmtypeInfo(element) {
	//$("#modifyTmtype").show();
	document.getElementById("modifyTmtype").style.display = "";
	document.getElementById("back").style.display = "";
	var node = element.parentNode.parentNode;
	document.getElementById("m_tmtypeID").value = node.children[1].innerHTML;
	document.getElementById("m_tmtypeName").value = node.children[2].innerHTML;
	document.getElementById("m_typeIntro").value = node.children[3].innerHTML;
	document.getElementById("m_ismustsub").value = node.children[4].innerHTML;
	document.getElementById("m_typeNote").value = node.children[5].innerHTML;
}
function closeLogin() {
	document.getElementById("checkTmtype").style.display = "none";
	document.getElementById("modifyTmtype").style.display = "none";
	document.getElementById("addTmtype").style.display = "none";
	document.getElementById("back").style.display = "none";
}
