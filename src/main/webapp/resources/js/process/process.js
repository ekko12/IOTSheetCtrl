/**
 * 流程信息列表数据加载
 */
var processTable=null;
$(document).ready(function() {
	processTable=$('#processTable').datagrid({
        url : 'process/getProcessList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'processId',
        columns : [[
               {
//    			field :'processId',
//    			checkbox:true
//            }, {
                field : 'processName',
                align : 'center',
                width : 80,
                title : '<span><b>流程名称</b></span>'
            }, {
                field : 'processType',
                align : 'center',
                width : 50,
                title : '<span><b>流程类型</b></span>',
                formatter : function(value, rowData, rowIndex){
                	
                	var typeName = "";
                	for(var t in typeJson){
                		if (value == t){
                			typeName = typeJson[t];
                			break;
                		}
                	}
                	return typeName;
                }
            }, {
                field : 'creater',
                align : 'center',
                width : 30,
                title : '<span><b>创建人</b></span>'
            }, {
                field : 'createTime',
                align : 'center',
                width : 50,
                title : '<span><b>创建时间</b></span>',
            	formatter : function(value, rowData, rowIndex){
                    if(value){
                    	 return new Date(value).format('yyyy-MM-dd hh:mm:ss');
                    }else{
                      return "";
                    }
                }
            }, {
                field : 'control',
                align : 'center',
                width : 80,
                title : '<span><b>操作</b></span>',
                formatter : function(value, rowData, rowIndex) {
                	var array=[];
                	if(WF_WORKFLOW_CONFIG_DETAIL){
                    	array.push('<a href="javascript:void(0)" onclick="openWin(\'流程详细信息\', \'detail\', \''+rowData.processId+'\')" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="Detail" /></a>');
                	}
    				return array.join('');
                }
            }]],
        onLoadSuccess : function(data) {
            //sysRoleTable.datagrid('clearSelections');
        }
    });
});

/**查询函数*/
function queryData(){
	processTable.datagrid('load', {
		processName:$('#processName').val(),
	});
}

/**
 * 弹出新窗口
 * @param title 窗口标题
 * @param operType 类型
 * @param code 角色编码
 * @param page 需要打开的页面
 */
function openWin(title, operType, processId) {
	var params = "?operType=" + operType +"&processId="+processId;
	$.dialog({
		title: title,
		lock: true,
		drag: false,
		resize: false,
	    width: '575px',
	    height: '465px',
	    zIndex: 1970,
	    content: "url:process/toPage.do" + params
	});
}


