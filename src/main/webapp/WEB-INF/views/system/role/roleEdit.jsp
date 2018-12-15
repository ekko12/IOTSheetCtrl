<%@ page language="java" pageEncoding="utf-8" isELIgnored="false" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path1 = request.getContextPath();
String basePath1 = request.getScheme() + "://"
          + request.getServerName() + ":" + request.getServerPort() + path1 + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>角色管理页-中国联通研究院大数据运营后台管理系统</title>
	<base href="<%=basePath1 %>" />
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
    <link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    <script type="text/javascript" src="js/jquery-2.1.4.js"></script>
    <script type="text/javascript" src="js/validate/jquery.validate.min.js"></script>
    <script type="text/javascript" src="js/validate/additional-methods.min.js"></script>
    <script type="text/javascript" src="js/validate/messages_zh.js"></script>
    <script type="text/javascript" src="js/kkpager/kkpager.min.js"></script>
    <script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
    <script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
    <script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script> 
    <script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script> 
</head>
<body>
<script type="text/javascript">
	$(function(){
		//系统菜单树设置,showFlag=true表示默认展开菜单
		$.ajax({
	        type : "POST",
	        url : "sysMenu/getMenuTree.do?showFlag=false",
	        datatype : "text",
	        success : function(result) {
	        	$.fn.zTree.init($("#menus_tree"), setting, result);
	        }
	    });
		//用户已授权菜单信息
		$.ajax({
	        type : "POST",
	        url : "sysMenu/getHasMenuTree.do?roleCode="+"${role.roleCode }",
	        datatype : "text",
	        success : function(result) {
	        	$.fn.zTree.init($("#has_menus_tree"), setting_has, result);
	        }
    	});
		//按钮功能全选
		$("#operateBtnAll").click(function() {
			if ($("#operateBtnAll").is(":checked")) {//全选
				$("input[name='operateCodes']").each(function() {
					$("input[name='operateCodes']").prop("checked", true);
				});
			} else {
				$("input[name='operateCodes']").each(function() {
					$("input[name='operateCodes']").removeAttr("checked");
				});
			}
		});
	});
</script>
<script type="text/javascript">
	var menuCode = "";
	var btnParam = [];
	//临时菜单功能容器{menuCode:btnParam}
	var tempBtnParam = {};
	var menuParams = "";
	var btnParams = "";
	function jiaoyanName(){
		if ($("#roleName").val()==null||$("#roleName").val()=="") {
            $.jBox.error("角色名称不能为空", '提示');
			return false;
		}
		return true;
	}
	function save(){
		if(!jiaoyanName())
			return false;
		var roleCode = $("#roleCode").val().trim();
		var roleName = $("#roleName").val().trim();
		//var status = $("#status option:selected").val();
		var roleDesc = $("#roleDesc").val().trim();
		var params = {};
		params["roleCode"]=roleCode;
		params["roleName"]=roleName;
		//params["status"]=status;
		params["roleDesc"]=roleDesc;
		params["type"]="edit";//操作类型
		
		buildParam();
		var treeToSave=$.fn.zTree.getZTreeObj("has_menus_tree");
		var nodesToSave = treeToSave.getCheckedNodes(true);
		for(x in nodesToSave){
			menuParams+=nodesToSave[x].id+" ";
			if (tempBtnParam[nodesToSave[x].id]!=null&&tempBtnParam[nodesToSave[x].id].length>0) {
				for(y in tempBtnParam[nodesToSave[x].id]){
					btnParams+=tempBtnParam[nodesToSave[x].id][y]+" ";
				}
			}
		}
		var btnParam = JSON.stringify(tempBtnParam);
		console.info(btnParam);
		params["menuParams"]=menuParams;
		//params["btnParams"]=btnParams;
		params["btnParams"]=btnParam;
		$.ajax({
			type: "POST",
			url: "sysRole/roleSaveOrUpdate.do",
			data: params,
			datatype: "json",
			success: function(msg){
				if (msg.flag) {
					$.jBox.tip(msg.msg,"success");
					setTimeout('window.location.href="sysRole/toRoleList.do"',500);
				} else {
		            $.jBox.error(msg.msg, '提示');
					menuParams = "";
					btnParams = "";
				}
			}
		});
	}
</script>
<script type="text/javascript">
	function buildParam(){
		$('input:checkbox[name=operateCodes]:checked').each(function(i){
			btnParam.push($(this).val());
		});
		
		tempBtnParam[menuCode] = btnParam;
		btnParam = [];
	}
</script>
<script type="text/javascript">
function checkStrInArray(str){
	if (tempBtnParam[menuCode]==undefined) return false;
	for(var i=0;i<tempBtnParam[menuCode].length;i++){
		if(tempBtnParam[menuCode][i] == str){
		return true;
		}
	}
	return false;
}
/**
 * 根据菜单编码获取菜单功能操作列表
 *@param menuCode 菜单编码
 */
