$(document).ready(function() {
	//初始语言品类
    getClassTree($("#languageName").val());
    
    $("#className").click(function() {
        showMenu("className", "menuContent");
    });
    
    $("#languageName").change(function(){
    	getClassTree($(this).val());
    });
});
function getClassTree(language){
	$("#className").val("");
    $("#classId").val("");
	$.ajax({
        type : 'POST',
        url : 'goodsClass/getTreeList.do',
        data:{language:language},
        datatype : 'text',
        async : false,
        success : function(result) {
            $.fn.zTree.init($("#classTree"), {
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
}
function onClick(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("classTree");
    zTree.checkNode(treeNode, ! treeNode.checked, null, true);
    return false;
}
function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("classTree"), nodes = zTree.getCheckedNodes(true), v = "", id = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
        id += nodes[i].id + ",";
    }
    if (v.length > 0)
        v = v.substring(0, v.length - 1);
    if (id.length > 0)
        id = id.substring(0, id.length - 1);
    if (id == "-1") {
        $("#className").val("");
        $("#classId").val("");
    }
    else {
        $("#className").val(v);
        $("#classId").val(id);
    }
    hideMenu("className", "menuContent");
}
function showMenu(div1, div2) {
    $("#" + div2).css("left", $("#" + div1).offset().left);
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
// 上架
function upShelfSaleGoods(saleGoodsId) {
   /* $.dialog({
        title : '批量上架',
        content : "url:sale/channelGoodsTable.do?saleGoodsId=" + saleGoodsId + "&status=u",
        lock : true
    })*/
    
    $.dialog.confirm('您确定上架此商品吗?', function() {
        $.ajax({
            type : 'POST',
            url : 'sale/batchOnShelf.do',
            data : {
                saleGoodsId : saleGoodsId
            },
            datatype : 'json',
            success : function(msg) {
                if (msg.flag) {
                    queryData();
                }
                $.dialog.alert(msg.msg);
            }
        });
    });
}
// 下架
function downShelfSaleGoods(saleGoodsId) {
    /*$.dialog({
        title : 'Batch off-shelf',
        content : "url:sale/channelGoodsTable.do?saleGoodsId=" + saleGoodsId + "&status=d",
        lock : true
    })*/
	$.dialog.confirm('是否下架当前销售商品对应的全部渠道销售商品?', function() {
        $.ajax({
            type : 'POST',
            url : 'sale/batchOffShelf.do',
            data : {
                saleGoodsId : saleGoodsId
            },
            datatype : 'json',
            success : function(msg) {
                if (msg.flag) {
                    queryData();
                }
                $.dialog.alert(msg.msg);
            }
        });
    });
}
// 恢复
function recover(saleGoodsId) {
    $.dialog.confirm('确认恢复商品信息?', function() {
        $.ajax({
            type : 'POST',
            url : 'sale/recover.do',
            data : {
                saleGoodsId : saleGoodsId
            },
            datatype : 'json',
            success : function(msg) {
                if (msg.flag) {
                    $('#saleGoodsDG').datagrid('load', {
                        status : $('#status').val(),
                        goodsName : $('#goodsName').val(),
                        productType : $('#productType').val()
                    });
                }
                $.dialog.alert(msg.msg);
            }
        });
    });
}
// 审核
function checkGoods(saleGoodsId) {
    $.dialog.confirm('确定审核销售商品吗?审核通过请点确定,不通过点击取消,放弃审核请点右上角叉关闭!', function() {
        var paramData = "saleGoodsId=" + saleGoodsId + "&checkResult=1";
        $.ajax({
            type : 'POST',
            url : 'sale/checkSaleGoods.do',
            data : paramData,
            dataType : 'json',
            success : function(result) {
                $.dialog.alert(result.msg);
                queryData();
            }
        });
    }, function() {
        var paramData = "saleGoodsId=" + saleGoodsId + "&checkResult=0";
        $.ajax({
            type : 'POST',
            url : 'sale/checkSaleGoods.do',
            data : paramData,
            dataType : 'json',
            success : function(result) {
                $.dialog.alert(result.msg);
                queryData();
            }
        });
    });
}
// 详情
function goodsDetail(saleGoodsId) {
    window.location.href = rootPath + "/sale/visitSaleGoodsDetail.do?saleGoodsId=" + saleGoodsId;
}