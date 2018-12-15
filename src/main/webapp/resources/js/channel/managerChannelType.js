$(document).ready(function() {
    $(".nav_epa").css("height", ($(window).height() - 50) + "px");
    $("#channelTypeTree").css("height", ($(window).height() - 50) + "px");
    getChannelTypeTree();
    $("#btn_save").click(function() {
        var lock = $.dialog({
            show : false
        }).lock();
        var channelTypeId = $("#channelTypeId").val();
        var channelTypeName = $("#channelTypeName").val();
        if (channelTypeName == null || channelTypeName == "") {
            $.dialog({
                title : '提示',
                content : "渠道类型名称不能为空！",
                cancelVal : '关闭',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        var parentTypeId = $("#parentTypeId").val();
        var channelTypeDesc = $("#channelTypeDesc").val();
        //var channelMark = $("#channelMark").val();
        $.ajax({
            type : 'POST',
            url : 'channelType/update.do',
            data : {
                channelTypeId : channelTypeId,
                channelTypeName : channelTypeName,
                parentTypeId : parentTypeId,
                channelTypeDesc : channelTypeDesc
                //channelMark : channelMark
            },
            datatype : 'json',
            success : function(msg) {
                if (msg.flag) {
                    getChannelTypeTree();
                }
                // 提示信息
                $.dialog({
                    title : '提示',
                    content : msg.msg,
                    cancelVal : '关闭',
                    cancel : function() {
                        lock.close();
                        return true;
                    }
                });
            }
        });
    });
    // 删除
    /*$("#btn_delete").click(function() {
    	var typesId=getAllByPTypeId($("#channelTypeId").val());
        $.dialog.confirm('该操作会导致其子渠道（渠道类型）级联删除，是否继续操作 ?', function() {
            $.ajax({
                type : 'POST',
                url : 'channelType/delete.do',
                data : {
                    channelTypeId : $("#channelTypeId").val(),
                    typesId : typesId
                },
                datatype : 'json',
                success : function(msg) {
                    if (msg.flag) {
                        getChannelTypeTree();
                    }
                    // 提示信息
                    $.dialog({
                        title : '提示',
                        content : msg.msg,
                        cancelVal : '关闭',
                        cancel : true
                    });
                }
            });
        });
    });
    // 恢复
    $("#btn_recover").click(function() {
        $.ajax({
            type : 'POST',
            url : 'channelType/recover.do',
            data : {
                channelTypeId : $("#channelTypeId").val()
            },
            datatype : 'json',
            success : function(msg) {
                if (msg.flag) {
                    getChannelTypeTree();
                }
                // 提示信息
                $.dialog({
                    title : '提示',
                    content : msg.msg,
                    cancelVal : '关闭',
                    cancel : true
                });
            }
        });
    });*/
});
function getChannelTypeTree() {
    $("#channelTypeDetail").hide();
    var setting = {
        view : {
            addHoverDom : addHoverDom,
            removeHoverDom : removeHoverDom,
            selectedMulti : false
        },
        data : {
            simpleData : {
                enable : true
            }
        },
        callback : {
            onClick : zTreeOnClick
        }
    };
    $.ajax({
        type : 'POST',
        url : 'channelType/getChannelTypeTree.do',
        datatype : 'json',
        success : function(result) {
            $.fn.zTree.init($("#channelTypeTree"), setting, result);
        }
    });
}
function addHoverDom(treeId, treeNode) {
    if (CHL_CHANNEL_TYPE_ADD) {
        if (treeNode.status != '0'||treeNode.pkId=='-1') {
            var sObj = $("#" + treeNode.tId + "_span");
            if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)
                return;
            var addStr =
                    "<span class='button add' id='addBtn_" + treeNode.tId
                            + "' title='添加渠道类型' onfocus='this.blur();'></span>";
            sObj.after(addStr);
            var btn = $("#addBtn_" + treeNode.tId);
            if (btn) {
                btn.bind("click", function() {
                    $("#channelTypeId").val("");
                    $("#channelTypeName").val("");
                    $("#parentTypeId").val(treeNode.pkId);
                    if(treeNode.pkId=='-1'){
                    	 $("#parentTypeName").val("").attr("disabled", "disabled").css({
                             "color" : "#636363",
                             "background" : "#EAEAEA"
                         });
                    }else{
                         $("#parentTypeName").val(treeNode.name).attr("disabled", "disabled").css({
                             "color" : "#636363",
                             "background" : "#EAEAEA"
                         });
                    }
                    $("#channelTypeDesc").val("");
                    //渠道标记选项增加内容
                    /*if(WCS_CHANNEL_MARK_MAP_JSON){
                    	var htmlText = "<option value=\"\">请选择</option>";
                    	for(var p in WCS_CHANNEL_MARK_MAP_JSON){
                    		htmlText += "<option value=\""+p+"\">"+WCS_CHANNEL_MARK_MAP_JSON[p]+"</option>";
                    	}
                    	$("#channelMark").html(htmlText);
                    }*/
                   /* $("#btn_delete").hide();
                    $("#btn_recover").hide();*/
                    $("#channelTypeDetail").show();
                    return false;
                });
            }
        }
    }
}
function removeHoverDom(treeId, treeNode) {
    $("#addBtn_" + treeNode.tId).unbind().remove();
}
function zTreeOnClick(event, treeId, treeNode) {
    if(treeNode.pkId!='-1'){
	/*$("#btn_delete").hide();
    $("#btn_recover").hide();*/
    $("#btn_save").hide();
    $.ajax({
        type : 'POST',
        url : 'channelType/getDetail.do',
        data : {
            channelTypeId : treeNode.pkId
        },
        datatype : 'text',
        success : function(result) {
            $("#channelTypeId").val(result.channelTypeId);
            $("#channelTypeName").val(result.channelTypeName);
            $("#parentTypeId").val(result.parentTypeId);
            $("#parentTypeName").val(result.parentTypeName).attr("disabled", "disabled").css({
                "color" : "#636363",
                "background" : "#EAEAEA"
            });
            $("#channelTypeDesc").val(result.channelTypeDesc);
            //渠道标记选项增加内容
            /*if(WCS_CHANNEL_MARK_MAP_JSON){
            	var htmlText = "<option value=\"\">请选择</option>";
            	for(var p in WCS_CHANNEL_MARK_MAP_JSON){
            		if(p == result.channelMark){
            			htmlText += "<option value=\""+p+"\" selected=\"selected\">"+WCS_CHANNEL_MARK_MAP_JSON[p]+"</option>";
            		}else{
            			htmlText += "<option value=\""+p+"\">"+WCS_CHANNEL_MARK_MAP_JSON[p]+"</option>";
            		}
            	}
            	$("#channelMark").html(htmlText);
            }*/
            // 控制禁用和恢复按钮显示
            if (result.status == "1") {
                $("#channelTypeName").removeAttr("disabled").css({
                    "color" : "#000000",
                    "background" : "#ffffff"
                });
                $("#channelTypeDesc").removeAttr("disabled", "disabled");
                /*if (CHL_CHANNEL_TYPE_DEL) {
                    $("#btn_delete").show();
                }*/
                if (CHL_CHANNEL_TYPE_ADD) {
                    $("#btn_save").show();
                }
            }
            else {
                $("#channelTypeName").attr("disabled", "disabled").css({
                    "color" : "#636363",
                    "background" : "#EAEAEA"
                });
                $("#channelTypeDesc").attr("disabled", "disabled");
                /*if (CHL_CHANNEL_TYPE_REC) {
                    $("#btn_recover").show();
                }*/
            }
            $("#channelTypeDetail").show();
        }
    });
    }
}

function getAllByPTypeId(id){
	var typeIds=[];
	typeIds.push(id);
	var treeObj = $.fn.zTree.getZTreeObj("channelTypeTree");
	var node = treeObj.getNodesByParam("pId", id, null);
	for(var i=0,len=node.length;i<len;i++){
		typeIds.push(getAllByPTypeId(node[i].id));
	}
	return typeIds.join(",");
}