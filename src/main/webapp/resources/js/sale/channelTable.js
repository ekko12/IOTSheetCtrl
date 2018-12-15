$(document).ready(function() {
    $('#channelTable').datagrid({
        url : 'sale/getChannelList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        queryParams : getQuery(),
        idField : 'channelId',
        columns : [[{
                    field : 'channelId',
                    checkbox : true
                }, {
                    field : 'channelName',
                    align : 'left',
                    width : 180,
                    title : '渠道名称'
                }, {
                    field : 'channelTypeName',
                    align : 'left',
                    width : 80,
                    title : '渠道类型'
                }, {
                    field : 'channelGradeTxt',
                    align : 'left',
                    width : 80,
                    title : '渠道级别'
                }]],
        onLoadSuccess : function(data) {
            $('#channelTable').datagrid('clearSelections');
        }
    });
    $("#btn_search").click(function() {
        $('#channelTable').datagrid('load', getQuery());
    });
    $.ajax({
        type : 'POST',
        url : 'channelType/getTreeList.do',
        datatype : 'text',
        async : false,
        success : function(result) {
            $.fn.zTree.init($("#channelTypeTree"), {
                check : {
                    enable : true,
                    chkStyle : "radio",
                    radioType : "all"
                },
                view : {
                    dblClickExpand : false
                },
                data : {
                    simpleData : {
                        enable : true
                    }
                },
                callback : {
                    onClick : onClick,
                    onCheck : onCheck
                }
            }, result);
        }
    });
    $("#channelType").click(function() {
        showMenu("channelType", "menuContent");
    });
});
function onClick(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("channelTypeTree");
    zTree.checkNode(treeNode, ! treeNode.checked, null, true);
    return false;
}
function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("channelTypeTree"), nodes = zTree.getCheckedNodes(true), v = "", id = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
        id += nodes[i].id + ",";
    }
    if (v.length > 0)
        v = v.substring(0, v.length - 1);
    if (id.length > 0)
        id = id.substring(0, id.length - 1);
    if (id == "-1") {
        $("#channelType").val("");
        $("#channelTypeId").val("");
    }
    else {
        $("#channelType").val(v);
        $("#channelTypeId").val(id);
    }
    hideMenu("channelType", "menuContent");
}
function showMenu(div1, div2) {
    $("#" + div2).css("left", $("#" + div1).offset().left - 20);
    $("#" + div2).slideDown("fast");
    $("body").bind("mousedown", function(event) {
        onBodyDown(div1, div2, event)
    });
}
function hideMenu(div1, div2) {
    $("#" + div2).fadeOut("fast");
    $("body").unbind("mousedown", function(event) {
        onBodyDown(div1, div2, event)
    });
}
function onBodyDown(div1, div2, event) {
    if (! (event.target.id == "menuBtn" || event.target.id == div1 || event.target.id == div2 || $(event.target)
            .parents("#" + div2).length > 0)) {
        hideMenu(div1, div2);
    }
}
function getQuery() {
    return {
        saleGoodsId : $("#saleGoodsId").val(),
        mallCode : $("#mallCode").val(),
        channelName : $("#channelName").val(),
        regionCode : $("#regionCode").val(),
        channelTypeId : $("#channelTypeId").val(),
        channelGrade : $("#channelGrade").val(),
        regionCodeIn : $("#regionCodeIn").val(),
        channelAccount : $("#channelAccount").val()
    };
}
var api = frameElement.api, W = api.opener;
api.button({
    name : '确定',
    callback : ok,
    focus : true
}, {
    name : '取消'
});
function ok() {
    var div_channelList = $(W.document.getElementById("div_channelList" + $("#id").val()));
    var chaneel = $(W.document.getElementsByName("channel" + $("#id").val()));
    if ($("#checkAll").is(":checked")) {
        $.ajax({
            type : 'POST',
            url : 'sale/getChannelList.do',
            data : {
                page : 0,
                rows : 0,
                saleGoodsId : $("#saleGoodsId").val(),
                mallCode : $("#mallCode").val(),
                channelName : $("#channelName").val(),
                regionCode : $("#regionCode").val(),
                channelTypeId : $("#channelTypeId").val(),
                channelGrade : $("#channelGrade").val(),
                regionCodeIn : $("#regionCodeIn").val(),
                channelAccount : $("#channelAccount").val()
            },
            datatype : 'json',
            async : false,
            success : function(result) {
                var html = "";
                for (var i = 0; i < result.total; i++) {
                    if (chaneel.length > 0) {
                        for (var i = 0; i < chaneel.length; i++) {
                            if (chaneel[i].value != result.rows[i].channelId) {
                                html +=
                                        '<p class="w_100"><label class="fl pd_l"><input name="channel' + $("#id").val()
                                                + '" checked="checked" type="checkbox" value="';
                                html +=
                                        result.rows[i].channelId + '" class="fl checkbox"><b class="fl w200">'
                                                + result.rows[i].channelName;
                                html +=
                                        '</b></label><span><a href="javascript:void(0);" onclick="delChannel(this)">×</a></span></p>';
                            }
                        }
                    }
                    else {
                        html +=
                                '<p class="w_100"><label class="fl pd_l"><input name="channel' + $("#id").val()
                                        + '" checked="checked" type="checkbox" value="';
                        html +=
                                result.rows[i].channelId + '" class="fl checkbox"><b class="fl w200">'
                                        + result.rows[i].channelName;
                        html +=
                                '</b></label><span><a href="javascript:void(0);" onclick="delChannel(this)">×</a></span></p>';
                    }
                }
                div_channelList.append(html);
            }
        }
        );
    }
    else {
        var rows = $('#channelTable').datagrid('getSelections');
        var html = "";
        for (var i = 0; i < rows.length; i++) {
            if (chaneel.length > 0) {
                for (var i = 0; i < chaneel.length; i++) {
                    if (chaneel[i].value != rows[i].channelId) {
                        html +=
                                '<p class="w_100"><label class="fl pd_l"><input name="channel' + $("#id").val()
                                        + '" checked="checked" type="checkbox" value="';
                        html += rows[i].channelId + '" class="fl checkbox"><b class="fl w200">' + rows[i].channelName;
                        html +=
                                '</b></label><span><a href="javascript:void(0);" onclick="delChannel(this)">×</a></span></p>';
                    }
                }
            }
            else {
                html +=
                        '<p class="w_100"><label class="fl pd_l"><input name="channel' + $("#id").val()
                                + '" checked="checked" type="checkbox" value="';
                html += rows[i].channelId + '" class="fl checkbox"><b class="fl w200">' + rows[i].channelName;
                html += '</b></label><span><a href="javascript:void(0);" onclick="delChannel(this)">×</a></span></p>';
            }
        }
        div_channelList.append(html);
    }
}