/**
 * 
 */
var totalPage; //总页数
var totalRecords; //总记录数
var pageNo = 1; //当前页码

var menuParams = ""; //选中菜单，多个以“，”分隔

var tableCodeDate = null;

//系统菜单参数设置
var setting = {
	check : { enable: true },
	data : { simpleData: { enable: true } }
};

//已授权菜单参数设置
var setting_has = {
	check : { enable: true },
	data : { simpleData: { enable: true } }
};

$(function(){
	getTableCodeDate();
	loadSearchTableCodeSelect();
    getTemplateList();
});

/**
 * 加载TableColumnZTree
 * @returns
 */
function loadZTree() {
	var tableCode = $("#tableCode").val();
	if(tableCode == null || tableCode == '') {
		loadZTreeNull();
		return false;
	}
	var params = {};
	params["tableCode"] = tableCode;
	params["showFlag"] = true;
	//TableColumnZTree设置,showFlag=true表示默认展开菜单
	$.ajax({
        type : "POST",
        url : "customReportForm/getTableColumnTree.do",
        //datatype : "text",
        data : params,
		datatype : "json",
        success : function(result) {
        	$.fn.zTree.init($("#menus_tree"), setting, result);
        }
    });
}

/**
 * 加载null ZTree
 * @returns
 */
function loadZTreeNull() {
    $.fn.zTree.init($("#menus_tree"), setting, null);
}

/**
 * 重置新增表单
 * @returns
 */
function resetAddForm() {
	resetModalForm();
	$("#btn-sure").attr("disabled", false); //设置提交按钮生效
	//loadZTree();
}

/**
 * 提交自定义模板
 * @returns
 */
function submitCustomTemplate() {
	
	$("#btn-sure").attr("disabled", true); //设置提交按钮失效
	var params = {};
	var templateId = $("#templateId").val();
	var tableCode = $("#tableCode").val();
	var templateName = $("#templateName").val();
	var status = $("#status").val();
	var templateDesc = $("#templateDesc").val();
	
	//获取报表已选报表项
	menuParams = ""; //重置
	var treeToSave = $.fn.zTree.getZTreeObj("menus_tree");
	var nodesToSave = treeToSave.getCheckedNodes(true);
	for (x in nodesToSave) {
		menuParams += nodesToSave[x].id+",";
	}
	
	var url = "customReportForm/saveUserTemplate.do";
	if (templateId != null && templateId.length > 0) {
		url = "customReportForm/modifyUserTemplate.do"
	}
	
	params["templateId"] = templateId;
	params["tableCode"] = tableCode;
	params["templateName"] = templateName;
	params["status"] = status;
	params["templateDesc"] = templateDesc;
	params["menuParams"] = menuParams;
	
	$.ajax({
		type : "POST",
		url : url,
		data : params,
		datatype : "json",
		success : function(msg) {
			if (msg.flag) {
				$.jBox.tip(msg.msg, "success");
				setTimeout('window.location.href="customReportForm/templatesList.do"',500);
			} else {
	            $.jBox.error(msg.msg, '提示');
	            $("#btn-sure").attr("disabled", false); //设置提交按钮失效
			}
		},
	    error : function (XMLHttpRequest, textStatus, errorThrown) {
	    	$.jBox.error("提交自定义模板信息异常，请联系管理员", '提示');
	    }
	});
}

/**
 * 设置模板编号，用于删除使用
 * @param templateId
 * @returns
 */
function setTemplateId(templateId) {
	$("#btn-del").attr("disabled", true); //设置提交按钮失效
	$("#templateId").val(templateId);
	$("#btn-del").attr("disabled", false); //设置提交按钮生效
}

/**
 * 删除自定义模板
 * @returns
 */
function deleteCustomTemplate() {
	$("#btn-del").attr("disabled", true); //设置提交按钮失效
	var params = {};
	var templateId = $("#templateId").val();	
	params["templateId"] = templateId;	
	$.ajax({
		type : "POST",
		url : "customReportForm/deleteUserTemplate.do",
		data : params,
		datatype : "json",
		success : function(msg) {
			if (msg.flag) {
				$.jBox.tip(msg.msg, "success");
				setTimeout('window.location.href="customReportForm/templatesList.do"',500);
			} else {
	            $.jBox.error(msg.msg, '提示');
			}
		},
	    error : function (XMLHttpRequest, textStatus, errorThrown) {
	    	$.jBox.error("提交自定义模板信息异常，请联系管理员", '提示');
	    }
	});
}

/**
 * 获取模板信息
 * @returns
 */
function getTemplate(id) {
	resetModalForm();
	$("#tableCode").attr("disabled", true); //设置只读
    $.ajax({
        url : "customReportForm/getTemplate.do",
        type : 'post',
        data : {"templateId" : id},
        dataType : 'json',
        success : function (data) {
            //var list = data.objects;
            $("#templateId").val(data.templateId);
            $("#tableCode").val(data.tableCode);
            $("#templateName").val(data.templateName);
            $("#status").val(data.status);
            $("#templateDesc").val(data.templateDesc);
            $.fn.zTree.init($("#menus_tree"), setting, data.customColumnsTree);
            $("#btn-sure").attr("disabled", false); //设置提交按钮生效
        },
        error : function () {
        	$.jBox.error("查询信息异常，请联系管理员", '提示');
        }
    });
}

/**
 * 重置表单
 * @returns
 */
function resetModalForm() {
	loadTableCodeSelect();
	loadZTreeNull();
	$("#tableCode").attr("disabled", false); //设置编辑
    $("#templateId").val("");
    $("#templateName").val("");
    $("#status").val("1");
    $("#templateDesc").val("");
    $("#btn-sure").attr("disabled", true); //设置提交按钮失效
}

