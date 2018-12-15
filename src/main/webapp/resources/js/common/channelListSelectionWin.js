// var queryParams = getQueryParams();// 查询条件
$(document).ready(function() {
    // console.log("initload queryParams="+JSON.stringify(queryParams));
    // 初始化表格
    $('#channelTable').datagrid({
        // url : 'channelSelection/listChannels.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        singleSelect : (singleSelect == "1" ? true : false),
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        // queryParams : {
        // module : $("#module").val(),
        // mallCodes : $("#mallCodes").val(),
        // regionCodeIn : $("#regionCodeIn").val()
        // },
        idField : 'channelId',
        columns : [[{
                    field : 'channelId',
                    checkbox : true
                }, {
                    field : 'channelName',
                    align : 'left',
                    width : 180,
                    title : '渠道名称'
                }, /*{
                    field : 'channelGradeTxt',
                    align : 'left',
                    width : 80,
                    title : '渠道等级'
                }, {
                    field : 'regionName',
                    align : 'left',
                    width : 80,
                    title : '代理地市'
                },*/ {
                    field : 'channelTypeName',
                    align : 'left',
                    width : 80,
                    title : '渠道类型名称'
                }]],
        onLoadSuccess : function(data) {
            $('#channelTable').datagrid('clearSelections');
        }
    });
    // 查询按钮点击事件
    $("#btn_search").click(function() {
        // queryParams = getQueryParams();
        // $('#channelTable').datagrid('load', queryParams);
        getQuery();
    });
    // 加载渠道类型树
    $.ajax({
        type : 'POST',
        url : 'channelSelection/getTreeList.do',
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
    // 渠道类型文本框点击事件
    $("#channelType").click(function() {
        showMenu("channelType", "menuContent");
    });
    $("#channelAccounts").focus(function() {
        if ($("#channelAccounts").val() == defaultChannelAccountsText) {
            $("#channelAccounts").val("");
        }
    });
    $("#channelAccounts").blur(function() {
        if ($("#channelAccounts").val() == "") {
            $("#channelAccounts").val(defaultChannelAccountsText);
        }
    });
});
/**
 * 渠道树选择事件
 * @param e
 * @param treeId
 * @param treeNode
 * @return
 */
function onClick(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("channelTypeTree");
    zTree.checkNode(treeNode, ! treeNode.checked, null, true);
    return false;
}
/**
 * 渠道树选中
 * @param e
 * @param treeId
 * @param treeNode
 * @return
 */
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
/**
 * 显示相应元素
 * @param div1
 * @param div2
 * @return
 */
function showMenu(div1, div2) {
    $("#" + div2).css("left", $("#" + div1).offset().left - 20);
    $("#" + div2).slideDown("fast");
    $("body").bind("mousedown", function(event) {
        onBodyDown(div1, div2, event)
    });
}
/**
 * 隐藏相应元素
 * @param div1
 * @param div2
 * @return
 */
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
/**
 * 查询条件构造
 * (分别是商城、渠道类型、地市、查询方式、渠道等级、当前用户所在地市、渠道帐号(多个)、跨页全选)
 * @return
 */
function getQuery() {
	var channelName = $("#channelName").val();
    var module = $("#module").val();
    var licensingId = $("#licensingId").val();
    var mallCodes = $("#mallCodes").val();
    var channels=$("#channels").val();
    var channelTypeId = $("#channelTypeId").val();
    var regionCode = $("#regionCode").val();
    var queryMode = $("#queryMode").val();
    var channelGrade = $("#channelGrade").val();
    var channelMark = $("#channelMark").val();//下拉框所选的渠道标记
    var saleGoodsChannelMark = $("#saleGoodsChannelMark").val();//销售商品自身的渠道标记
    var regionCodeIn = $("#regionCodeIn").val();
    var channelAccounts = $("#channelAccounts").val() == defaultChannelAccountsText ? "" : $("#channelAccounts").val();
    //var channelNames = $("#channelNames").val() == defaultChannelNamesText ? "" : $("#channelNames").val();
    var checkAll = $("#checkAll").attr("checked");
    var mallCode = $("#mallCode").val();//销售商品发布所用的商城编码
    var saleGoodsId = $("#saleGoodsId").val();//销售商品发布所用的销售商品编号
    /*if (! channelTypeId && ! regionCode && ! channelGrade && ! channelAccounts && ! channelMark && ! channelName) {
        $.dialog({
            title : '提示',
            content : '请至少选择一个条件进行查询！',
            cancelVal : '关闭',
            zIndex : 9999,
            cancel : function() {
                return true;
            }
        });
        return false;
    }*/
    var options = $('#channelTable').datagrid('options');
    options.url = 'channelSelection/listChannels.do';
    options.queryParams = {
        module : module,
        mallCodes : mallCodes,
        channelTypeId : channelTypeId,
        regionCode : regionCode,
        queryMode : queryMode,
        channelGrade : channelGrade,
        channelMark : channelMark,
        saleGoodsChannelMark : saleGoodsChannelMark,
        regionCodeIn : regionCodeIn,
        channelAccounts : channelAccounts,
        checkAll : checkAll,
        mallCode : mallCode,
        licensingId : licensingId,
        saleGoodsId : saleGoodsId,
        channelName : channelName,
        channels:channels
    };
    $("#channelTable").datagrid('reload');
}
var api = frameElement.api, W = api.opener;
api.button({
    name : '确定',
    callback : confirmSelect,
    focus : true
}, {
    name : '取消'
});
/**
 * 选择确定后的回调函数处理(返回对象,交由所调用的页面处理)
 * @return
 */
function confirmSelect() {
	var module = $("#module").val();
    var licensingId = $("#licensingId").val();
    var mallCodes = $("#mallCodes").val();
    var channelName = $("#channelName").val();
    var channelTypeId = $("#channelTypeId").val();
    //var regionCode = $("#regionCode").val();
    var queryMode = $("#queryMode").val();
    //var channelGrade = $("#channelGrade").val();
    //var channelMark = $("#channelMark").val();//下拉框所选的渠道标记
    var saleGoodsChannelMark = $("#saleGoodsChannelMark").val();//销售商品自身的渠道标记
    var regionCodeIn = $("#regionCodeIn").val();
    var mallCode = $("#mallCode").val();//销售商品发布所用的商城编码
    var saleGoodsId = $("#saleGoodsId").val();//销售商品发布所用的销售商品编号
    var channelAccounts =
            $("#channelAccounts").val() == defaultChannelAccountsText ? "" : $("#channelAccounts").val();
	 var checkAll = $("#checkAll").attr("checked");
    // 1.判断是否选择跨页全选(存在跨页全选复选框并且选中)
    if ($("#checkAll").is(":checked")) {
        var queryParams = {
            module : module,
            mallCodes : mallCodes,
            mallCode : mallCode,
            licensingId : licensingId,
            channelTypeId : channelTypeId,
           // regionCode : regionCode,
            queryMode : queryMode,
           // channelGrade : channelGrade,
          //  channelMark : channelMark,
            saleGoodsChannelMark : saleGoodsChannelMark,
            regionCodeIn : regionCodeIn,
            channelAccounts : channelAccounts,
            checkAll : checkAll,
            saleGoodsId : saleGoodsId,
            channelName : channelName,
            page : 0,
            rows : 0
        };
        // console.log("confirmSelect queryParams="+JSON.stringify(queryParams));
        if (W && W.selectAllChannelByParams) {
            W.selectAllChannelByParams(queryParams);
        }
    }
    else {
    	
        // 2.非跨页全选时,得到所选的渠道对象,调用主动调用页面的函数，传递所选的渠道对象
        var rows = $('#channelTable').datagrid('getSelections');
        
        if (rows==null || rows=="") {
            $.dialog({
                title : '提示',
                content : 'Please select at least one condition to query！',
                cancelVal : '关闭',
                zIndex : 9999,
                cancel : function() {
                    return true;
                }
            });
            return false;
        }
        if (W && W.selectChannelBySelections) {
            W.selectChannelBySelections(rows);
        }
    }
}
/**
 * 选择确定后的回调函数处理(返回对象,交由所调用的页面处理)
 * @return
 */
function confirmSelectOld() {
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
                channelMark : $("#channelMark").val(),
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
//跨页全选：选中或全取消
function checkAll(){
	if(document.getElementById('checkAll').checked){
		$('#channelTable').datagrid('selectAll');
	}
	else{
		$('#channelTable').datagrid('clearSelections');
	}
}

//按回车查询
function getKey(event){
    if(event.keyCode==13){
    	stopDefault(event);
    	getQuery();
    }   
    
    function stopDefault(e) {  
        //如果提供了事件对象，则这是一个非IE浏览器   
        if(e && e.preventDefault) {  
        　　//阻止默认浏览器动作(W3C)  
        　　e.preventDefault();  
        } else {  
        　　//IE中阻止函数器默认动作的方式   
        　　window.event.returnValue = false;   
        }  
        return false;  
    }
    
}