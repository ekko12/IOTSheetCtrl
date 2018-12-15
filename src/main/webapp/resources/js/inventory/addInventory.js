$(document).ready(function() {
    var countriesArray = $.map($.parseJSON($("#hid_pmProducts").val()), function(value, key) {
        return {
            value : value,
            data : key
        };
    });
    $('#skuCodeAuto').autocomplete({
        lookup : countriesArray,
        onSelect : function(suggestion) {
            $('#sku').val(suggestion.data);
        },
        onHint : function(hint) {
            $('#skuCodeAuto-x').val(hint);
        },
        onInvalidateSelection : function() {
            $('#sku').val('');
        }
    });
    if (! $("#stockSpaceType").val()) {
        /*$("#physicsStockId").attr("disabled", "disabled").css({
            "background" : "#DCDCDC"
        });*/
        $("input[value='Inspection reserve positions']").attr("disabled", "disabled").addClass("disable");
    }
    $("#stockSpaceType").change(function() {
        if ($(this).val() == "" ) {
            /* $("#physicsStockId").val("").attr("disabled", "disabled").css({
                 "background" : "#DCDCDC"
             });*/
	       	
        	 $("#range_list").hide();
 	       	 $("#fenpeikucun").hide();
 	       	 $("#yuliukucun").hide();
 	       	
 	       	 $("#jiaoyanyuliu").show();
 	       	 $("#yingyongqudao").show();
 	       	 $("#tianjiaqudao").show();
 	       	 $("#shiyongshangpin").show();
 	       	 $("#tianjiashangpin").show();
	       	
        }else if($(this).val() ==$("#WCS_RESERVED_STOCK_SPACE").val()){//如果是预留仓位
        	
        	 $("#range_list").show();
        	 $("#fenpeikucun").show();
        	 $("#yuliukucun").show();
        	 
        	 $("#jiaoyanyuliu").hide();
    	     $("#yingyongqudao").hide();
    	     $("#tianjiaqudao").hide();
    	     $("#shiyongshangpin").hide();
    	     $("#tianjiashangpin").hide();
        	 
        	 $("#physicsStockId").removeAttr("disabled").css({
                 "background" : "#FFFFFF"
             });
        }else if($(this).val() ==$("#WCS_SALE_STOCK_SPACE").val()){//如果是销售仓位
           /* $("#physicsStockId").removeAttr("disabled").css({
                "background" : "#FFFFFF"
            });
            $("input[value='检验预留仓位']").removeAttr("disabled").removeClass("disable");
            $("#div_stockNum").hide();
            $("#div_tradeStock").hide();
            $("input[name='cha_rad'][value='all']").attr("checked", 'checked');
            changeBtnStaus('all', 'addChanBtn');
            $("input[name='cha_rad']").removeAttr("disabled");*/
            
            $("#range_list").show();
	       	$("#fenpeikucun").hide();
	       	$("#yuliukucun").hide();
	       	
	       	$("#jiaoyanyuliu").show();
	       	$("#yingyongqudao").show();
	       	$("#tianjiaqudao").show();
	       	$("#shiyongshangpin").show();
	       	$("#tianjiashangpin").show();
	       	
	       	$("#yuliucangwei").removeAttr("disabled").removeClass("disable");
	       	
	       	$("#physicsStockId").removeAttr("disabled").css({
                "background" : "#FFFFFF"
            });
        }
    }
    );
    if ($("#regionAll").is(":checked")) {
        $("#regionSpan").text("Unselect all");
    }
    $("#regionAll").change(function() {
        if ($(this).is(":checked")) {
            $("#regionSpan").text("Unselect all");
            $("#region_content :checkbox").attr("checked", 'checked');
        }
        else {
            $("#regionSpan").text("Select all");
            $("#region_content :checkbox").removeAttr("checked");
        }
    });
}
);
// 清空渠道列表和销售商品列表
function clean() {
    $("#channelList").empty();
    $("#goodsList").empty();
}
function showRegion(stockId, stockSpaceType) {
    var cityRgionJson = $.parseJSON($("#cityRgionJson").val());
    $("#range_list").hide();
    $("#region_content").empty();
    $.ajax({
        type : 'POST',
        url : 'inventory/showCity.do',
        data : 'stockId=' + stockId,
        datatype : 'json',
        success : function(data) {
            counter = [];
            if (data['regions']) {
                if (data['regions'].length > 0) {
                    $("#range_list").show();
                }
                var html="";
                $("#shoulidishi").html("");
                $.each(data['regions'], function(commentIndex, comment) {
                	html+="<label style=\"font-weight: normal;width:140px; float:left;\">";
                	html+="<input type=\"checkbox\" style=\"padding: 1px; border: 1px;\" class=\"checkbox\" disabled=\"disabled\" name=\"regionCity\" value=\""+comment['regionCode']+"\" checked=\"checked\"/>"+comment['regionName'];
                	if(((commentIndex+1)%5==0)){
                		html+="</br>";
                	}
                	html+="</label>";
                });
                $("#shoulidishi").append(html);
            }else{
            	$.dialog.alert('此仓库没有地市！');
                return false;
            }
            
            if(data['lang']!=null && data['lang']!=""){
            	$('#lang').val(data['lang']);
            }
            
            if(data.wsPhysicsStock!=null){
            	$("#inventoryAddr").attr("disabled", "disabled");
            	$("#inventoryAddr").val(data.wsPhysicsStock.inventoryAddr);
            }
        }
    });
    $("#salePhysicsStockId").html("<option value="+""+"></option>");
    checkStockSpace();
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
            $.dialog.alert('请选择一个SKU！', function() {
                $("#sku").focus();
            });
            return;
        }
    }
    var mallCodeAry = [];
    $('input[name="mallCode"]:checked').each(function() {
        mallCodeAry.push($(this).val());
    });
    if (mallCodeAry.length == 0) {
        $.dialog.alert('仓库的商城为空！');
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
    /*if (operType == 'tradeStock') {
        if ($("#stockSpaceType").val() == $("#WCS_TRADE_STOCK_SPACE").val()) {
            params += "&singleSelect=1";
        }
        params += "&module=inventory";
        url = "url:channelSelection/gotoChannelListPage.do" + params;// 渠道选择公共组件
    }*/
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
    }
    else {
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
function save(btn) {
    var stockSpaceName = $("#stockSpaceName").val();
    var sku = $("#sku").val();
    var stockSpaceType = $("#stockSpaceType").val();
    var physicsStockId = $("#physicsStockId").val();
    var salePhysicsStockId=$("#salePhysicsStockId").val();
    if (! stockSpaceName) {
        $.dialog.alert('仓位名称不能为空 ！');
        $("#stockSpaceName").focus();
        return false;
    }
    if (! sku) {
        $.dialog.alert('SKU 不能为空 ！');
        $("#sku").focus();
        return false;
    }
    if (! stockSpaceType) {
        $.dialog.alert('仓位类型不能为空！');
        $("#stockSpaceType").focus();
        return false;
    }
    if (! physicsStockId) {
        $.dialog.alert('物理仓位不能为空！');
        $("#physicsStockId").focus();
        return false;
    }
    var isChecked = false;
    $('input[name="mallCode"]:checked').each(function() {
        isChecked = true;
    });
    if (! isChecked) {
        $.dialog.alert('请选择您需要的站点！');
        return false;
    }
    if(stockSpaceType==$("#WCS_SALE_STOCK_SPACE").val()){//如果是添加销售仓
    	if (! salePhysicsStockId) {
            $.dialog.alert('预留仓位不能为空！');
            $("#salePhysicsStockId").focus();
            return false;
        }
    	
    	var chaRad = $("input[name='cha_rad']:checked").val();
	    if (chaRad == "part") {
	        if (! $("#channelList").is(':has(p)')) {
	            $.dialog.alert('请添加您需要的渠道！');
	            return false;
	        }
	    }
	    var gdRad = $("input[name='gd_rad']:checked").val();
	    if (gdRad == "part") {
	        if (! $("#goodsList").is(':has(span)')) {
	            $.dialog.alert('请添加您需要的商品！');
	            return false;
	        }
	    }
    }
   
    
    if (stockSpaceType == $("#WCS_RESERVED_STOCK_SPACE").val()) {//如果是添加预留仓
        var stockNum = $("#stockNum").val();
        if (! stockNum) {
            $.dialog.alert('仓位数量不能为空！');
            $("#stockNum").focus();
            return false;
        }
        if (! /^-?[1-9]\d*$/.test(stockNum)) {
            $.dialog.alert('库存只能为整数！');
            $("#stockNum").focus();
            return false;
        }
    }
    
    var len = $("input[name='regionCity']:checked").length;
    if (len < 1) {
        $.dialog.alert('请选择受理订单的范围！');
        return false;
    }
    
    var regionCityAry = [];
    $('input[name="regionCity"]:checked').each(function() {
    	regionCityAry.push($(this).val());
    });
    var d = $.dialog.tips('Data is saving...', 600, 'loading.gif');
    d.lock();
    $.ajax({
        type : 'POST',
        url : 'inventory/saveSaleStock.do',
        data : $('#stockForm').serialize()+"&regionCity="+regionCityAry,
        async : false,
        datatype : 'json',
        success : function(data) {
            d.close();
            if (data.flag==true) {
            	$.dialog.alert(data.msg);
                window.location.href = rootPath + "/inventory/showInventory.do";
            }else{
            	$.dialog.alert(data.msg);
            	return false;
            }
        },
        error : function(data) {
            d.close();
            $.dialog.alert("保存失败！");
        }
    });
}
function clearGoodses() {
    $("#goodsList").empty();
}
function checkUnicity(stockSpaceName) {
    if (stockSpaceName.length == 0) {
        return;
    }
    $.ajax({
        type : 'POST',
        url : 'inventory/checkUnicity.do',
        data : "stockSpaceName=" + stockSpaceName,
        datatype : 'json',
        success : function(data) {
            if (data) {
                $.dialog.alert("仓位名称已存在，请重新输入！");
                $("#stockSpaceName").focus();
            }
        }
    });
}
/**
 * 检查预留仓位
 */
function checkStockSpace() {
	var stockSpaceType=$("#stockSpaceType").val();
	if(stockSpaceType=="2" || stockSpaceType==2){
		var sku = $("#sku").val();
	    var physicsStockId = $("#physicsStockId").val();
	    if (! sku) {
	        $.dialog.alert("SKU不能为空 ！");
	        $("#sku").focus();
	        return;
	    }
	    if (! physicsStockId) {
	        $.dialog.alert("物理仓位不能为空！");
	        $("#physicsStockId").focus();
	        return;
	    }
	    var mallCodeAry = [];
	    $('input[name="mallCode"]:checked').each(function() {
	        mallCodeAry.push($(this).val());
	    });
	    if (mallCodeAry.length == 0) {
	        $.dialog.alert("请选择您需要的商城！");
	        return;
	    }
	    var params = "physicsStockId=" + physicsStockId + "&skuCode=" + sku;
	    params += "&mallCode=" + mallCodeAry.join("&mallCode=");
	    $.ajax({
	        type : 'POST',
	        url : 'inventory/checkStockSpace.do',
	        data : params,
	        datatype : 'json',
	        success : function(data) {
	        	if(data!=null){
	        		if(data.stockSpace!=null && data.stockSpace!=""){
	        			var html=""
	    				for(var i=0;i<data.stockSpace.length;i++){
	    					html+="<option value="+data.stockSpace[i].stockSpaceId+">"+data.stockSpace[i].stockSpaceName+"</option>";
	    				}
	        			$("#salePhysicsStockId").html(html);
	        		}else{
	        			$("#salePhysicsStockId").html("<option value="+""+"></option>");
	        			$.dialog.alert(data.isNo);
	        		}
	        	}else{
	        		$("#salePhysicsStockId").html("<option value="+""+"></option>");
	        		$.dialog.alert("没有预留仓位！");
	        	}
	        },
	        error:function(){
	        	$.dialog.alert('后台错误！');
	        }
	    });
	}
}
