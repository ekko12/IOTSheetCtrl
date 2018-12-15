var channelItems = {};
$(document).ready(function() {
	var stockSpaceId=$("#stockSpaceId").val();
    $.ajax({
    	type : 'POST',
        url : 'inventory/getChannelOrSaleGoods.do',
        data : {stockSpaceId:stockSpaceId},
        datatype : 'json',
        success : function(data) {
        	
        	if(data.chlChannels!=null && data.chlChannels!=""){
        		var html = "";
                var id = 0;
                var label = "";
                
                $.each(data.chlChannels, function(commentIndex, comment) {
                	id = comment['channelId'];
                    label = comment['channelName'];
                    html +=
                            "<p id='ch_"
                                    + id
                                    + "'><span style='font-weight: normal;'><a href='javascript:void(0);' onclick=\"delItem('ch_',"
                                    + id + ")\">×</a>";
                    html += label + "</span><input type='hidden' name='channelId' value='" + id + "'/></p>";
                });
                $("#channelList").append(html);
                $("#cha_rad_part").attr("checked","checked");
                
                $("#addChanBtn").attr("disabled", false);
                $("#addChanBtn").attr("class", "button5");
            }else{
            	$("#cha_rad_all").attr("checked","checked");
            }
        	
        	if(data.saleGoods!=null && data.saleGoods!=""){
        		var html = "";
                var id = 0;
                var label = "";
                
                $.each(data.saleGoods, function(commentIndex, comment) {
                	id = comment['saleGoodsId'];
                    label = comment['goodsName'];
                    html +=
                            "<p id='ch_"
                                    + id
                                    + "'><span style='font-weight: normal;'><a href='javascript:void(0);' onclick=\"delItem('ch_',"
                                    + id + ")\">×</a>";
                    html += label + "</span><input type='hidden' name='saleGoodsId' value='" + id + "'/></p>";
                });
                $("#goodsList").append(html);
                $("#gd_rad_part").attr("checked","checked");
                
                $("#addGdsBtn").attr("disabled", false);
                $("#addGdsBtn").attr("class", "button5");
            }else{
            	$("#gd_rad_all").attr("checked","checked");
            }
        },
        error:function(data){
        	$.dialog.alert('系统错误！');
        	return;
        }
    });
});

// 清空渠道列表和销售商品列表
function clean() {
    $("#channelList").empty();
    $("#goodsList").empty();
}

