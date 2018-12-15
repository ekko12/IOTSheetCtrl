/**
 * 
 */
var channelOrdersDG=null;
/**
 * 列表数据查询
 */
$(function(){
	var channel_id = $("#channelId").val();
	channelOrdersDG=$("#channelOrdersDG").datagrid({
		url : "channelOrder/getChannelOrdersList.do?channelId="+channel_id,
		fit : true,
		nowrap : true,
		fitColumns : true,
		pagination : true,
		rownumbers : true,
		singleSelect : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40, 50 ],
		idField : "orderId",
		columns : [ [ 
		{
			field : "orderId",
			align : "left",
			width : 20,
			title : "订单号"
		},{
			field : "goodsName",
			align : "left",
			width : 20,
			title : "Product name"
		},{
			field : "outOrderStatusTxt",
			align : "center",
			width : 10,
			title : "外部订单状态"
		},{
			field : "mallName",
			align : "left",
			width : 10,
			title : "所属商城"
		},{
			field : "orderOrigFee",
			align : "right",
			width : 10,
			title : "Amount receivable",
			formatter: function(val,rec){return val.toFixed(2);}
		},{
			field : "orderFavorableFee",
			align : "right",
			width : 10,
			title : "优惠金额",
			formatter: function(val,rec){return val.toFixed(2);}
		},{
			field : "orderRealFee",
			align : "right",
			width : 10,
			title : "Amount paid",
			formatter: function(val,rec){return val.toFixed(2);}
		},{
			field : "control",
			align : "center",
			width : 10,
			title : "Operations",
			formatter : function(value, rowData, rowIndex) {
				return "<a href='order/getDetail.do?orderId="+rowData.orderId+"&returnFlag=channel&channelId="+channel_id+"' class='operButton' title='详情'><img src='resources/easyui13/themes/gray/images/button/btn_detail.gif' alt='详情' /></a>";
			}
		} ] ],
		onLoadSuccess: function (data) {
			channelOrdersDG.datagrid('clearSelections'); 
		}
	});
})

/**
 * 渠道订单信息查询
 */
function queryData(){
	channelOrdersDG.datagrid('load',{
		orderId:$('#orderId').val(),
		goodsName:$('#goodsName').val(),
		mallCode:$('#mallCode').val(),
		status:$('#status').val()
	});
}

