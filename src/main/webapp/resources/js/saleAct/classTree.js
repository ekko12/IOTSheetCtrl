function getClassTree(id){
	$("#className").val("");
    $("#classId").val("");
	$.ajax({
        type : 'POST',
        url : 'productClass/getTreeList.do',
        data:{classType:id},
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