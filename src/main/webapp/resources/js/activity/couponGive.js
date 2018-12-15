var couponGiveDG=null;
var param={
		
};
$(function(){
	couponGiveDG=$('#couponGiveDG').datagrid({
		url : 'couponGive/getCouponGiveList.do',
		fit : true,
		nowrap : true,
		fitColumns : true,
		pagination : true,
		rownumbers : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40, 50 ],
		idField : 'couponGiveId',
		columns : [ [ {
			field : 'couponGiveId',
			checkbox:true
		}, {
			field : 'couponName',
			align : 'left',
			width : 50,
			title : '优惠券规则名称'
		},{
			field : 'couponAmt',
			align : 'center',
			width : 50,
			title : '面值'
		},{
			field : 'couponNo',
			align : 'center',
			width : 50,
			title : '优惠券编号'
		},{
			field : 'endDateText',
			align : 'left',
			width : 70,
			title : '截止日期'
		},{
			field : 'userId',
			align : 'left',
			width : 50,
			title : '商城用户id'
		},{
			field : 'usedState',
			hidden:true
		},{
			field : 'usedStateText',
			align : 'left',
			width : 50,
			title : '状态'
		},{
			field : 'ifstopUse',
			align : 'left',
			width : 50,
			title : '是否可用',
			formatter : function(value, rowData, rowIndex){
				if(param.WCS_INVALID==value){
					return '不可用';
				}else{
					return '可用';
				}
			}
		},{
			field : 'control',
			align : 'center',
			width : 30,
			title : '操作',
			formatter : function(value, rowData, rowIndex){
				var array=[];
				if(param.WCS_INVALID==rowData.ifstopUse){
					if(param.REC){
						array.push('<a href="javascript:void(0);" onclick="renew('+rowData.couponGiveId+');" class="operButton" title="启用"><img src="resources/easyui13/themes/gray/images/button/btn_renew.gif" alt="启用" /></a>');
					}
				}else{
					if(param.DEL){
						array.push('<a href="javascript:void(0);" onclick="delConfirm(\''+rowData.couponGiveId+'\');" class="operButton" title="停用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="停用" /></a>');
					}
				}
				return array.join('');
			}
		} ] ],
		onLoadSuccess: function (data) {
			couponGiveDG.datagrid('clearSelections'); 
		}
	});

	$('#queryGiveName').keypress(function(event) {
		if (event.keyCode == 13) {
			queryData();
			return false;
		}
	});
	
	$('#queryGiveNo').keypress(function(event) {
		if (event.keyCode == 13) {
			queryData();
			return false;
		}
	});
})

function queryData(){
	couponGiveDG.datagrid('load',{
		ruleName:$('#queryGiveName').val(),
		couponNo:$('#queryGiveNo').val(),
		status:$('#statusList').val()
	});
}

/** 导出excel */
function exportToExecle(){
	$.dialog({
		title:'提示',
		content: '确定导出?',
	    ok: function(){
	        $('#giveForm').submit();
	        couponGiveDG.datagrid('load',{});
	    },
	    cancelVal: '关闭',
	    cancel: true,
	    lock:true
	});
}

function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	if(undefined != id && "" != id){
		postData = 'couponGiveIds='+id;
	}else{
		row = couponGiveDG.datagrid('getSelections');
		if(row.length < 1){
			$.dialog({
				title:'提示',
			    content:'请选择您要禁用的优惠券信息!',
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
			return false;
		}			
		for(var i=0;i<row.length;i++){
			ids.push(row[i].couponGiveId);
		}
		postData='couponGiveIds='+ ids.join('&couponGiveIds='); 
	}
    $.dialog({
    	title:'提示',
	    content:'确定禁用优惠券信息?',
	    cancelVal: '关闭',
	    cancel: true,
	    ok: function(){
	       deleteCouponGive(postData);
	    },
	    lock:true
	});
}
	
function deleteCouponGive(postData){
	$.ajax({
		type : 'POST',
		url : 'couponGive/deleteCouponGive.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				couponGiveDG.datagrid('load',{});
			}
			$.dialog({
				title:'提示',
			    content:msg.msg,
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
		}
	});
}

function renew(id){
	$.ajax({
		type : 'POST',
		url : 'couponGive/renewCouponGive.do',
		data : 'couponGiveId='+id,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				couponGiveDG.datagrid('load',{});
			}
			$.dialog({
				title:'提示',
			    content:msg.msg,
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
		}
	});
}

