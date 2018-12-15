var prizeRuleDG=null;
var param={
		
};
$(function(){
	prizeRuleDG=$('#prizeRuleDG').datagrid({
		url : 'prizeRule/getPrizeRuleList.do',
		fit : true,
		nowrap : true,
		fitColumns : true,
		pagination : true,
		rownumbers : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40, 50 ],
		idField : 'prizeId',
		columns : [ [ {
			field : 'prizeId',
			checkbox:true
		}, {
			field : 'prizeName',
			align : 'left',
			width : 50,
			title : '抽奖活动规则名称'
		},{
			field : 'orderMinamt',
			align : 'center',
			width : 50,
			title : '最小订单金额'
		},{
			field : 'orderMaxamt',
			align : 'center',
			width : 50,
			title : '最大订单金额'
		},{
			field : 'orderStateText',
			align : 'center',
			width : 50,
			title : '订单状态'
		},{
			field : 'status',
			hidden:true
		},{
			field : 'statusText',
			align : 'center',
			width : 50,
			title : '状态'
		},{
			field : 'useCount',
			hidden:true
		},{
			field : 'control',
			align : 'center',
			width : 30,
			title : '操作',
			formatter : function(value, rowData, rowIndex){
				var array=[];
				if(param.WCS_INVALID==rowData.status){
					if(param.REC){
						array.push('<a href="javascript:void(0);" onclick="renew('+rowData.prizeId+');" class="operButton" title="恢复"><img src="resources/easyui13/themes/gray/images/button/btn_renew.gif" alt="恢复" /></a>');
					}
				}else{
					array.push('<a href="prizeRule/visitModifyPrizeRule.do?type=query&prizeId='+rowData.prizeId+'"  class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
					if(param.UPD){
						array.push('<a href="javascript:void(0);" onclick="checkDelAndUpdate(\''+rowData.prizeId+'\',\''+rowData.useCount+'\',\'upd\');" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修改" /></a>');
					}
					if(param.DEL){
						array.push('<a href="javascript:void(0);" onclick="checkDelAndUpdate(\''+rowData.prizeId+'\',\''+rowData.useCount+'\',\'del\');" class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="禁用" /></a>');
					}
				}
				return array.join('');
			}
		} ] ],
		onLoadSuccess: function (data) {
			prizeRuleDG.datagrid('clearSelections'); 
		}
	});

	$('#queryRuleName').keypress(function(event) {
		if (event.keyCode == 13) {
			queryData();
			return false;
		}
	});
})

function checkDelAndUpdate(id,count,type){
	if(count>0){
		$.dialog({
			title:'提示',
		    content:'该规则已被抽奖活动所使用,不能进行禁用/修改操作!!!',
		    cancelVal: '确定',
		    cancel: true,
		    lock:true
		});
	}else{
		if(type=='del'){
			delConfirm(id);
		}else{
			location.href=rootPath+'/prizeRule/visitModifyPrizeRule.do?type=update&prizeId='+id;
		}
	}
}

function queryData(){
	prizeRuleDG.datagrid('load',{
		prizeName:$('#queryRuleName').val()
	});
}

function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	var noDel=[];
	var flag=false;
	if(undefined != id && "" != id){
		postData = 'prizeIds='+id;
		flag=true;
	}else{
		row = prizeRuleDG.datagrid('getSelections');
		if(row.length < 1){
			$.dialog({
			    content:'请选择您要禁用的抽奖活动规则信息!',
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
			return false;
		}			
		for(var i=0;i<row.length;i++){
			if(row[i].useCount>0){
				noDel.push(row[i].prizeName);
			}else{
				ids.push(row[i].prizeId);
				flag=true;
			}
		}
		postData='prizeIds='+ ids.join('&prizeIds='); 
	}
    
    var m='';
	if(noDel.length>0){
		m=noDel.join(',')+'规则已被活动所使用,不能进行禁用/修改操作,是否禁用其他规则?'
	}else{
		m='确定禁用抽奖规则信息?';
	}
	
	if(flag){
		$.dialog({
	    	title:'提示',
		    content:m,
		    cancelVal: '关闭',
		    cancel: true,
		    ok: function(){
		    	deletePrizeRule(postData);
		    },
		    lock:true
		});
	}else{
		$.dialog({
			title:'提示',
		    content:m,
		    cancelVal: '确定',
		    cancel: true,
		    lock:true
		});
	}
}
	
function deletePrizeRule(postData){
	$.ajax({
		type : 'POST',
		url : 'prizeRule/deletePrizeRule.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				prizeRuleDG.datagrid('load',{});
			}
			$.dialog({
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
		url : 'prizeRule/renewPrizeRule.do',
		data : 'prizeId='+id,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				prizeRuleDG.datagrid('load',{});
			}
			$.dialog({
			    content:msg.msg,
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
		}
	});
}

