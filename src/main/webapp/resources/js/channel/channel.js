/**
 * 渠道树
 */
var setting=null;
$(document).ready(function() {
    /*setting = {
        data : {
            simpleData : {
                enable : true
            }
        },
        callback : {
            onClick : zTreeOnClick
        }
    };*/
    var channel_type_tree_setting = {
        data : {
            simpleData : {
                enable : true
            }
        },
        callback : {
        	onClick: channelTypeOnClick
        }
    };
    
    /*var initTips = $.dialog.tips('渠道数据加载中...',60000,'loading.gif').lock();
    //渠道树数据加载
    $.ajax({
        type : 'POST',
        url : 'channel/getChannelTree.do?statusFlag=all',
        datatype : 'text',
        success : function(result) {
            $.fn.zTree.init($("#channelTree"), setting, result);
            initTips.close();
        },error : function(result){
        	initTips.close();
        }
    });*/
    
    //渠道类型树数据加载
    $.ajax({
    	type : 'POST',
    	url : 'channelType/getTreeList.do',
    	datatype : 'text',
    	success : function(result) {
    		$.fn.zTree.init($("#channelTypeTree"), channel_type_tree_setting, result);
    	}
    });
    
    //设置树形层高度
    /*var ph=$("#div_main_right", window.parent.document).css("height");//父窗口高度
    ph=Number(ph.substr(0,ph.indexOf('px')))-50;
	$("#div_contText").height(ph);*/
});


var channelDG=null;
/**
 * 渠道树单击事件
 * @param event
 * @param treeId
 * @param treeNode
 */
/*function zTreeOnClick(event, treeId, treeNode) {
	channelDG.datagrid('load',{
		parentChannelId: treeNode.id
	});
	$('#parentChannelId').val(treeNode.id);
}*/

/**
 * 渠道数据获取
 */
$(function(){
	channelDG=$("#channelDG").datagrid({
		url : "channel/getChannelList.do",
		fit : true,
		nowrap : true,
		fitColumns : true,
		pagination : true,
		rownumbers : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40, 50 ],
		idField : "channelId",
		columns : [ [ 
		{
			field : "channelId",
			checkbox:true
		}, {
			field : "channelName",
			align : "left",
			width : 20,
			title : "渠道名称"
		}, {
			field : "channelAccount",
			align : "left",
			width : 20,
			title : "渠道账号"
		},{
			field : "channelTypeName",
			align : "left",
			width : 15,
			title : "渠道类型"
		},{
			field : "statusTxt",
			align : "center",
			width : 10,
			title : "状态"
		},{
			field : "parentChannelId",
			hidden:true
			/*},{
			field : "channelGradeTxt",
			align : "center",
			width : 10,
			title : "级别"	
		
		},{
			field : "regionName",
			align : "left",
			width : 15,
			title : "代理地市",
			formatter: function(value, rowData, rowIndex) {
				if (null!=value && value.length>10){
					return "<font title='"+value+"'>"+value.substr(0,10)+"...</font>";
				} else {
					return value;
				}
			}
		},{
			field : "mallName",
			align : "left",
			width : 15,
			title : "使用商城",
			formatter: function(value, rowData, rowIndex) {
				if (null!=value && value.length>10){
					return "<font title='"+value+"'>"+value.substr(0,10)+"...</font>";
				} else {
					return value;
				}
			}
		*/
		},{
			field : "control",
			align : "center",
			width : 15,
			title : "操作",
			formatter : function(value, rowData, rowIndex) {
				var array=[];
				if(CHL_CHANNEL_DETAIL){
					array.push('<a href="channel/toChannelDetail.do?channelId='+rowData.channelId+'&type=2"  class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="Details" /></a>');
				}
				if("0" == rowData.status){
					if (CHL_CHANNEL_REC) {
						array.push("<a href='javascript:void(0);' onclick='recover("+rowData.channelId+");' class='operButton' title='恢复'><img src='resources/easyui13/themes/gray/images/button/btn_renew.gif' alt='Recovery' /></a>");
					}
				} else {
					//if(rowData.dataControlEnable){
						if (CHL_CHANNEL_UPD) {
							if(currentParentChannelId != '' && currentParentChannelId == rowData.channelId){
								array.push('<a href="channel/toChannelDetail.do?type=1&channelId='+rowData.channelId+'&parentChannelId='+rowData.parentChannelId+'" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="Edit" /></a>');
							}else if(currentParentChannelId == '' || currentParentChannelId == '-1' ){
								array.push('<a href="channel/toChannelDetail.do?type=1&channelId='+rowData.channelId+'&parentChannelId='+rowData.parentChannelId+'" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="Edit" /></a>');
							}
						}
						if (CHL_CHANNEL_DEL) {
							array.push('<a href="javascript:void(0);" onclick="delConfirm(\''+rowData.channelId+'\');" class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="禁用" /></a>');
						}
					//}
				}
				return array.join('');
			}
		} ] ],
		onLoadSuccess: function (data) {
			channelDG.datagrid('clearSelections'); 
		}
	});
})

//当前查询条件
var currentDataParams;
/**
 * 渠道信息查询
 */
