/**
 * 用户组数据列表加载
 */
var sysUserGroupTable=null;
$(document).ready(function() {
	sysUserGroupTable=$('#sysUserGroupTable').datagrid({
        url : 'sysUserGroup/getUserGroupList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'groCode',
        columns : [[{
    			field :'sysUserGroup',
    			checkbox:true
            }, {
            	field : 'groCode',
                align : 'center',
                width : 50,
                title : '用户组编码'
            }, {
            	field : 'groName',
                align : 'center',
                width : 80,
                title : '用户组名称'
            }, {
                field : 'statusTxt',
                align : 'center',
                width : 80,
                title : '状态'
            }, {
                field : 'userNum',
                align : 'center',
                width : 80,
                title : '关联用户数',
                formatter:function(value, rowData, rowIndex){
                	return "<a href='sysUserGroup/toOperatorList.do?groCode="+rowData.groCode+"'>"+rowData.userNum+"</a>";
                }
            }, {
                field : 'groDesc',
                align : 'center',
                width : 50,
                title : '备注'
            }, {
                field : 'control',
                align : 'center',
                width : 80,
                title : '操作',
                formatter : function(value, rowData, rowIndex) {
                	var array=[];
    				if("0" == rowData.status){
    					if (SYS_USER_GROUP_REC){
    					array.push("<a href='javascript:void(0)' onclick='recover(\""+rowData.groCode+"\")' class='operButton' title='恢复'><img src='resources/easyui13/themes/gray/images/button/btn_renew.gif' alt='恢复' /></a>");
    					}
    				} else {
    					if (SYS_USER_GROUP_DETAIL){
    						array.push('<a href="javascript:void(0)" onclick="operWin(\'查看用户组详情\', \'detail\', \''+rowData.groCode+'\')" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
    					}
    					if (SYS_USER_GROUP_UPD) {
	    					array.push('<a href="javascript:void(0)" onclick="operWin(\'用户组信息编辑\', \'edit\', \''+rowData.groCode+'\')" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修改" /></a>');
	    				}
	    				if (SYS_USER_GROUP_DEL) {
	    					array.push('<a href="javascript:void(0);" onclick="delConfirm(\''+rowData.groCode+'\');" class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="禁用" /></a>');
	    				}
    				}
    				return array.join('');
                }
            }]],
        onLoadSuccess : function(data) {
        	sysUserGroupTable.datagrid('clearSelections');
        }
    });
});

/**
 * 查询函数
 */
function queryData(){
	sysUserGroupTable.datagrid('load',{
		groName:$('#groName').val(),
		groCode:$('#groCode').val(),
		status:$('#status').val()
	});
}

/**
 * 弹出新窗口
 * @param title 窗口标题
 * @param operType 类型
 * @param code 用户组编码
 */
function operWin(title, operType, code) {
	var params = "?operType=" + operType +"&groCode="+code;
	$.dialog({
		title: title,
		lock: true,
		drag: false,
		resize: false,
	    width: '575px',
	    height: '465px',
	    content: "url:sysUserGroup/toPage.do" + params
	});
}

/**
 * 禁用用户组信息
 * @param id
 * @returns {Boolean}
 */
function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	if(id){
		postData = 'groCodes='+id;
	} else {
		row = sysUserGroupTable.datagrid('getSelections');
		if(row.length < 1){
			$.messager.alert('提示信息', '请选择您要禁用的记录！', 'warning');
			return false;
		}			
		for(var i=0;i<row.length;i++){
			ids.push(row[i].groCode);
		}
		postData='groCodes='+ ids.join('&groCodes=');
	}
	$.messager.confirm('提示信息','确定禁用此记录吗？', function (r) {
       	if (r) {
       		deleteData(postData);
       	}
    });
}
/**用户组禁用*/
function deleteData(postData){
	$.ajax({
		type : 'POST',
		url : 'sysUserGroup/deleteUserGroup.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				sysUserGroupTable.datagrid('load',{});
			}
			$.messager.alert('提示信息', msg.msg, 'info');
		}
	});
}

/**
 * 用户组状态恢复
 */
function recover(code){
	$.ajax({
		type : 'POST',
		url : 'sysUserGroup/recoverUserGroup.do',
		data : "groCode="+code,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				sysUserGroupTable.datagrid('load',{});
			}
			$.messager.alert('提示信息', msg.msg, 'info');
		}
	});
}
