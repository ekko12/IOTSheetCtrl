var couponRuleDG=null;
var param={};
$(function(){
	couponRuleDG=$('#couponRuleDG').datagrid({
		url : 'couponRule/getCouponRuleList.do',
		fit : true,
		nowrap : true,
		fitColumns : true,
		pagination : true,
		rownumbers : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40, 50 ],
		idField : 'couponId',
		columns : [ [ {
			field : 'couponId',
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
			field : 'couponQty',
			align : 'center',
			width : 50,
			title : '数量'
		},{
			field : 'couponEnddateText',
			align : 'left',
			width : 50,
			title : '有效期截至'
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
						array.push('<a href="javascript:void(0);" onclick="renew('+rowData.couponId+');" class="operButton" title="恢复"><img src="resources/easyui13/themes/gray/images/button/btn_renew.gif" alt="恢复" /></a>');
					}
				}else{
					array.push('<a href="couponRule/visitModifyCouponRule.do?type=query&couponId='+rowData.couponId+'"  class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
					if(param.UPD){
						array.push('<a href="javascript:void(0);" onclick="checkDelAndUpdate(\''+rowData.couponId+'\',\''+rowData.useCount+'\',\'upd\');" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修改" /></a>');
					}
					if(param.DEL){
						array.push('<a href="javascript:void(0);" onclick="checkDelAndUpdate(\''+rowData.couponId+'\',\''+rowData.useCount+'\',\'del\');" class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="禁用" /></a>');
					}
					array.push('<a href="javascript:void(0);" onclick="generateCoupons(\''+rowData.couponId+'\');" class="operButton" title="生成优惠券"><img src="resources/easyui13/themes/gray/images/button/btn_status_change.gif" alt="禁用" /></a>');
				}
				return array.join('');
			}
		} ] ],
		onLoadSuccess: function (data) {
			couponRuleDG.datagrid('clearSelections'); 
		}
	});

	$('#queryRuleName').keypress(function(event) {
		if (event.keyCode == 13) {
			queryData();
			return false;
		}
	});
})

function queryData(){
	couponRuleDG.datagrid('load',{
		couponRuleName:$('#queryRuleName').val()
	});
}

function checkDelAndUpdate(id,count,type){
	if(count>0){
		$.dialog({
			title:'提示',
		    content:'该规则已被优惠券活动所使用,不能进行禁用/修改操作!!!',
		    cancelVal: '确定',
		    cancel: true,
		    lock:true
		});
	}else{
		if(type=='del'){
			delConfirm(id);
		}else{
			location.href=rootPath+'/couponRule/visitModifyCouponRule.do?type=update&couponId='+id;
		}
	}
}

function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	var noDel=[];
	var flag=false;
	if(undefined != id && "" != id){
		postData = 'couponIds='+id;
		flag=true;
	}else{
		row = couponRuleDG.datagrid('getSelections');
		if(row.length < 1){
			$.dialog({
				title:'提示',
			    content:'请选择您要禁用的优惠券规则信息!',
			    cancelVal: '确定',
			    cancel: true,
			    lock:true
			});
			return false;
		}			
		for(var i=0;i<row.length;i++){
			if(row[i].useCount>0){
				noDel.push(row[i].couponName);
			}else{
				ids.push(row[i].couponId);
				flag=true;
			}
		}
		postData='couponIds='+ ids.join('&couponIds='); 
	}
	
	var m='';
	if(noDel.length>0){
		m=noDel.join(',')+'规则已被活动所使用,不能进行禁用/修改操作,是否禁用其他规则?'
	}else{
		m='确定禁用优惠券规则信息?';
	}
	
	if(flag){
		$.dialog({
	    	title:'提示',
		    content:m,
		    cancelVal: '关闭',
		    cancel: true,
		    ok: function(){
		       deleteCouponRule(postData);
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
	
function deleteCouponRule(postData){
	$.ajax({
		type : 'POST',
		url : 'couponRule/deleteCouponRule.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				couponRuleDG.datagrid('load',{});
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
		url : 'couponRule/renewCouponRule.do',
		data : 'couponId='+id,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				couponRuleDG.datagrid('load',{});
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

function generateCoupons(id){
	
	var len2=$('#couponNum').val();
	if(len2<6){
		alert("编号位数需要大于6位!!!");
		return false;
	}
	var maxCount=Math.pow(10,len2-1);//根据编号位数一共可以生成的总数量
	var couponQty=$('#couponQty').val();//获取数量所填数字位数
	if(couponQty > 0){
		if(couponQty>maxCount){
			alert("编号位数偏小,请重新输入!!!");
			return false;
		}
	}
	
	var counts=$('#counts').val();//获取已经根据该编号已经生成的
	var has=maxCount-counts;//剩余所能生成的优惠券
	if(has-couponQty < 0){
		alert("剩余"+has+"张优惠券可以生成,超出剩余量!!!");
		return false;
	}
	$.messager.progress(); 
	$.ajax({
		type:'post',
		url:'couponRule/generateCoupons.do',
		data:'couponId='+id,
		success:function(msg){
			$.messager.progress('close'); 
			$.dialog({
				title:'提示',
			    content:msg.msg,
			    ok: function(){
			    },
			    lock:true
			});
		}
	})
}

