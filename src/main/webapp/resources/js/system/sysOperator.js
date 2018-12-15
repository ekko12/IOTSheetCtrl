/**
 * 操作员列表
 */
var sysOperatorTable=null;
$(document).ready(function() {
	sysOperatorTable=$('#sysOperatorTable').datagrid({
        url : 'operator/getSysOperList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'operId',
        columns : [[{
			field :'sysOper',
			checkbox:true
        }, {
            field : 'operId',
            align : 'center',
            width : 80,
            title : '<span><b>登录账户</b></span>'
        }, {
            field : 'operName',
            align : 'center',
            width : 70,
            title : '<span><b>姓名</b></span>'
        },{
            field : 'groName',
            align : 'center',
            width : 80,
            title : '<span><b>所属用户组</b></span>',
            formatter: function(value, rowData, rowIndex) {
				if (null != value && value.length>20){
					return "<font title='"+value+"'>"+value.substr(0,20)+"...</font>";
				} else {
					return value;
				}
			}
        }, {
            field : 'orgName',
            align : 'center',
            width : 60,
            title : '<span><b>所属组织挤沟沟</b></span>'
        }, {
            field : 'statusTxt',
            align : 'center',
            width : 30,
            title : '<span><b>状态</b></span>'
        }, {
            field : 'lastLoginTimeTxt',
            align : 'center',
            width : 80,
            title : '<span><b>上次登录时间</b></span>'
        }, {
            field : 'control',
            align : 'center',
            width : 80,
            title : '<span><b>操作</b></span>',
            formatter : function(value, rowData, rowIndex) {
            	var array=[];
				if("0" == rowData.status){
					if (SYS_USER_LIST_REC){
					array.push("<a href='javascript:void(0)' onclick='recover(\""+rowData.operId+"\")' class='operButton' title='恢复'><img src='resources/easyui13/themes/gray/images/button/btn_renew.gif' alt='Recovery' /></a>");
					}
				} else {
					if(SYS_USER_LIST_DETAIL){
						array.push('<a href="operator/toPage.do?operType=detail&operId='+rowData.operId+'" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="Details" /></a>');
					}
					if (SYS_USER_LIST_UPD){
					array.push('<a href="operator/toPage.do?operType=edit&operId='+rowData.operId+'" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="Edit" /></a>');
					}
					if (SYS_USER_LIST_DEL){
					array.push('<a href="javascript:void(0);" onclick="delConfirm(\''+rowData.operId+'\');" class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="Disable" /></a>');
					}
					if(SYS_USER_LIST_UPDPASS){
						array.push('<a href="javascript:void(0);" onclick="updatePwd(\''+rowData.operId+'\');" class="operButton" title="修改密码"><img src="resources/easyui13/themes/gray/images/button/btn_underUser.gif" alt="edit password" /></a>');
					}
				}
				return array.join('');
            }
        }]],
        onLoadSuccess : function(data) {
            sysOperatorTable.datagrid('clearSelections');
        }
    });
});

/**
 * 操作员列表查询
 */
function queryData(){
	sysOperatorTable.datagrid('load',{
		operId:$('#operId').val(),
		operName:$('#operName').val(),
		status:$('#status').val(),
		orgCode:$('#orgCode').val(),
		groCode:$('#groCode').val()
	});
}

/**
 * 禁用用户信息
 * @param id
 * @returns {Boolean}
 */
function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	if(id){
		postData = 'operIds='+id;
	} else {
		row = sysOperatorTable.datagrid('getSelections');
		if(row.length < 1){
			$.messager.alert('提示', '请选择您要禁用的记录！', 'warning');
			return false;
		}			
		for(var i=0;i<row.length;i++){
			ids.push(row[i].operId);
		}
		postData='operIds='+ ids.join('&operIds=');
	}
	$.messager.confirm('提示','确定禁用此记录吗？', function (r) {
       	if (r) {
       		deleteData(postData);
       	}
    });
}
/**
 * 操作员状态禁用
 */
function deleteData(postData){
	$.ajax({
		type : 'POST',
		url : 'operator/deleteOperator.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				sysOperatorTable.datagrid('load',{});
			}
			$.messager.alert('提示', msg.msg, 'info');
		}
	});
}

/**
 * 操作员状态恢复
 */
function recover(code){
	$.ajax({
		type : 'POST',
		url : 'operator/recoverOperator.do',
		data : "operId="+code,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				sysOperatorTable.datagrid('load',{});
			}
			$.messager.alert('提示', msg.msg, 'info');
		}
	});
}

function updatePwd(id){
	$.dialog({
		title : '修改密码',
		content : 'url:operator/updatePwd.do?id='+id,
		lock:true
	});
}