function getFunOperateByMenuCode(event, treeId, treeNode) {
	if (menuCode!="") {
		buildParam();
	}
	menuCode = treeNode.id;
	//父菜单
	if (treeNode.isParent){
		$("#operate_btn_span").html("");
		return;
	}
	var roleCode = $("#roleCode").val();
	$.ajax({
		type: "POST",
		url: "funOperate/getFunOperatesByMenuCode.do?menuCode="+treeNode.id+"&roleCode="+"${role.roleCode }",
		datatype: "json",
		success: function(result) {
			if (result!='' && result.length > 0){
				$("#operateBtn").show();
				$("#operate_btn_span").html("");
				$("#currMenuCode").val(treeNode.id);
				for (var m = 0; m < result.length; m++) {
					if (tempBtnParam[menuCode]==undefined) {
						if (result[m].isChecked) {
							$('#operate_btn_span').append('<label style=\"font-size:12px\"><input name="operateCodes" type="checkbox" checked="checked" value="'+result[m].operateCode+'"> '+result[m].operateDesc+'</label><br />');
						} else {
							$('#operate_btn_span').append('<label style=\"font-size:12px\"><input name="operateCodes" type="checkbox" value="'+result[m].operateCode+'"> '+result[m].operateDesc+'</label><br />');
						}
					} else if (checkStrInArray(result[m].operateCode)) {
						$('#operate_btn_span').append('<label><input name="operateCodes" type="checkbox" checked="checked" value="'+result[m].operateCode+'"> '+result[m].operateDesc+'</label><br />');
					} else {
						$('#operate_btn_span').append('<label><input name="operateCodes" type="checkbox" value="'+result[m].operateCode+'"> '+result[m].operateDesc+'</label><br />');
					}
				}
			}else{
				$("#operate_btn_span").html("");
				$("#operateBtn").hide();
			}
			$("#operateBtnAll").attr("checked" , false);
		}
	});
}
//系统菜单参数设置
var setting = {
	check: { enable: true },
	data: { simpleData: { enable: true } }
};
//已授权菜单参数设置
var setting_has = {
	check: { enable: true },
	data: { simpleData: { enable: true } },
	callback: { onClick: getFunOperateByMenuCode }
};
</script>
<script type="text/javascript">
/**
 * 系统菜单授权选择事件
 */
function authorize() {
	//系统菜单获取
	var treeObj = $.fn.zTree.getZTreeObj("menus_tree");
	var nodes = treeObj.getCheckedNodes(true);
	if (null==nodes || nodes==''){
        $.jBox.error("请选择需要角色授权的系统菜单 !", '提示');
		return;
	}
	//角色已经授予的菜单(全部数据)
	var hasTreeObj = $.fn.zTree.getZTreeObj("has_menus_tree");
	var hasMenuIds = [];
	var hasMenus = [];
	if (null!=hasTreeObj){
		hasMenus = hasTreeObj.getNodes();//只包含根节点数据
		var _hasMenus = hasTreeObj.transformToArray(hasMenus);//将数据转换为array，包含所有子节点和根节点数据
		for (var i = 0; i < _hasMenus.length; i++)
			hasMenuIds.push(_hasMenus[i].id);
	}
	//最新授权选中的系统菜单
	var addMenu = [];//记录系统菜单中选中的node(包含父级)
	var addMenuId = [];//记录系统菜单中选中的node.id(包含父级)
	for (var i = 0; i < nodes.length; i++) {
		findMenu(addMenu, addMenuId, nodes[i], hasMenuIds);
	}
	//添加新菜单到原有菜单上
	for (var i = 0; i < addMenu.length; i++) {
		var n = {id:addMenu[i].id, pId:addMenu[i].pId, name:addMenu[i].name, open:true};//checked:true, 
		hasMenus.push(n);
	}
	//数据展示
	$.fn.zTree.init($("#has_menus_tree"), setting_has, hasMenus);
}
/**
 * 角色菜单取消授权
 */
function cancelAuthorize(){
	var hasObj = $.fn.zTree.getZTreeObj("has_menus_tree");
	if (null == hasObj){
		return;//无授权菜单，则返回
	}
	var nodes = hasObj.getCheckedNodes(true);
	if (null==nodes||nodes=='') {
		return;
	}
	//移除取消授权的菜单数据
	for (var i = 0; i < nodes.length; i++){
		removeCancelMenu(hasObj, nodes[i]);
	}
	//移除后菜单数据
	var hasMenus = hasObj.getNodes();//只包含根节点数据
	hasMenus = hasObj.transformToArray(hasMenus);//将数据转换为array，包含所有子节点和根节点数据
	var menuIds = [];
	for (var i = 0; i < hasMenus.length; i++)
		menuIds.push(hasMenus[i].id);
}
/**
 * 递归移除选中的菜单
 * @param hasObj 当前操作的菜单树对象
 * @param node 当前菜单节点
 */