// 地市选择
function chooseLast(pid, flag) {
    var len = $('input[pid="' + pid + '"]:checked').length;
    if (flag) {
        $("#" + pid).attr("checked", true);
    }
    else if (len == 0) {
        $("#" + pid).attr("checked", false);
    }
}
function chooseHead(code, flag) {
    $("input[pid='" + code + "']").attr("checked", flag);
}
var type = "";
function operWin(title, operType) {
    if (operType == "goods") {
        var sku = $("#sku").val();
        if (! sku) {
        	$.dialog.alert('此库存的sku为空 ！');
            return;
        }
    }
    var mallCodeAry = [];
    $('input[name="mallCode"]').each(function() {
        mallCodeAry.push($(this).val());
    });
    if (mallCodeAry.length == 0) {
        $.dialog.alert('请选择您需要的商城！');
        return;
    }
    var channelAry = [];
    $('input[name="channelId"]').each(function() {
        channelAry.push($(this).val());
    });
    var goodsAry = [];
    $('input[name="saleGoodsId"]').each(function() {
        goodsAry.push($(this).val());
    });
    var mallCodes = mallCodeAry.join(",");
    var channels = channelAry.join(",");
    var goodses = goodsAry.join(",");
    var params = "?operType=" + operType;
    type = operType;
    params += "&mallCodes=" + mallCodes;
    params += "&channels=" + channels;
    params += "&goodses=" + goodses;
    params += "&sku=" + $("#sku").val();
    var url = "url:inventory/selectWin.do" + params;
    if (operType == 'channel') {
        params += "&module=inventory";
        url = "url:channelSelection/gotoChannelListPage.do" + params;// 渠道选择公共组件
    }
   
    $.dialog({
        title : title,
        min : false,
        max : false,
        zIndex : 2000,
        lock : true,
        drag : false,
        resize : false,
        content : url
    });
}
var channelItems = {};
// 渠道选择对话框对应的回调函数(跨页全选)
function selectAllChannelByParams(params) {
    $.ajax({
        type : 'POST',
        url : 'channelSelection/listChannels.do',
        data : params,
        datatype : 'json',
        timeout : 60000,
        async : false,
        success : function(result) {
            var html = "";
            var id = 0;
            var label = "";
            for (var i = 0; i < result.total; i++) {
                id = result.rows[i].channelId;
                label = result.rows[i].channelName;
                if (channelItems[id]) {
                    continue;
                }
                else {
                    channelItems[id] = 1;
                }
                html +=
                        "<p id='ch_"
                                + id
                                + "'><span style='font-weight: normal;'><a href='javascript:void(0);' onclick=\"delItem('ch_',"
                                + id + ")\">×</a>";
                html += label + "</span><input type='hidden' name='channelId' value='" + id + "'/></p>";
                $("#channelList").append(html);
                html = "";
            }
        }
    }
    );
}
// 渠道选择对话框对应的回调函数(非跨页全选)
function selectChannelBySelections(channelSelections) {

    var html = "";
    var id = 0;
    var label = "";
    for (var i = 0; i < channelSelections.length; i++) {
        id = channelSelections[i].channelId;
        label = channelSelections[i].channelName;
        if ($("#stockSpaceType").val() == $("#WCS_TRADE_STOCK_SPACE").val() && type == 'tradeStock') {
            html +=
                    "<p id='ts_"
                            + id
                            + "'><span style='font-weight: normal;'><a href='javascript:void(0);' onclick=\"delItem('ts_',"
                            + id + ")\">×</a>";
            html += label + "</span><input type='hidden' name='tradeStockId' value='" + id + "'/></p>";
            $("#tradeStock").append(html);
        }
        else {
            if (channelItems[id]) {
                continue;
            }
            else {
                channelItems[id] = 1;
            }
            html +=
                    "<p id='ch_"
                            + id
                            + "'><span style='font-weight: normal;'><a href='javascript:void(0);' onclick=\"delItem('ch_',"
                            + id + ")\">×</a>";
            html += label + "</span><input type='hidden' name='channelId' value='" + id + "'/></p>";
            $("#channelList").append(html);
        }
        html = "";
    }
}
function delItem(pre, id) {
    $("#" + pre + id).remove();
    // 同时移除channelItems数组中的元素
    var tempArr = {};
    for (var p in channelItems) {
        if (p != id) {
            tempArr[id] = 1;
        }
    }
    channelItems = tempArr;
}

function changeBtnStaus(mark, btnId) {
    if (mark == "all") {
        $("#" + btnId).attr("disabled", true);
        $("#" + btnId).attr("class", "disable");
    }else {
        $("#" + btnId).attr("disabled", false);
        $("#" + btnId).attr("class", "button5");
    }
    if (btnId == "addChanBtn") {
        $("#channelList").empty();
    }
    else {
        $("#goodsList").empty();
    }
}

function clearGoodses() {
    $("#goodsList").empty();
}

/**修改销售仓位信息*/
function updateStock(){
	var stockSpaceId=$("#stockSpaceId").val();
	var stockSpaceType=$("#stockSpaceType").val();
	
	var mallCodeAry = [];
    $('input[name="mallCode"]').each(function() {
        mallCodeAry.push($(this).val());
    });
	var channelAry = [];
    $('input[name="channelId"]').each(function() {
        channelAry.push($(this).val());
    });
    var goodsAry = [];
    $('input[name="saleGoodsId"]').each(function() {
        goodsAry.push($(this).val());
    });
    var channels = channelAry.join(",");
    var goodses = goodsAry.join(",");
    var mallCodes = mallCodeAry.join(",");
	$.ajax({
		type : 'POST',
        url : 'inventory/updateStockSpace.do',
        data : {stockSpaceId:stockSpaceId,stockSpaceType:stockSpaceType,channels:channels,goodses:goodses,mallCodes:mallCodes},
        datatype : 'json',
        success : function(data) {
        	if(data.flag==true){
        		location.href="inventory/showInventory.do";
        	}else{
        		$.dialog.alert(data.msg);
        		return;
        	}
        },
        error:function(data){
        	$.dialog.alert('系统错误！');
        	return;
        }
	});
}