function queryData(){
	currentDataParams = {
			parentChannelId:$('#parentChannelId').val(),
			channelName:$('#channelName').val(),
			mallCode:$('#mallCode').val(),
			regionCode:$('#regionCode').val(),
			status:$('#status').val(),
			channelAccount:$('#channelAccount').val(),
			channelTypeId:$('#channelTypeId').val(),
			beginTime:$('#beginTime').val(),
			endTime:$('#endTime').val(),
			channelGrade:$('#channelGrade').val(),
			channelMark:$('#channelMark').val(),
			licensingId:$('#licensingId').val()
		};
	channelDG.datagrid('load',currentDataParams);
}

/**
 * 渠道信息禁用
 * @param id
 * @returns {Boolean}
 */
function delConfirm(id){
	var row ;
	var ids = [];
	var postData = '';
	if(undefined != id && "" != id){
		postData = 'channelIds='+id;
	}else{
		row = channelDG.datagrid('getSelections');
		if(row.length < 1){
			//提示信息
			$.dialog({
				lock: true,
				title: "提示",
			    content: "请选择您要禁用的渠道信息!",
			    ok: function(){
			        this.title('提示：').time(0.001);//0.001秒后关闭
			    	return false;
			    },
			    cancelVal: '关闭',
			    cancel: true
			});
			return false;
		}
		for(var i=0;i<row.length;i++){
			ids.push(row[i].channelId);
		}
		postData='channelIds='+ ids.join('&channelIds=');
	}
	//禁用
	$.dialog.confirm('确定禁用渠道信息吗？', function(){
	    delChannel(postData);
	}, function(){
	    //$.dialog.tips('执行取消操作');
	});
}

/**
 * 渠道禁用
 */
function delChannel(postData){
	$.ajax({
		type : 'POST',
		url : 'channel/deleteChannel.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				channelDG.datagrid('load',{});
			}
			//提示信息
			$.dialog({
			    title: '提示',
			    content: msg.msg,
			    cancelVal: '关闭',
			    cancel: true
			});
		}
	});
}

/**
 * 渠道状态恢复
 * @param channelId
 */
function recover(channelId) {
	//恢复
	$.dialog.confirm('确定恢复渠道信息吗 ？', function(){
		$.ajax({
			type : 'POST',
			url : 'channel/recoverChannel.do',
			data : 'channelId='+channelId,
			datatype : 'json',
			success : function(msg) {
				if(msg.flag){
					channelDG.datagrid('load',{});
				}
				//提示信息
				$.dialog({
					title: '提示',
					content: msg.msg,
					cancelVal: '关闭',
					cancel: true
				});
			}
		});
	}, function(){
	    //$.dialog.tips('执行取消操作');
	});
}


//------------- Start -----------------------------------
/**
 * 渠道类型查询条件设置
 */
function channelTypeOnClick(e, treeId, treeNode) {
	$("#channelTypeId").val(treeNode.id);
	$("#channelTypeName").val(treeNode.name);
	hideMenu();//选中值后，隐藏层
}

function showMenu() {
	var cityObj = $("#channelTypeName");
	var cityOffset = $("#channelTypeName").offset();
	$("#menu_content").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
	$("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
	$("#menu_content").fadeOut("fast");
	$("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
	if (!(event.target.id == "channelTypeName" || event.target.id == "menu_content" || $(event.target).parents("#menu_content").length>0)) {
		hideMenu();
	}
}
//------------ END ------------------------------

function add(){
	//var parentChannelId=$('#parentChannelId').val();
	var parentChannelId;
	var selectedRows = channelDG.datagrid('getSelections');
	if(selectedRows.length == 0){//未选择渠道列表中的渠道数据时,则默认为action传过来的值
		/*showDialog('请选择列表的一个渠道做为父级渠道!!!','error',null);
		return false;*/
		parentChannelId = currentParentChannelId;
	}else if(selectedRows.length > 1){
		showDialog('Only can select one parent channel from the channel list!!!','error',null);
		return false;
	}else{
		/*
		if(!selectedRows[0].dataControlEnable){
			alert('该父渠道共享商城或地市，该用户不具备新增条件！');
			return false;
		}
		
		//验证该渠道是不是为跨地市渠道(即所适用地市是否超一个地市)
		if(currentOperType == operTypeCity && selectedRows[0].regionCodes && selectedRows[0].regionCodes.indexOf(',') != -1){
			alert('地市管理员不能新增跨地市渠道的下级渠道!');
			return false;
		}
		*/
		//parentChannelId = selectedRows[0].parentChannelId;
		parentChannelId = selectedRows[0].channelId;
	}
	location.href=rootPath+"/channel/toChannelDetail.do?type=0&parentChannelId="+parentChannelId;
}

function queryChannelTree(){
	$.ajax({
        type : 'POST',
        url : rootPath+'/channel/getChannelTree.do',
        data : {
        	channelName : $.trim($("#channelName1").val())
        },
        datatype : 'json',
        success : function(result) {
            $.fn.zTree.init($("#channelTree"), setting, result);
        }
    });
}

function importChannel(){
	location.href=rootPath+"/channel/toChannelImport.do";
}

//导出渠道数据
function exportChannel(){
	//console.log(currentDataParams);
	var paramsData = "";
	if(currentDataParams){
		for(var p in currentDataParams){
			paramsData += "&" + p + "=" + currentDataParams[p];
		}
	}
	window.location.href=rootPath+"/channel/exportChannel.do?x=y" + paramsData;
}

//按回车查询
function getKey(event){
    if(event.keyCode==13){
    	stopDefault(event);
    	queryData();
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