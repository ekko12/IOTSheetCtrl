/**
 * 规则组列表数据加载
 */
var ruleTable=null;
$(document).ready(function() {
	ruleTable=$('#ruleTable').datagrid({
        url : 'wfRules/getRuleList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'ruleId',
        columns : [[
               {
//    			field :'code',
//    			checkbox:true
//            }, {
                field : 'ruleName',
                align : 'center',
                width : 50,
                title : '<span><b>规则名称</b></span>'
            }, {
                field : 'processName',
                align : 'center',
                width : 50,
                title : '<span><b>流程名称</b></span>'
            }, {
                field : 'processDetail',
                align : 'center',
                width : 130,
                title : '<span><b>流程明细</b></span>'
            }, {
                field : 'control',
                align : 'center',
                width : 50,
                title : '<span><b>操作</b></span>',
                formatter : function(value, rowData, rowIndex) {
                	var array=[];
                	if(WF_RULE_CONFIG_DETAIL){
                    	array.push('<a href="javascript:void(0)" onclick="operWin(\'查看详情\', \'detail\', \''+rowData.ruleId+'\')" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="Detail" /></a>');
                	}
                	if(WF_RULE_CONFIG_EDIT){
                    	array.push('<a href="javascript:void(0)" onclick="operWin(\'修改\', \'edit\', \''+rowData.ruleId+'\')" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="Edit" /></a>');
                	}
                	if(WF_RULE_CONFIG_DELETE){
                    	array.push('<a href="javascript:void(0);" onclick="delConfirm(\''+rowData.ruleId+'\');" class="operButton" title="删除"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="Delete" /></a>');
                	}
    				return array.join('');
                }
            }]],
        onLoadSuccess : function(data) {
        	ruleTable.datagrid('clearSelections');
        }
    });
});

/**查询函数*/
function queryData(){
	ruleTable.datagrid('load', {
		ruleName:$('#ruleName').val(),
	});
}

/**
 * 弹出新窗口
 * @param title 窗口标题
 * @param operType 类型
 * @param code 角色编码
 * @param page 需要打开的页面
 */
function operWin(title, operType, ruleId) {
	var params = "?operType=" + operType +"&ruleId="+ruleId;
	$.dialog({
		title: title,
		lock: true,
		drag: false,
		resize: false,
	    width: '575px',
	    height: '465px',
	    zIndex: 1970,
	    content: "url:wfRules/toPage.do" + params
	});
}

/**
 * 禁用规则组信息确认
 * @param id
 * @returns {Boolean}
 */
function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	if(id){
		postData = 'ruleIds='+id;
	} else {
		row = ruleTable.datagrid('getSelections');
		if(row.length < 1){
			//提示信息
			$.dialog({
				lock: true,
				title: "提示信息",
			    content: "请选择您要删除的记录!",
			    ok: function(){
			        this.title('提示信息：').time(0.001);//0.001秒后关闭
			    	return false;
			    },
			    cancelVal: 'Close',
			    cancel: true
			});
			return false;
		}			
		for(var i=0;i<row.length;i++){
			ids.push(row[i].ruleId);
		}
		postData='ruleIds='+ ids.join('&ruleIds=');
	}
	$.dialog.confirm('确认删除此记录?', function(){
		deleteData(postData);
	}, function(){
	    //$.dialog.tips('执行取消操作');
	});
}

/**角色禁用*/
function deleteData(postData){
	$.ajax({
		type : 'POST',
		url : 'wfRules/deleteRules.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				ruleTable.datagrid('load',{});
			}
			
			//提示信息
			$.dialog({
				lock: true,
				title: "提示信息",
			    content: msg.msg,
			    cancelVal: 'Close',
			    cancel: true
			});
		}
	});
}
