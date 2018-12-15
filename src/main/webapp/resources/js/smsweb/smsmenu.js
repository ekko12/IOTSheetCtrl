$(document).ready(function() {
    $(".nav_epa").css("height", ($(window).height() - 50) + "px");
    $("#smsMenuTree").css("height", ($(window).height() - 50) + "px");
    getSmsMenuTree();
    $("#btn_save").click(function() {
        var lock = $.dialog({
            show : false
        }).lock();
        var opType = $("#opType").val();
        var menuId = $.trim($("#menuId").val());
        var menuCodeEn =  $.trim($("#menuCodeEn").val());
        var menuCodeCn =  $.trim($("#menuCodeCn").val());
        var menuCodeLocal =  $.trim($("#menuCodeLocal").val());
        var parentMenuId = $("#parent_menu_id").val();
        var parentMenuName = $("#parent_menu_name").val();
        var menuNameEn =  $.trim($("#menu_name_en").val());
        var menuNameCn =  $.trim($("#menu_name_cn").val());
        var menuNameJpz =  $.trim($("#menu_name_jpz").val());
        var validDate = $("#validDate").val();
        var expireDate = $("#expireDate").val();
        var sort =  $.trim($("#sort").val());
        var remarks =  $.trim($("#remarks").val());
        var state = $("#state").val();
        var area = $("input[name='area']:checked").val();
        var brand = $("input[name='brand']:checked").val();
       
        if (menuId == null || menuId == "") {
            $.dialog({
                title : '提示',
                content : "Menu id can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        var ex = /^\d+$/;
        if (!ex.test(menuId)) {
        	 $.dialog({
                 title : '提示',
                 content : "Menu id must be an integer！ ",
                 cancelVal : 'Close',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
        }
        if (menuCodeEn == null || menuCodeEn == "") {
            $.dialog({
                title : '提示',
                content : "Menu code (English) can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        if (menuCodeCn == null || menuCodeCn == "") {
            $.dialog({
                title : '提示',
                content : "Menu code (Chinese) can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        if (menuCodeLocal == null || menuCodeLocal == "") {
            $.dialog({
                title : '提示',
                content : "Menu code (Khmer) can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        
        if (menuNameEn == null || menuNameEn == "") {
            $.dialog({
                title : '提示',
                content : "Menu name (English) can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        
        if (menuNameCn == null || menuNameCn == "") {
            $.dialog({
                title : '提示',
                content : "Menu name (Chinese) can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        
        if (menuNameJpz == null || menuNameJpz == "") {
            $.dialog({
                title : 'Prompt',
                content : "Menu name (Khmer) can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        
        if (validDate == null || validDate == "") {
            $.dialog({
                title : 'Prompt',
                content : "Effective time cannot be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        
        if (expireDate == null || expireDate == "") {
            $.dialog({
                title : 'Prompt',
                content : "Expiry time cannot be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        if(validDate>expireDate){
        	 $.dialog({
                 title : 'Prompt',
                 content : "The expiry time can not be less than the effective time！",
                 cancelVal : 'Close',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
        }
        
        if (area == null || area == "") {
            $.dialog({
                title : 'Prompt',
                content : "Region can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        
        if (brand == null || brand == "") {
            $.dialog({
                title : 'Prompt',
                content : "Brand can not be empty！",
                cancelVal : 'Close',
                cancel : function() {
                    lock.close();
                    return true;
                }
            });
            return false;
        }
        $.ajax({
            type : 'POST',
            url : 'smsweb/smsmenu/saveSmsMenu.do',
            data : {
            	opType:opType,
                menuId:menuId,
                menuCodeEn:menuCodeEn,
                menuCodeCn:menuCodeCn,
                menuCodeLocal:menuCodeLocal,
                parentMenuId:parentMenuId,
                menuNameEn:menuNameEn,
                menuNameCn:menuNameCn,
                menuNameJpz:menuNameJpz,
                validDate:validDate,
            	expireDate: expireDate,
            	sort :sort,
            	remarks: remarks,
            	state:state,
            	area :area,
            	brand :brand
                
            },
            datatype : 'json',
            success : function(msg) {
                if (msg.flag) {
                    getSmsMenuTree();
                }
                // 提示信息
                $.dialog({
                    title : 'Prompt',
                    content : msg.msg,
                    cancelVal : 'Close',
                    cancel : function() {
                        lock.close();
                        return true;
                    }
                });
            }
        });
    });
    // 删除
    $("#btn_delete").click(function() {
    	var opType = $("#opType").val();
    	//新增时删除按键无效
    	if(opType=="1"){
    		return;
    	}
    	var menuIds=getAllId($("#menuId").val());
        $.dialog.confirm('Are you sure ?', function() {
            $.ajax({
                type : 'POST',
                url : 'smsweb/smsmenu/delSmsMenu.do',
                data : {
                	menuId:menuIds
                },
                datatype : 'json',
                success : function(msg) {
                    if (msg.flag) {
                    	getSmsMenuTree();
                    }
                    // 提示信息
                    $.dialog({
                        title : 'Prompt',
                        content : msg.msg,
                        cancelVal : 'Close',
                        cancel : true
                    });
                }
            });
        });
    });
    
    $("#flushCache").on("click",function(){
    	var sms=$.dialog({
    		    id: 'smsID',
    		    title:'SMS Business Office refresh the cache',
    		    content: 'Click【 OK】 to refresh the cache of SMS business office！',
    		    lock: true,
    		    background: '#000', 
    		    opacity: 0.5, 
    		    button: [
    		        {
    		            name: 'OK',
    		            callback: function () {
			            	this.content('Loading is complete').time(2);
			            	$.post(rootPath+"/smsweb/smsBusiAccess/smsFlushCache.do")
							.success(function() { 								
				                return false;
							})
							.error(function(error) { alert("刷新失败！"+error); });
			         	},
    		            focus: true
    		        }
    		    ]
    		});
    });
   
});


function getSmsMenuTree() {
	
	clearMenuDetail();
    $("#smsMenuDetail").hide();
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
        url : 'smsweb/smsmenu/getSmsMenuTree.do',
        datatype : 'json',
        success : function(result) {
            $.fn.zTree.init($("#smsMenuTree"), setting, result);
        }
    });
}
function addHoverDom(treeId, treeNode) {
   
        if (treeNode.status != '0'||treeNode.pkId=='-1') {
            var sObj = $("#" + treeNode.tId + "_span");
            if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)
                return;
            var addStr =
                    "<span class='button add' id='addBtn_" + treeNode.tId
                            + "' title='add menu' onfocus='this.blur();'></span>";
            sObj.after(addStr);
            var btn = $("#addBtn_" + treeNode.tId);
            
            
            if (btn) {
                btn.bind("click", function() {
                	//新增
                	$("#opType").val("1");
                    $("#menuId").val("");
                    $("#menuName").val("");
                    $("#parent_menu_id").val(treeNode.pkId);
                    $("#parent_menu_name").val(treeNode.name);
                   
                    
                    
                	 $("#parent_menu_name").val(treeNode.name).attr("disabled", "disabled").css({
                         "color" : "#636363",
                         "background" : "#EAEAEA"
                     });
                	 
                	 $.ajax({
                         type : 'POST',
                         url : 'smsweb/smsmenu/getSort.do',
                         data : {
                         	menuId:treeNode.pkId 
                         },
                         datatype : 'json',
                         success : function(result) {
                         	$("#sort").val(result.msg);
                         }
                     });
                  
                	 $("#sort").attr("readonly", "true").css({
                         "color" : "#636363",
                         "background" : "#EAEAEA"
                     });
                    $("#smsMenuDetail").show();
                    clearMenuDetail();
                    return false;
                });
            }
        }
    
}
function removeHoverDom(treeId, treeNode) {
    $("#addBtn_" + treeNode.tId).unbind().remove();
}
function zTreeOnClick(event, treeId, treeNode) {
    if(treeNode.pkId!='-1'){
    $.ajax({
        type : 'POST',
        url : 'smsweb/smsmenu/getSmsMenuDetail.do',
        data : {
            menuId : treeNode.pkId
        },
        datatype : 'text',
        success : function(result) {
        	$("#opType").val("2");
            $("#menuCodeEn").val(result.menu_code_en);
            $("#menuCodeCn").val(result.menu_code_cn);
            $("#menuCodeLocal").val(result.menu_code_local);
            $("#menu_name_en").val(result.menu_name_en);
            $("#menu_name_cn").val(result.menu_name_cn);
            $("#menu_name_jpz").val(result.menu_name_jpz);
            $("#validDate").val(result.validDate);
            $("#expireDate").val(result.expireDate);
            $("#sort").val(result.sort);
            $("#remarks").val(result.remarks);
            $("#state").val(result.state);
           
            $("input[name='area']").attr("checked","checked");
            $("input[name='brand']").attr("checked","checked");
            $("#menuId").val(result.menu_id).attr("readonly", "true").css({
                "color" : "#636363",
                "background" : "#EAEAEA"
            });
            $("#parent_menu_name").val(result.parentMenuName).attr("disabled", "disabled").css({
                "color" : "#636363",
                "background" : "#EAEAEA"
            });
            $("#sort").attr("readonly", "true").css({
                "color" : "#636363",
                "background" : "#EAEAEA"
            });
           
            $("#smsMenuDetail").show();
        }
    });
    }
}

function getAllId(id){
	var ids=[];
	ids.push(id);
	var treeObj = $.fn.zTree.getZTreeObj("smsMenuTree");
	var node = treeObj.getNodesByParam("pId", id, null);
	for(var i=0,len=node.length;i<len;i++){
		ids.push(getAllId(node[i].id));
	}
	if(ids.length>1){
		// 提示信息
        $.dialog({
            title : 'Prompt',
            content : 'The current menu contains submenus, you can not delete it!',
            cancelVal : 'Close',
            cancel : true
        });
	}
	return id;
}

function clearMenuDetail(){
	 $("#menuId").removeAttr("readonly").removeAttr("style").val("");
	 $("#menuCodeEn").val('');
	 $("#menuCodeCn").val('');
	 $("#menuCodeLocal").val('');
     $("#menu_name_en").val('');
     $("#menu_name_cn").val('');
     $("#menu_name_jpz").val('');
     $("#validDate").val('');
     $("#expireDate").val('');
     $("#sort").val('');
     $("#remarks").val('');
}