function removeCancelMenu(hasObj, node) {
	if (node.checked){//被选中
		if (node.isParent) {//父菜单
			//判断父菜单选中的状态
			if (node.check_Child_State == 2) {//子节点全部被选中
				hasObj.removeNode(node);
			} else if (node.check_Child_State == 1){//部分子节点被选中
				var childs = node.children;//子节点集合
				for (var i = 0; i < childs.length; i++) {
					removeCancelMenu(hasObj, childs[i])
				}
			}
		} else {
			hasObj.removeNode(node);
		}
	}
}
/**
 * 递归查找授权的菜单树型
 * @param addMenu 记录树型node
 * @param addMenuId 记录树型node.id
 * @param node 当前node
 * @param hasMenuIds 角色已经授权的菜单ID
 */
function findMenu(addMenu, addMenuId, node, hasMenuIds) {
	if ($.inArray(node.id, hasMenuIds) != -1) {
		//-1表示角色已经存在该菜单，则返回
		return;
	} else {
		hasMenuIds.push(node.id);//则新增
	}
	if ($.inArray(node.id, addMenuId) == -1 && node.checked) {//addMenuId中不存在，且所被选中的菜单
		if (node.isParent) {
			var n = {id:node.id, pId:node.pId, name:node.name, checked:true, open:true};
			addMenu.push(n);
		} else {
			addMenu.push(node);
		}
		addMenuId.push(node.id);
	}
	//判断是否存在父节点
	var parentNode = node.getParentNode();
    if (parentNode != null) {//存在父节点
    	findMenu(addMenu, addMenuId, parentNode, hasMenuIds);
    }
}
</script>
<!-------------------------CONT---------------------------->  
<div class="Edit-cont box-cont">
	<div class="panel panel-default">
         <div class="panel-header">
           <h4>角色管理</h4>
         </div>
         <div class="panel-body">
         	<div class="panel panel-primary">
               <div class="panel-header">
                   <h4>修改角色</h4>
               </div>
               <div class="panel-body">
               	<div class="user-form">
                	<form>
                       <div class="form-group">
                           <label class="form-label" for="">角色编码：</label>
                            <input id="roleCode" name="roleCode" maxlength="32" type="text" class="input-text" readonly disabled value="${role.roleCode }">
                       </div>
                       
                       <%--<div class="form-group">
                           <label class="form-label" for="">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label>
                           <select class="input-text" name="status" id="status">
                               <option value="1" <c:if test="${role.status eq 1 }">selected</c:if>>有效</option>
                               <option value="0" <c:if test="${role.status eq 0 }">selected</c:if>>无效</option>
                           </select>
                       </div>--%>
                       <div class="form-group">
                           <label class="form-label" for="">角&nbsp;&nbsp;色&nbsp;&nbsp;名：</label>
                           <input id="roleName" name="roleName" maxlength="100" type="text" class="input-text" value="${role.roleName }" onblur="jiaoyanName();">
                       </div>
                     <div class="form-group">
                           <label class="form-label" for="">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</label>
                           <textarea class="textarea" name="roleDesc" maxlength="500" id="roleDesc" cols="30" rows="5">${role.roleDesc }</textarea>
                       </div>
                       <div class="form-group">
                           <label class="form-label" for="">操作权限设置：</label>
                           <div class="role-setting-wrap">
                           <div class="box">
                               <div class="hd">菜单列表</div>
                               <div class="bd">
                                    <ul id="menus_tree" class="ztree"></ul>
                               </div>
                           </div>
                           <div class="op-box">
                               <span><a onclick="authorize()"><i class="fa fa-arrow-circle-o-right"></i></a></span>
                               <span><a onclick="cancelAuthorize()"><i class="fa fa-arrow-circle-o-left"></a></i></span>
                           </div>
                            <div class="box">
                               <div class="hd">已选择菜单</div>
                               <div class="bd">
                                    <ul id="has_menus_tree" class="ztree"></ul>
                               </div>
                           </div>
                            <div class="box">
                               <div class="hd">按钮功能权限</div>
                               <div class="bd">
			             			<label style="font-size:12px"><input id="operateBtnAll" name="operateBtnAll" type="checkbox"> 选择所有</label>
						            <hr>
						            <span id="operate_btn_span"></span>
			          				<input type='hidden' name='currMenuCode' id='currMenuCode' value='' />
                               </div>
                           </div>
                          </div>
                       </div>
                     </form>
                    </div> 
                  </div>
                </div>
            <div class="btn-wrap pl-20 mt-10">
				<a class="btn btn-primary ml-10" onclick="save();">保存</a>
				<a class="btn btn-secondary ml-10" href="javascript:history.go(-1);return false;">取消</a>
            </div>
        </div> 
     </div>                                      
  </div>
</body>
</html>
