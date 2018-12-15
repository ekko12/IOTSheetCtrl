var mallDG=null;
var param={};
$(function(){
mallDG=$('#mallDG').datagrid({
	url : rootPath+'/mall/getMallList.do',
	fit : true,
	nowrap : true,
	fitColumns : true,
	pagination : true,
	rownumbers : true,
	pageSize : 10,
	pageList : [ 10, 20, 30, 40, 50 ],
	idField : 'mallCode',
	columns : [ [ {
		field : 'mallCode',
		checkbox:false,
		hidden:true
	}, {
		field : 'mallName',
		align : 'left',
		width : 50,
		title : '站点名称'
	}/*,{
		field : 'channelCounts',
		align : 'center',
		width : 50,
		title : '渠道数量',
		formatter : function(value, rowData, rowIndex){
			return '<a style="text-decoration: underline;color: blue;" href="mall/modifyMall.do?type=query&from=list&mallCode='+rowData.mallCode+'">'+value+'</a>';
		}
	},{
		field : 'templateCounts',
		align : 'center',
		width : 50,
		title : '模板数量'
	}*/,{
		field : 'mallDomain',
		align : 'center',
		width : 50,
		title : '站点域名'
	},{
		field : 'mallStatus',
		hidden:true
	},{
		field : 'mallStatusText',
		align : 'left',
		width : 50,
		title : '状态'
	},{
		field : 'control',
		align : 'center',
		width : 30,
		title : '操作',
		formatter : function(value, rowData, rowIndex){
			var array=[];
			/*if(param.WCS_INVALID==rowData.mallStatus){
				if(param.REC){
					array.push('<a href="javascript:void(0);" onclick="renew(\''+rowData.mallCode+'\');" class="operButton" title="恢复"><img src="resources/easyui13/themes/gray/images/button/btn_renew.gif" alt="恢复" /></a>');
				}
			}else{
				array.push('<a href="mall/modifyMall.do?type=query&mallCode='+rowData.mallCode+'"  class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
				if(param.UPD){
					array.push('<a href="mall/modifyMall.do?type=update&mallCode='+rowData.mallCode+'" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修改" /></a>');
				}
				if(param.DEL){
					array.push('<a href="javascript:void(0);" onclick="delConfirm(\''+rowData.mallCode+'\');" class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="禁用" /></a>');
				}
			}*/
			if(param.DETAIL){
				array.push('<a href="mall/modifyMall.do?type=query&mallCode='+rowData.mallCode+'"  class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
			}
			if(param.UPD){
				array.push('<a href="mall/modifyMall.do?type=update&mallCode='+rowData.mallCode+'" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修改" /></a>');
			}
			return array.join('');
		}
	} ] ],
	onLoadSuccess: function (data) {
		mallDG.datagrid('clearSelections'); 
	}
});

$('#queryMallName').keypress(function(event) {
	if (event.keyCode == 13) {
		queryData();
		return false;
	}
});
})


function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	if(undefined != id && "" != id){
		postData = 'mallCodes='+id;
	}else{
		row = mallDG.datagrid('getSelections');
		if(row.length < 1){
			$.dialog({
				title:'提示信息',
			    content:'请选择您要禁用的站点信息!',
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
			return false;
		}			
		for(var i=0;i<row.length;i++){
			ids.push(row[i].mallCode);
		}
		postData='mallCodes='+ ids.join('&mallCodes='); 
	}
    $.dialog({
    	title:'提示信息',
	    content:'确定禁用站点信息?',
	    cancelVal: '关闭',
	    cancel: true,
	    ok: function(){
	       deleteMall(postData);
	    },
	    lock:true
	});
}
	
function deleteMall(postData){
	$.ajax({
		type : 'POST',
		url : 'mall/deleteMall.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				mallDG.datagrid('load',{});
			}
			$.dialog({
				title:'提示信息',
			    content:msg.msg,
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
		}
	});
}

function queryData(){
	mallDG.datagrid('load',{
		mallName:$.trim($('#queryMallName').val())
	});
}
		
		function show(id)
		{
			var divid = "" + id;
			divid = "#" + divid;
			$(divid).css('display','block');
		}
		
		function hide(id)
		{
			var divid = "" + id;
			divid = "#" + divid;
			$(divid).hide();
		}
		
function renew(code){
	$.ajax({
		type : 'POST',
		url : 'mall/renewMall.do',
		data : 'mallCode='+code,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				mallDG.datagrid('load',{});
			}
			$.dialog({
				title:'提示信息',
			    content:msg.msg,
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
		}
	});
}