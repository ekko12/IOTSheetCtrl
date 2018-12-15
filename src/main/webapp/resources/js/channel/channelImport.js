var param = {};
/**
 * 页面加载
 */
$(function() {
    // 商城全选
    $("#mallCodeAll").click(function() {
        if ("checked" == $("#mallCodeAll").attr("checked")) {// 全选
            $("input[name='mallCodes']").each(function() {
                $("input[name='mallCodes']").attr("checked", "checked");
            });
        }
        else {
            $("input[name='mallCodes']").each(function() {
                $("input[name='mallCodes']").removeAttr("checked");
            });
        }
    });
    // 支付方式全选
    $("#payModeAll").click(function() {
        if ("checked" == $("#payModeAll").attr("checked")) {// 全选
            $("input[name='payModes']").each(function() {
                $("input[name='payModes']").attr("checked", "checked");
            });
        }
        else {
            $("input[name='payModes']").each(function() {
                $("input[name='payModes']").removeAttr("checked");
            });
        }
    });    
}
);
/**
* 渠道数据新增/修改
*/
function submitForm() {
    var mallCodes = $('input[name="mallCodes"]:checked');
    if (mallCodes.length < 1) {
        showDialog('请选择可用商城', 'error', null);
        return false;
    }
    var deliveryModes = $('input[name="deliveryModes"]:checked');
    if (deliveryModes.length < 1) {
        showDialog('请选择提货方式', 'error', null);
        return false;
    }
    var payModes = $('input[name="payModes"]:checked');
    if (payModes.length < 1) {
        showDialog('请选择支付方式', 'error', null);
        return false;
    }
    var fileInput = $('input[name="channelFile"]').val();
    if(fileInput == ""){
    	showDialog('请选择导入文件', 'error', null);
        return false;
    }
        
    $('#channelForm').submit();
}

function back() {
    window.location.href = rootPath + '/channel/toChannel.do';
}

/**
 * 删除元素
 */
function delItem(pre, id) {
    $("#" + pre + id).remove();
    $("#developerSpan_" + id).remove();
}