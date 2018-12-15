var accessType;// 接入方式
$(document).ready(function() {
    $("a[id^='btn_selectChannel']").click(function() {
    	accessType = $(this).attr("data");
    	var licensingIdValue = $("#licensingId" + accessType).val();
    	licensingIdValue = (!licensingIdValue ? "" : licensingIdValue);
        // sale/channelTable.do
        $.dialog({
            title : '选择渠道	',
            content : "url:channelSelection/gotoChannelListPage.do?module=" + module + "&mallCode="
                    + $("#mallCode" + accessType).val() + "&licensingId="+ licensingIdValue +"&saleGoodsId="
                    + $("#saleGoodsId" + accessType).val() + "&regionCodeIn=" + $("#regionCode" + accessType).val()
                    + "&channelMark=" + $("#channelMark" + accessType).val()
        })
    }
    );
    $("#btn_save").click(function() {
        var lock = $.dialog({
            show : false
        }).lock();
        var access = $("#access").val();
        var accessList = access.split(",");
        var flag = true;
        for (var i = 0; i < accessList.length; i++) {
            if ($("#wcsContractPlan" + accessList[i]).val()) {
                // if ($("input[name='labels" + accessList[i] + "']:checked").length == 0) {
                // $.messager.alert('Prompt', $("#" + accessList[i]).val() + '版，请选择标签！', 'info');
                // flag = false;
                // return false;
                // }
                /**if ($("input[name='payModes" + accessList[i] + "']:checked").length == 0) {
                    flag = false;
                    $.dialog({
                        title : 'Prompt',
                        content : $("#" + accessList[i]).val() + 'version, please select the payment method!',
                        cancelVal : 'Close',
                        cancel : function() {
                            lock.close();
                            return true;
                        }
                    });
                    return false;
                }
                if ($("input[name='deliverys" + accessList[i] + "']:checked").length == 0) {
                    flag = false;
                    $.dialog({
                        title : 'Prompt',
                        content : $("#" + accessList[i]).val() + 'version, please select the shipping methods!',
                        cancelVal : 'Close',
                        cancel : function() {
                            lock.close();
                            return true;
                        }
                    });
                    return false;
                }*/
            }
            
            //如果商城为vip商城,则判断订单处理单位与订单取消时间是否正确
            /*if(currentMallCode == vipMall){
            	if($("input[name=orderDisposeUnit" + accessList[i] + "]:checked").length == 0){
            		$.dialog({
	                    title : 'Prompt',
	                    content : $("#" + accessList[i]).val() + 'version, please select the order processing unit!',
	                    cancelVal : 'Close',
	                    cancel : function() {
	                        lock.close();
	                        return true;
	                    }
	                });
            		return false;
            	}
            	var orderFailIntervalValue = $("input[name=orderFailInterval" + accessList[i] + "]").val();
            	if(orderFailIntervalValue == ''){
            		$.dialog({
	                    title : 'Prompt',
	                    content : $("#" + accessList[i]).val() + 'version, order cancellations time can only be numbers, please fill in the order cancellation time!',
	                    cancelVal : 'Close',
	                    cancel : function() {
	                        lock.close();
	                        return true;
	                    }
	                });
            		return false;
            	}else{
            		if(isNaN(orderFailIntervalValue) || orderFailIntervalValue.indexOf(' ') != -1 || orderFailIntervalValue.indexOf('.') != -1){
            			$.dialog({
    	                    title : 'Prompt',
    	                    content : $("#" + accessList[i]).val() + 'version, order cancellations time can only be numbers, please fill in the order cancellation time!',
    	                    cancelVal : 'Close',
    	                    cancel : function() {
    	                        lock.close();
    	                        return true;
    	                    }
    	                });
            			return false;
            		}else{
            			var orderFailIntervalIntValue = parseInt(orderFailIntervalValue);
            			if(orderFailIntervalIntValue < 1){
            				$.dialog({
        	                    title : 'Prompt',
        	                    content : $("#" + accessList[i]).val() + 'version, order cancellation time can only be a positive integer, please fill in the correct order cancellation time!',
        	                    cancelVal : 'Close',
        	                    cancel : function() {
        	                        lock.close();
        	                        return true;
        	                    }
        	                });
            				return false;
            			}
            		}
            	}
            }else{*/
	            if ($("input[name='channel" + accessList[i] + "']:checked").length == 0) {
	                flag = false;
	                $.dialog({
	                    title : '提示',
	                    content : $("#" + accessList[i]).val() + 'version, please select channel!',
	                    cancelVal : '关闭',
	                    cancel : function() {
	                        lock.close();
	                        return true;
	                    }
	                });
	                return false;
	            }
            /*}*/
            /**var upDelayTime = $("#upDelayTime" + accessList[i] + "").val();
            var upSetting = $("input[name='upSetting" + accessList[i] + "']:checked").val();
            if (upSetting == $("#WCS_TIMING_UP").val() && upDelayTime == "") {
                flag = false;
                $.dialog({
                    title : 'Prompt',
                    content : $("#" + accessList[i]).val() + 'version, please set the on-shelf time!',
                    cancelVal : 'Close',
                    cancel : function() {
                        lock.close();
                        return true;
                    }
                });
                return false;
            }
            if (upSetting == $("#WCS_TIMING_UP").val() && upDelayTime != "") {
                var myDate = new Date().format("yyyy-MM-dd hh:mm:ss");
                if (upDelayTime < myDate) {
                    flag = false;
                    $.dialog({
                        title : 'Prompt',
                        content : $("#" + accessList[i]).val() + 'version, the on-shelf time can not less than the current time!',
                        cancelVal : 'Close',
                        cancel : function() {
                            lock.close();
                            return true;
                        }
                    });
                    return false;
                }
            }
            var dwonSetting = $("input[name='dwonSetting" + accessList[i] + "']:checked").val();
            if (dwonSetting == null || dwonSetting == "") {
                flag = false;
                $.dialog({
                    title : 'Prompt',
                    content : $("#" + accessList[i]).val() + 'version, please select the off-shelf mode!',
                    cancelVal : 'Close',
                    cancel : function() {
                        lock.close();
                        return true;
                    }
                });
                return false;
            }
            var dwonDelayTime = $("#dwonDelayTime" + accessList[i] + "").val();
            if (dwonSetting == $("#WCS_TIMING_DOWN").val() && dwonDelayTime == "") {
                flag = false;
                $.dialog({
                    title : 'Prompt',
                    content : $("#" + accessList[i]).val() + 'version, please set the off-shelf time!',
                    cancelVal : 'Close',
                    cancel : function() {
                        lock.close();
                        return true;
                    }
                });
                return false;
            }
            if (dwonSetting == $("#WCS_TIMING_DOWN").val() && dwonDelayTime != "") {
                var myDate = new Date().format("yyyy-MM-dd hh:mm:ss");
                if (dwonDelayTime < myDate) {
                    flag = false;
                    $.dialog({
                        title : 'Prompt',
                        content : $("#" + accessList[i]).val() + 'version, the off-shelf time can not less than the current time!',
                        cancelVal : 'Close',
                        cancel : function() {
                            lock.close();
                            return true;
                        }
                    });
                    return false;
                }
            }*/
        }
        if (flag) {
            $("#sale_form").ajaxSubmit(function(msg) {
                if (msg.flag) {
                    $.dialog({
                        title : '提示',
                        content : msg.msg,
                        ok : function() {
                            window.location.href = rootPath + "/sale/visitSaleGoodsMainPage.do";
                            return true;
                        }
                    });
                }
            });
        }
        else {
            lock.close();
        }
    });
    $("#btn_cancel").click(function() {
        window.location.href = rootPath + "/sale/visitSaleGoodsMainPage.do";
    });
}
);
function delChannel(obj) {
    $(obj).parent().parent().remove();
}
// 渠道选择对话框对应的回调函数(跨页全选)
function selectAllChannelByParams(params) {
    var chaneel = $(document.getElementsByName("channel" + accessType));
    $.ajax({
        type : 'POST',
        url : 'channelSelection/listChannels.do',
        data : params,
        datatype : 'json',
        timeout : 60000,
        async : false,
        success : function(result) {
            var html = "";
            for (var i = 0; i < result.total; i++) {
                if (chaneel.length > 0) {
                    var existChannel = false;
                    for (var j = 0; j < chaneel.length; j++) {
                        if (result.rows[i].channelId == chaneel[j].value) {
                            existChannel = true;
                            break;
                        }
                    }
                    if (! existChannel) {
                        html +=
                                '<p class="w_100"><label class="fl pd_l"><input name="channel' + accessType
                                        + '" checked="checked" type="checkbox" value="';
                        html +=
                                result.rows[i].channelId + '" class="fl checkbox"><b class="fl w200">'
                                        + result.rows[i].channelName;
                        html +=
                                '</b></label><span><a href="javascript:void(0);" onclick="delChannel(this)">×</a></span></p>';
                    }
                }
                else {
                    html +=
                            '<p class="w_100"><label class="fl pd_l"><input name="channel' + accessType
                                    + '" checked="checked" type="checkbox" value="';
                    html +=
                            result.rows[i].channelId + '" class="fl checkbox"><b class="fl w200">'
                                    + result.rows[i].channelName;
                    html +=
                            '</b></label><span><a href="javascript:void(0);" onclick="delChannel(this)">×</a></span></p>';
                }
            }
            $("#div_channelList" + accessType).append(html);
        }
    }
    );
}
// 渠道选择对话框对应的回调函数(非跨页全选)
function selectChannelBySelections(channelSelections) {
    var chaneel = document.getElementsByName("channel" + accessType);
    var html = "";
    for (var i = 0; i < channelSelections.length; i++) {
        if (chaneel.length > 0) {
            var existChannel = false;
            for (var j = 0; j < chaneel.length; j++) {
                if (channelSelections[i].channelId == chaneel[j].value) {
                    existChannel = true;
                    break;
                }
            }
            if (! existChannel) {
                html +=
                        '<p class="w_100"><label class="fl pd_l"><input name="channel' + accessType
                                + '" checked="checked" type="checkbox" value="';
                html +=
                        channelSelections[i].channelId + '" class="fl checkbox"><b class="fl w200">'
                                + channelSelections[i].channelName;
                html += '</b></label><span><a href="javascript:void(0);" onclick="delChannel(this)">×</a></span></p>';
            }
        }
        else {
            html +=
                    '<p class="w_100"><label class="fl pd_l"><input name="channel' + accessType
                            + '" checked="checked" type="checkbox" value="';
            html +=
                    channelSelections[i].channelId + '" class="fl checkbox"><b class="fl w200">'
                            + channelSelections[i].channelName;
            html += '</b></label><span><a href="javascript:void(0);" onclick="delChannel(this)">×</a></span></p>';
        }
    }
    $("#div_channelList" + accessType).append(html);
}

//更改渠道协议选择时,清除已选择的渠道信息
function removeSelectedChannelAfterChangeLicensing(accessType){
	$("#div_channelList" + accessType).html("");
}