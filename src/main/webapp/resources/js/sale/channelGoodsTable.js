$(document).ready(function() {
    $('#channelGoodsTable').datagrid({
        url : 'sale/getChannelGoodsList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        queryParams : {
            saleGoodsId : $("#hid_saleGoodsId").val(),
            status : $("#hid_status").val()
        },
        idField : 'channelGoodsId',
        columns : [[{
                    field : 'channelGoodsId',
                    checkbox : true
                }, {
                    field : 'goodsName',
                    align : 'left',
                    width : 180,
                    title : '商品名称'
                }, {
                    field : 'mallName',
                    align : 'left',
                    width : 180,
                    title : '所属商城'
                }, {
                    field : 'channelName',
                    align : 'left',
                    width : 180,
                    title : '所属渠道'
                }, {
                    field : 'accessType',
                    align : 'left',
                    width : 180,
                    title : '接入方式',
                    formatter : function(value, rowData, rowIndex) {
                        return getAccessTypeNameByCode(value);
                    }
                }, {
                    field : 'salePrice',
                    align : 'left',
                    width : 180,
                    title : '价格'
                }]],
        onLoadSuccess : function(data) {
            $('#channelGoodsTable').datagrid('clearSelections');
        }
    });
});
var api = frameElement.api, W = api.opener;
api.button({
    name : '确定',
    callback : ok,
    focus : true
}, {
    name : '取消'
});
function ok() {
    var saleGoodsId = "";
    if ($("#checkAll").is(":checked")) {
        $.ajax({
            type : 'POST',
            url : 'sale/getChannelGoodsList.do',
            data : {
                page : 0,
                rows : 0,
                saleGoodsId : $("#hid_saleGoodsId").val(),
                status : $("#hid_status").val()
            },
            datatype : 'json',
            async : false,
            success : function(result) {
                for (var i = 0; i < result.total; i++) {
                    saleGoodsId += result.rows[i].channelGoodsId;
                    if (i < (result.total - 1)) {
                        saleGoodsId += "#";
                    }
                }
            }
        });
    }
    else {
        var rows = $('#channelGoodsTable').datagrid('getSelections');
        for (var i = 0; i < rows.length; i++) {
            saleGoodsId += rows[i].channelGoodsId;
            if (i < (rows.length - 1)) {
                saleGoodsId += "#";
            }
        }
    }
    var status = $("#hid_status").val();
    var info = "";
    var url = "";
    var mess = "";
    if (status == 'u') {
        info = "是否上架选择的渠道销售商品?";
        url = "saleChannel/updateByUp.do";
        mess = "请选择上架的渠道销售商品！";
    }
    else {
        info = "是否下架选择的渠道销售商品?";
        url = "saleChannel/updateByDown.do";
        mess = "请选择下架的渠道销售商品！";
    }
    if (saleGoodsId == null || saleGoodsId == "") {
        $.dialog({
            zIndex : 2000,
            title : '提示',
            content : mess,
            lock : true,
            ok : function() {
                return true;
            }
        });
        return false;
    }
    $.dialog({
        zIndex : 2000,
        title : '提示',
        content : info,
        lock : true,
        ok : function() {
            $.ajax({
                type : 'POST',
                url : url,
                data : {
                    channelGoodsId : saleGoodsId
                },
                datatype : 'json',
                async : false,
                success : function(msg) {
                    $.dialog({
                        zIndex : 2000,
                        title : '提示',
                        content : msg.msg,
                        lock : true,
                        ok : function() {
                            api.reload(W);
                            return true;
                        }
                    });
                    return true;
                }
            });
        },
        cancel : true
    });
    return false;
}
function getAccessTypeNameByCode(accessType) {
    var accessTypeJson = jQuery.parseJSON($("#WCS_ACCESS_TYPE_MAP_JSON").val());
    var accessTypeName = "";
    for (var t in accessTypeJson) {
        if (accessType == t) {
            accessTypeName = accessTypeJson[t];
            break;
        }
    }
    return accessTypeName;
}