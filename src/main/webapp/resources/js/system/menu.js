/**
 * 菜单树
 */
$(document).ready(function() {
    var setting = {
        data : {
            simpleData : {
                enable : true
            }
        },
        callback : {
            onClick : zTreeOnClick
        }
    };
    $.ajax({
        type : 'POST',
        url : 'sysMenu/getMenuTree.do',
        datatype : 'text',
        success : function(result) {
            $.fn.zTree.init($("#menuTree"), setting, result);
        }
    });
});

var menuDG=null;
/**
 * 菜单树单击事件
 * @param event
 * @param treeId
 * @param treeNode
 */
function zTreeOnClick(event, treeId, treeNode) {
	getMenuList('1',treeNode.id);
}

/**
 * 查询按钮事件
 */
function queryData(){
	menuDG.datagrid('load',{
		parentMenuCode:$('#parentMenuCode').val(),
		menuCode:$('#menuCode').val(),
		menuName:$('#menuName').val(),
		status:$('#status').val()
	});
}

/**
 * 详情查看事件
 */
function detail(code) {
	$.dialog({
	    content: '不显示最大化和最小化按钮',
	    max: false,
	    min: false
	});
}


/**
 * 禁用
 * @param id
 * @returns {Boolean}
 */
function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	if(undefined != id && "" != id){
		postData = 'menuCodes='+id;
	}else{
		row = menuDG.datagrid('getSelections');
		if(row.length < 1){
			//提示信息
			$.dialog({
				lock: true,
				title: "提示",
			    content: "请选择需要禁用的菜单!",
			    ok: function(){
			        this.title('提示：').time(0.001);//0.001秒后关闭
			    	return false;
			    },
			    cancelVal: '关闭',
			    cancel: true
			});
			return false;
		}
		for(var i=0;i<row.length;i++){
			ids.push(row[i].menuCode);
		}
		postData='menuCodes='+ ids.join('&menuCodes=');
	}
	//禁用
	$.dialog.confirm('确定要禁用菜单信息？', function(){
	    delChannel(postData);
	}, function(){
	    //$.dialog.tips('执行取消操作');
	});
}

/**
 * 禁用动作
 */
function delChannel(postData){
	$.ajax({
		type : 'POST',
		url : 'sysMenu/deleteMenu.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				menuDG.datagrid('load',{});
			}
			$.messager.alert('提示', msg.msg, 'info');
		}
	});
}

/**
 * 菜单数据恢复
 * @param channelId
 */
function recover(menuCode) {
	$.ajax({
		type : 'POST',
		url : 'sysMenu/recoverMenu.do',
		data : 'menuCode='+menuCode,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				menuDG.datagrid('load',{});
			}
			$.messager.alert('提示', msg.msg, 'info');
		}
	});
}

/**
 * 弹出新窗口
 * @param title 窗口标题
 * @param operType 类型
 * @param code 菜单编码
 * @param page 需要打开的页面
 */
function operWin(title, operType, code) {
	var params = "?operType=" + operType +"&menuCode="+code;
	$.dialog({
		title: title,
		lock: true,
		drag: false,
		resize: false,
	    width: '575px',
	    height: '465px',
	    content: "url:sysMenu/toPage.do" + params
	});
}