/**
 * 按关键字检索获取模板信息列表
 * @returns
 */
function searchTemplateList() {
	pageNo = 1; //重置页码
	getTemplateList();
}

/**
 * 获取模板信息列表
 * @returns
 */
function getTemplateList() {
	
	var params = {};
	var keywordTemplateName = $("#keywordTemplateName").val();	
	var keywordTableCode = $("#keywordTableCode").val();	
	var keywordStatus = $("#keywordStatus").val();	
	params["keywordTemplateName"] = keywordTemplateName;	
	params["keywordTableCode"] = keywordTableCode;	
	params["keywordStatus"] = keywordStatus;	
	params["pageNo"] = pageNo;	
	
    $.ajax({
        url : "customReportForm/getUserTemplatesList.do",
        type : 'post',
        data : params,
        dataType : 'json',
        success : function (data) {
            var html = "";
            var list = data.objects;
            for(var i in list){
                html += "<tr>";
                for (var j in tableCodeDate) {
                	if (list[i].tableCode == tableCodeDate[j].columnCode) {
                		html += "<td>"+tableCodeDate[j].columnName+"</td>";
                	}
                }
                html += "<td>"+list[i].templateName+"</td>";
                if(list[i].status=="1"){
                    html += "<td ><b class='c-primary'>有效</b></td>";
                }else{
                    html += "<td >无效</td>";
                }
                html += "<td>" + list[i].templateDesc + "</td>";
                html += "<td>" + FormatDate(list[i].createTime) + "</td>";
                var templateId = list[i].templateId;
                html += '<td>'+
	                		"<a class=\"btn btn-op ml-10\" data-toggle=\"modal\" href=\"#userDetail\" onClick=\"getTemplate('" + templateId + "');\" title=\"修改\"><i class=\"fa fa-edit\"></i></a>" +
		                    "<a class=\"btn btn-op ml-10\" data-toggle=\"modal\" href=\"#Modal-delete\" onClick=\"setTemplateId('"+templateId+"');\" title=\"删除\"><i class=\"fa fa-trash\"></i></a>" + 
		                '</td>';
                html += "</tr>";
            }
            $("#templateList").html(html);
            totalPage = data.totalPage;
            totalRecords = data.totalNumber;
            pageNo = data.currentPage;
            toPage();
        },
        error : function () {
        	$.jBox.error("查询信息列表异常，请联系管理员", '提示');
        }
    });
}

/**
 * 格式化时间
 * @param strTime
 * @returns
 */
function FormatDate (strTime) {
    var date = new Date(strTime);
    var mon;var day;var hour;var min;
    var  temp=date.getMonth()+1;
    if(temp<10){mon="0"+temp;}else {mon=temp;}
    if(date.getDate()<10){day="0"+date.getDate();}else {day=date.getDate();}
    if(date.getHours()<10){hour="0"+date.getHours();}else {hour=date.getHours();}
    if(date.getMinutes()<10){min="0"+date.getMinutes();}else {min=date.getMinutes();}
    return date.getFullYear()+"-"+mon+"-"+day+" "+hour+":"+min;
}

/**
 * 改变页码
 * @returns
 */
function changPage(){
    pageNo = $(".curr").text()==undefined||$(".curr").text()==""?1:$(".curr").text();
    getTemplateList();
}

/**
 * 分页
 * @returns
 */
function toPage(){
    //alert("总页数"+totalPage+"-总数据"+totalRecords+"-当前页"+pageNo);
    kkpager.total = totalPage;
    kkpager.totalRecords = totalRecords;
    kkpager.pno = pageNo;
    kkpager.hasPrv = (kkpager.pno > 1)
    kkpager.hasNext = (kkpager.pno < kkpager.total);
    kkpager.generPageHtml({
        pno : pageNo,
        mode : 'click',
        total : totalPage,
        totalRecords : totalRecords,
        click : function(n){
            this.selectPage(n);
            changPage();
            return false;
        },
        getHref : function(n){
            return "javascript:void(0)";
        }
    },true);
}

/**
 * 获取表名数据
 * @returns
 */
function getTableCodeDate() {
	$.ajax({
        type : "POST",  
        url : "customReportForm/getCustomTableList.do",   
        data : {},
		datatype : "json",
		async:false,
        success : function(data) { 
        	if (data != null) {
        		tableCodeDate = data;
        	}
        },
        error : function () {
        	$.jBox.error("获取自定义表信息列表异常，请联系管理员", '提示');
        }
	});	
}

/**
 * 加载表单表名下拉框
 * @returns
 */
function loadTableCodeSelect() {
	if (tableCodeDate != null) {
		$("#tableCode").empty();
		$("#tableCode").append("<option value=\"\"></option>");
		for(var i in tableCodeDate){
			$("#tableCode").append("<option value="+tableCodeDate[i].columnCode+">" + tableCodeDate[i].columnName + "</option>");  
		}
	}
}

/**
 * 加载检索表名下拉框
 * @returns
 */
function loadSearchTableCodeSelect() {
	if (tableCodeDate != null) {
		$("#keywordTableCode").empty();
		$("#keywordTableCode").append("<option value=\"\">全部</option>");
		for(var i in tableCodeDate){
			$("#keywordTableCode").append("<option value="+tableCodeDate[i].columnCode+">" + tableCodeDate[i].columnName + "</option>");  
		}
	}
}

/**
 * 监听表名下拉框改变执行加载对应的ztree
 * @returns
 */
function tableCodeOnChange() {
	loadZTreeNull();
	loadZTree();
}
    
