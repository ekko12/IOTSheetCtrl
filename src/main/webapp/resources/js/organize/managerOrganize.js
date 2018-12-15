$(document).ready(function() {
    getOrganizeTree();
   
    $("#btn_search").click(function() {
        queryData();
    });
    $("#orgName,#orgCode").keyup(function(e) {
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which;
        if (code == 13) {
            queryData();
        }
    });

    $("#btn_add").click(function() {
    	$('#methodTypeId').val('add');
        $.dialog({
            title : '添加组织机构信息',
            left : 217,
            content : $('#div_detail').html(),
            ok : function() {
                return save();
            },
            cancel : function() {
                return true;
            }
        });
        $("input[id^='det'],textarea[id^='det']").removeAttr("disabled");
        $("input[id^='det']").css({
            "color" : "#000000",
            "background" : "#ffffff"
        });
        // 加载组织机构树结构
        $.ajax({
            type : 'POST',
            url : 'organize/getOrganizeTree.do',
            data : {
                flag : "1"
            },
            datatype : 'text',
            async : false,
            success : function(result) {
                $.fn.zTree.init($("#parentOrgTree"), {
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
                        onClick : onClick1,
                        onCheck : onCheck1,
                    }
                }, result);
            }
        });
    });
}
);

function onClick1(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("parentOrgTree");
    zTree.checkNode(treeNode, ! treeNode.checked, null, true);
    return false;
}
function onCheck1(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("parentOrgTree"), nodes = zTree.getCheckedNodes(true), v = "", id = "", prc = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
        id += nodes[i].id + ",";
        prc += nodes[i].regionCode + ",";
    }
    if (v.length > 0)
        v = v.substring(0, v.length - 1);
    if (id.length > 0)
        id = id.substring(0, id.length - 1);
    if (prc.length > 0)
        prc = prc.substring(0, prc.length - 1);
    if(prc == ',') 
    	prc="";
    $("#det_parentOrgName").val(v);
    $("#det_parentOrgCode").val(id);
    $("#det_parentRegionCode").val(prc);
    hideMenu("det_parentOrgName", "menuContent1");
}
function onClick2(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("regionTree");
    zTree.checkNode(treeNode, ! treeNode.checked, null, true);
    return false;
}
function onCheck2(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("regionTree"), nodes = zTree.getCheckedNodes(true), v = "", id = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
        id += nodes[i].id + ",";
    }
    if (v.length > 0)
        v = v.substring(0, v.length - 1);
    if (id.length > 0)
        id = id.substring(0, id.length - 1);
    $("#det_regionName").val(v);
    $("#det_regionCode").val(id);
    hideMenu("det_regionName", "menuContent2");
}
function showMenu(div1, div2) {
    $("#" + div2).css("left", $("#" + div1).offset().left - $("#" + div1).width);
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
// 加载组织机构树结构
function getOrganizeTree() {
    $.ajax({
        type : 'POST',
        url : 'organize/getOrganizeTree.do',
        datatype : 'text',
        success : function(result) {
            $.fn.zTree.init($("#organizeTree"), {
                data : {
                    simpleData : {
                        enable : true
                    }
                },
                callback : {
              
                }
            }, result);
        }
    });
}
// 树点击事件
function zTreeOnClick(event, treeId, treeNode) {
    $("#organizeTable").datagrid('load', {
        parentOrgCode : treeNode.pkId == "-1" ? "" : treeNode.pkId
    });
    $('#parentOrgCode').val(treeNode.pkId == "-1" ? "" : treeNode.pkId);
    $('#orgName').val("");
    $('#orgCode').val("");
    $('#status').val("");
}
// 设置状态
function getStatus(status) {
    var commonStatusJson = $.parseJSON($("#commonStatusJson").val());
    var statusName = "";
    for (var t in commonStatusJson) {
        if (status == t) {
            statusName = commonStatusJson[t];
            break;
        }
    }
    return statusName;
}
// 修改
function update(orgCode) {
	$('#methodTypeId').val('update');
    $("input[id^='det'],textarea[id^='det']").removeAttr("disabled");
    $("input[id^='det']").css({
        "color" : "#000000",
        "background" : "#ffffff"
    });
    $("#det_orgCode,#det_parentOrgName,#det_regionName").attr("disabled", "disabled");
    $("#det_orgCode,#det_parentOrgName,#det_regionName").css({
        "color" : "#636363",
        "background" : "#EAEAEA"
    });
    $.dialog({
        title : '修改组织机构信息',
        left : 217,
        content : $("#div_detail").html(),
        ok : function() {
            return save();
        },
        cancel : function() {
            return true;
        }
    }); 
    getInfo(orgCode);
}
function changeTip() {
	var orgName=$("#orgName").val();
	var orgCode=$("#orgCode").val();
	var parentOrgCode=$("#parentOrgCode").val();
	if(null !=orgName || ""!=orgName){ $("#orgNameTip").hide();}
	if(null !=orgCode || ""!=orgCode){ $("#orgCodeTip").hide();}
	if(null !=parentOrgCode || ""!=parentOrgCode){ $("#parentOrgCodeTip").hide();}
}
// 保存
function save() {
    var orgName = $("#orgName").val();
    if (orgName == null || orgName == "") {
    	 $("#orgNameTip").show();
	     return false;
	}
    var orgCode = $("#orgCode").val();
    if (orgCode == null || orgCode == "") {
        $("#orgCodeTip").show();
        return false;
    }
  
    var parentOrgCode = $("#parentOrgCode").val();
    if (parentOrgCode == null || parentOrgCode == "") {
    	$("#parentOrgCodeTip").show();
        return false;
    }
    var orgCode = $("#orgCode").val();
    var orgName = $("#orgName").val();
    var parentOrgCode = $("#parentOrgCode").val();
    var orgDesc = $("#orgDesc").val();
    var status = $("#status").val();
   
   
    $.ajax({
        type : 'POST',
        url : 'organize/update.do',
        data : {
            orgCode : orgCode,
            orgName : $.trim(orgName),
            parentOrgCode : parentOrgCode,
            status : status,
            orgDesc : orgDesc
        },
        datatype : 'json',
        success : function(msg) {
            if (msg.flag) {
            	debugger;
                $("#organizeTable").datagrid('load', {});
                $.jBox.tip('成功！','success');
                alert(msg.msg);
                getOrganizeTree();
                setTimeout("window.location.href='organize/getOrganizeList.do'",3000);
            }else {
				$.jBox.error(msg.msg, '提示');
				return false;
			}
           
            history.go(-1);
        },
        error : function () {
			$.jBox.error(msg.msg, '提示');
			return false;
		}
    });
}
// 详情
function detail(orgCode) {
    $("input[id^='det'],textarea[id^='det']").attr("disabled", "disabled");
    $("input[id^='det']").css({
        "color" : "#636363",
        "background" : "#EAEAEA"
    });
    $.dialog({
        title : '组织机构信息',
        left : 217,
        content : $("#div_detail").html(),
        cancel : function() {
            return true;
        }
    });
    getInfo(orgCode);
}
// 获取机构信息
function getInfo(orgCode) {
    $.ajax({
        type : 'POST',
        url : 'organize/getDetail.do',
        data : {
            orgCode : orgCode
        },
        datatype : 'json',
        async : false,
        success : function(result) {
            $("#det_orgCode").val(result.orgCode);
            $("#det_orgName").val(result.orgName);
            $("#det_parentOrgCode").val(result.parentOrgCode);
            $("#det_parentOrgName").val(result.parentOrgName);
            $("#det_regionCode").val(result.regionCode);
            $("#det_regionName").val(result.regionName);
            $("#det_orgOperName").val(result.orgOperName);
            $("#det_orgTelno").val(result.orgTelno);
            $("#det_orgEmail").val(result.orgEmail);
            $("#det_orgAddress").val(result.orgAddress);
            $("#det_orgDesc").val(result.orgDesc);
        }
    });
}
// 禁用
function delConfirm(orgCode) {
    $.dialog({
        content : '确定禁用组织机构信息吗？',
        ok : function() {
            $.ajax({
                type : 'POST',
                url : 'organize/delete.do',
                data : {
                    orgCode : orgCode
                },
                datatype : 'json',
                async : false,
                success : function(msg) {
                    if (msg.flag) {
                        $("#organizeTable").datagrid('load', {});
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
        },
        cancelVal : '关闭',
        cancel : true
    });
}
// 恢复
function recover(orgCode) {
    $.ajax({
        type : 'POST',
        url : 'organize/recover.do',
        data : {
            orgCode : orgCode
        },
        datatype : 'json',
        success : function(msg) {
            if (msg.flag) {
                $("#organizeTable").datagrid('load', {});
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
}