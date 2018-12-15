$(document).ready(function() {
    var btnUp = function(channelGoodsId) {
        return '<a href="javascript:void(0);" onclick="updateByUp('
                + channelGoodsId
                + ');" class="operButton" title="上架"><img src="resources/easyui13/themes/gray/images/button/btn_grounding.gif" alt="On-shelf"/></a>';
    }
    var btnDow = function(channelGoodsId) {
        return '<a href="javascript:void(0);" onclick="updateByDown('
                + channelGoodsId
                + ');" class="operButton" title="下架"><img src="resources/easyui13/themes/gray/images/button/btn_undercarriage.gif" alt="Off-shelf"/></a>';
    }
    var btnDet = function(channelGoodsId) {
        return '<a href="javascript:void(0);" onclick="detail('
                + channelGoodsId
                + ');" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="Details"/></a>';
    }
    var btnRec = function(channelGoodsId) {
        return '<a href="javascript:void(0);" onclick="recover('
                + channelGoodsId
                + ');" class="operButton" title="恢复"><img src="resources/easyui13/themes/gray/images/button/btn_renew.gif" alt="Recovery"/></a>';
    }
    var btnUpd = function(channelGoodsId) {
        return '<a href="javascript:void(0);" onclick="editGoods('
                + channelGoodsId
                + ');" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="Edit"/></a>';
    }
    var btnDel = function(channelGoodsId) {
        return '<a href="javascript:void(0);" onclick="deleteGoods('
                + channelGoodsId
                + ');" class="operButton" title="停售"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="Stop sales"/></a>';
    }
    $('#goodsTable').datagrid({
        url : 'saleChannel/getList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'channelGoodsId',
        columns : [[{
                    field : 'channelGoodsId',
                    checkbox : false,
            		hidden:true
                }, {
                    field : 'channelGoodsIdClone',
                    align : 'left',
                    width : 50,
                    title : '渠道销售商品ID'
                }, {
                    field : 'goodsName',
                    align : 'left',
                    width : 50,
                    title : '渠道销售商品名称'
                }, {
                	field : 'accessType',
                    align : 'left',
                    width : 50,
                    title : '接入方式',
                    formatter : function(value, rowData, rowIndex) {
                        return getAccessType(value);
                    }
                }, {
                	field : 'salePrice',
                    align : 'left',
                    width : 50,
                    title : '销售价格'
                }, {
                	field : 'onSaleTime',
                    align : 'left',
                    width : 50,
                    title : '创建时间',
                    formatter : function(value, rowData, rowIndex){
                        if(value){
                        	 return new Date(value).format('yyyy-MM-dd hh:mm:ss');
                        }else{
                          return "";
                        }
                    }
                }, {
                	field : 'mallName',
                    align : 'left',
                    width : 50,
                    title : '站点'
                }, {
                	field : 'channelName',
                    align : 'left',
                    width : 50,
                    title : '渠道名称'
                }, {
                    field : 'status',
                    align : 'left',
                    width : 50,
                    title : '渠道产品状态',
                    formatter : function(value, rowData, rowIndex) {
                        return getGoodsStatus(value);
                    }
                },
                // {
                // field : 'status1',
                // align : 'left',
                // width : 50,
                // title : '库存'
                // },
                {
                    field : 'control',
                    align : 'center',
                    width : 50,
                    title : '操作',
                    formatter : function(value, rowData, rowIndex) {
                        var array = [];
                        if(SAL_CHANNEL_GOODS_QUERY){
                        	array.push(btnDet(rowData.channelGoodsId));
                        }
                        
                        if(false){//屏蔽
                        // 待上架(删除、详情、上架)
                        if ($("#WCS_WAITING_UP").val() == rowData.status /*&& rowData.dataControlEnable*/) {
//                            array.push(btnDet(rowData.channelGoodsId));
                            // if ($("#WCS_YES").val() == rowData.isModify) {
                            if (SAL_CHANNEL_GOODS_UPD) {
                                array.push(btnUpd(rowData.channelGoodsId));
                            }
                            // }
                            if (SAL_CHANNEL_GOODS_UP) {
                                array.push(btnUp(rowData.channelGoodsId));
                            }
                            // if (SAL_CHANNEL_GOODS_DEL) {
                            // array.push(btnDel(rowData.channelGoodsId));
                            // }
                        }
                        // 已上架(详情、下架)
                        else if ($("#WCS_READY_UP").val() == rowData.status /*&& rowData.dataControlEnable*/) {
//                            array.push(btnDet(rowData.channelGoodsId));
                            if (SAL_CHANNEL_GOODS_DOW) {
                                array.push(btnDow(rowData.channelGoodsId));
                            }
                            if (SAL_CHANNEL_GOODS_UPD) {
                                array.push(btnUpd(rowData.channelGoodsId));
                            }
                        }
                        // 已归档、停售(详情)
                        else {
//                            array.push(btnDet(rowData.channelGoodsId));
                        }
                        }
                        return array.join('');
                    }
                }]],
        onLoadSuccess : function(data) {
            $('#goodsTable').datagrid('clearSelections');
        }
    });
    $("#btn_search").click(function() {
        queryData();
    });
    $("#goodsName,#channelAccount,#saleGoodsId").keyup(function(e) {
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which;
        if (code == 13) {
            queryData();
        }
    });
    // 批量上架
    $("#updateByUp").click(function() {
        var rows = $("#goodsTable").datagrid("getSelections");
        var index = [];
        for (var i = 0; i < rows.length; i++) {
            if (rows[i].status == $("#WCS_WAITING_UP").val()) {
                index.push(rows[i].channelGoodsId);
            }
        }
        $("#goodsTable").datagrid("unselectAll");
        for (var a = 0; a < index.length; a++) {
            $('#goodsTable').datagrid('selectRecord', index[a]);
        }
        rows = $("#goodsTable").datagrid("getSelections");
        var channelGoodsId = "";
        for (var i = 0; i < rows.length; i++) {
            channelGoodsId += rows[i].channelGoodsId
            if (i < (rows.length - 1)) {
                channelGoodsId += "#";
            }
        }
        if (channelGoodsId == "") {
            $.dialog.alert("Please select the channel sales product you want to put on-shelf!");
            return false;
        }
        updateByUp(channelGoodsId);
    });
    // 批量下架
    $("#updateByDown").click(function() {
        var rows = $("#goodsTable").datagrid("getSelections");
        var index = [];
        for (var i = 0; i < rows.length; i++) {
            if (rows[i].status == $("#WCS_READY_UP").val()) {
                index.push(rows[i].channelGoodsId);
            }
        }
        $("#goodsTable").datagrid("unselectAll");
        for (var a = 0; a < index.length; a++) {
            $('#goodsTable').datagrid('selectRecord', index[a]);
        }
        rows = $("#goodsTable").datagrid("getSelections");
        var channelGoodsId = "";
        for (var i = 0; i < rows.length; i++) {
            channelGoodsId += rows[i].channelGoodsId
            if (i < (rows.length - 1)) {
                channelGoodsId += "#";
            }
        }
        if (channelGoodsId == "") {
            $.dialog.alert("Please select the channel sales product you want to put off-shelf!");
            return false;
        }
        updateByDown(channelGoodsId);
    });
    
	//初始语言品类
    getClassTree($("#languageName").val());
    
    $("#className").click(function() {
        showMenu("className", "menuContent");
    });
    
    $("#languageName").change(function(){
    	getClassTree($(this).val());
    });
}
);
function getClassTree(language){
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
function queryData() {
	var languageName = $.trim($("#languageName").val());
	var channelGoodsId = $.trim($("#channelGoodsId").val());
	var goodsName = $.trim($("#goodsName").val());
	var classId = $.trim($("#classId").val());
	var mallCode = $.trim($("#mallCode").val());
	var channelName = $.trim($("#channelName").val());
    var accessTypeId = $.trim($("#accessTypeId").val());
    var startPrice = $.trim($("#startPrice").val());
    var endPrice = $.trim($("#endPrice").val());
    var status = $.trim($("#status").val());
    
    if (! accessTypeId && ! goodsName && ! status && ! startPrice && ! endPrice && ! channelGoodsId && ! mallCode
            && ! classId && ! languageName && !channelName) {
        $.dialog({
            title : '提示',
            content : 'Please select at least one condition to query!',
            cancelVal : 'Close',
            cancel : function() {
                return true;
            }
        });
        return false;
    }
    //校验价格输入合法性
    if(startPrice){
    	if(!chkPrice(startPrice)){
    		$("#startPrice").focus();
    		return false;
    	}
    }
    if(endPrice){
    	if(!chkPrice(endPrice)){
    		$("#endPrice").focus();
    		return false;
    	}
    }
    var options = $('#goodsTable').datagrid('options');
    options.url = 'saleChannel/getList.do';
    options.queryParams = {
    	languageName : languageName,
    	channelGoodsId : channelGoodsId,
    	goodsName : goodsName,
    	classId : classId,
    	mallCode : mallCode,
    	channelName : channelName,
        accessTypeId : accessTypeId,
        startPrice : startPrice,
        endPrice : endPrice,
        status : status
    };
    $("#goodsTable").datagrid('reload');
}
// 设置接入方式
function getAccessType(accessType) {
    var accessTypeJson = $.parseJSON($("#accessTypeJson").val());
    var accessTypeName = "";
    for (var t in accessTypeJson) {
        if (accessType == t) {
            accessTypeName = accessTypeJson[t];
            break;
        }
    }
    return accessTypeName;
}
// 设置商品状态
function getGoodsStatus(goodsStatus) {
    var goodsStatusJson = $.parseJSON($("#goodsStatusJson").val());
    var goodsStatusName = "";
    for (var t in goodsStatusJson) {
        if (goodsStatus == t) {
            goodsStatusName = goodsStatusJson[t];
            break;
        }
    }
    return goodsStatusName;
}
// 删除
function deleteGoods(channelGoodsId) {
    $.dialog.confirm('Whether to stop sales this channel product?', function() {
        $.ajax({
            type : 'POST',
            url : 'saleChannel/deleteGoods.do',
            data : {
                channelGoodsId : channelGoodsId
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
function updateByDown(channelGoodsId) {
    $.dialog.confirm('Whether to put this channle sales product off-shelf?', function() {
        $.ajax({
            type : 'POST',
            url : 'saleChannel/updateByDown.do',
            data : {
                channelGoodsId : channelGoodsId
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
// 上架
function updateByUp(channelGoodsId) {
    $.dialog.confirm('Whether to put this channle sales product on-shelf?', function() {
        $.ajax({
            type : 'POST',
            url : 'saleChannel/updateByUp.do',
            data : {
                channelGoodsId : channelGoodsId
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
function recover(channelGoodsId) {
    $.dialog.confirm('Whether to recovery the channal sales product information?', function() {
        $.ajax({
            type : 'POST',
            url : 'saleChannel/recover.do',
            data : {
                channelGoodsId : channelGoodsId
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
// 修改
function editGoods(channelGoodsId) {
    // window.open("saleChannel/visitChannelGoodsEdit.do?channelGoodsId=" + channelGoodsId, "editChannelGoods");
    window.location.href = rootPath + "/saleChannel/visitChannelGoodsEdit.do?channelGoodsId=" + channelGoodsId;
}
// 详情
function detail(channelGoodsId) {
    // window.open("saleChannel/visitChannelGoodsEdit.do?channelGoodsId=" + channelGoodsId, "editChannelGoods");
    window.location.href = rootPath + "/saleChannel/visitChannelGoodsDetail.do?channelGoodsId=" + channelGoodsId + "&languageName=" + $("#languageName").val();
}

//实时判断价格
function chkPrice(obj) {
    //判断商品价格
    var reg = /(^[-+]?[1-9]\d*(\.\d{1,2})?$)|(^[-+]?[0]{1}(\.\d{1,2})?$)/;
    if (!reg.test(obj)) {
		alert("Sales price should be a positive number!");
		return false;
	} else {
		return true;
	}
}
