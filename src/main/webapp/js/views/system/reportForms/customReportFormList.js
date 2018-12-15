/**
 * 
 */
var totalPage;
var totalRecords;
var pageNo = 1;

var params = null;

var menuParams = "";

//系统菜单参数设置
var setting = {
	check: { enable: true },
	data: { simpleData: { enable: true } }
};

//已授权菜单参数设置
var setting_has = {
	check: { enable: true },
	data: { simpleData: { enable: true } }
};

$(function() {
    loadProvinceAndCity(); 
    loadMode();
    loadTableCodeSelect()
    loadZTree();
});

/**
 * 获取自定义报表列表
 * @returns
 */
function getDmCustomList() {
	
	params = {};
	var acctCycle = $("#acctCycle").val();
	var province = $("#province").val();
	var city = $("#city").val();
	var principleIndustry = $("#principleIndustry").val();
	var industryDetailProduct = $("#industryDetailProduct").val();
	var mode = $("input[id=mode]:checked").val();
	var templateId = $("#templateId").val();
	//获取报表已选报表项
	menuParams = ""; //重置
	var treeToSave = $.fn.zTree.getZTreeObj("has_menus_tree");
	var nodesToSave = treeToSave.getCheckedNodes(true);
	for (x in nodesToSave) {
		//只取非父节点
		if (!nodesToSave[x].isParent) {
			menuParams += nodesToSave[x].id+",";
		}
	}
	
	params["acctCycle"] = acctCycle;
	params["province"] = province;
	params["city"] = city;
	params["principleIndustry"] = principleIndustry;
	params["industryDetailProduct"] = industryDetailProduct;
	params["mode"] = mode;
	params["templateId"] = templateId;
	params["menuParams"] = menuParams;
	params["pageNo"] = pageNo;
	
    $.ajax({
        url : "customReportForm/getDmCustomList.do",
        type : "post",
        data : params,
        dataType : 'json',
        success :function (data) {
        	if (data.msg.flag) {
        		//alert("查询成功");
        		//开始渲染列表头
        		var titleHtml = "";
        		titleHtml += "<tr>";
        		var titleList = data.titleList;
        		for (var i in titleList) {
        			titleHtml += "<th width='300'>" + titleList[i].columnName + "</th>";
        		}
        		titleHtml += "</tr>";
        		$("#reportFormTitle").html(titleHtml);
        		//开始渲染列表体
        		var bodyList = data.page.objects;
        		var bodyHtml = "";
        		for (var i in bodyList) {
        			bodyHtml += "<tr>";
        			for (var j in titleList) {
        				var bodyValue = bodyList[i][titleList[j].columnCode];
        				bodyHtml += "<td>" + (bodyValue != null ? bodyValue : '') + "</td>";
        			}
        			bodyHtml += "</tr>";
        		}
        		$("#reportFormList").html(bodyHtml);
        		
                totalPage = data.page.totalPage;
                totalRecords = data.page.totalNumber;
                pageNo = data.page.currentPage;
                toPage();
        		
        	}else {
        		params["acctCycle"] = "";
        		$.jBox.error(data.msg.msg, '提示');
        		return false;
        	}
        },
        error : function () {
        	params["acctCycle"] = "";
            $.jBox.error("获取自定义报表列表失败，请联系管理员", '提示');
            return false;
        }
    });
}

/**
 * 导出自定义报表
 * @returns
 */
function exportDmCustomList() {
	
	if (params == null) {
		$.jBox.error("请先查询报表", '提示');
		return false;
	}
	if (params["acctCycle"] == null || params["acctCycle"].length == 0) {
		$.jBox.error("请选择正确的查询日期", '提示');
		return false;
	}
	window.location.href= "customReportForm/exportDmCustomToExcel.do?" +
			"acctCycle=" + params["acctCycle"]
			+ "&province=" + params["province"]
			+ "&city=" + params["city"]
			+ "&principleIndustry=" + params["principleIndustry"]
			+ "&industryDetailProduct=" + params["industryDetailProduct"]
			+ "&mode=" + params["mode"]
			+ "&templateId=" + params["templateId"]
			+ "&menuParams=" + params["menuParams"];
	
	/*
	var params = {};
	params["acctCycle"] = acctCycle;
	params["province"] = province;
	params["city"] = city;
	params["principleIndustry"] = principleIndustry;
	params["industryDetailProduct"] = industryDetailProduct;
	params["mode"] = mode;
	params["templateId"] = templateId;
	params["menuParams"] = menuParams;
    $.ajax({
        url : "customReportForm/exportDmCustomToExcel.do",
        type : "post",
        data : params,
        dataType : 'json',
        success :function (msg) {
        	if (msg.flag) {
        		alert("导出成功");
        	}else {
        		$.jBox.error(data.msg.msg, '提示');
        		return false;
        	}
        },
        error : function () {
            $.jBox.error("导出自定义报表失败，请联系管理员", '提示');
            return false;
        }
    });
    */
}

/**
 * 加载查询方式
 * @returns
 */
function loadMode() {
	showOrHideMode($("input[id=mode]:checked").val());
	$("input[id=mode]").click(function(){
		showOrHideMode($("input[id=mode]:checked").val());
	});
}

/**
 * 根据查询方式显示或隐藏MODE
 * @returns
 */
function showOrHideMode(val) {
	if (val == 0) {
		$("#treeMode").show();
		$("#templateMode").hide();
	} else if (val == 1) {
		$("#treeMode").hide();
		$("#templateMode").show();
	}
}

/**
 * 加载自定义模板下拉框
 * @returns
 */
function loadTemplateSelect() {
	$("#templateId").empty();
	var params = {};
	var tableCode = $("#tableCode").val();
	if (tableCode == null || tableCode.length <= 0) {
		return false;
	}
	params["tableCode"] = tableCode;
	$.ajax({
        type : "POST",  
        url : "customReportForm/getUserValidCustomTemplatesList.do",   
        data : params,
		datatype : "json",
        success : function(data) { 
        	if (data != null) {
        		$("#templateId").append("<option value=\"\"></option>");
    			for(var i in data){
        			$("#templateId").append("<option value="+data[i].templateId+">" + data[i].templateName + "</option>");  
        		}
        	}
        },
        error : function () {
        	$.jBox.error("获取用户有效自定义模板信息列表异常，请联系管理员", '提示');
        }
	});	
}

/**
 * 加载省市下拉列表二级联动
 * @returns
 */
function loadProvinceAndCity() {
	var params = {};
	var pro;
	var city;
	$("#province").change(function(){
		$.ajax({  
	        type: "POST",  
	        url: "piechart/getCityByPro.do?pro="+$("#province").val(),   
	        data: params,
			datatype: "json",
	        success: function(data){
	        	if (data!=null){
	        		$("#city").empty();
	        		$("#city").append("<option value=\"\">全部</option>");
	        		var city = data.city;
        			for(x in city){
            			$("#city").append("<option value="+city[x].orgCode+">" + city[x].orgName + "</option>");  
            		}	        		    
	        	}	             
	        }  
		});    
	});
	$.ajax({
        type: "POST",  
        url: "piechart/getOrg.do",   
        data: params,
		datatype: "json",
        success: function(data){ 
        	if (data!=null){
        		flag = data.flag;
        		if(flag==1){
        			var province = data.pro;
        			for(x in province){
            			$("#province").append("<option value="+province[x].orgCode+">" + province[x].orgName + "</option>");  
            		}	
        		}else if(flag==2){
        			pro = data.pro;
        			var city = data.city;
        			for(x in city){
            			$("#city").append("<option value="+city[x].orgCode+">" + city[x].orgName + "</option>");  
            		}
        		}else{
        			city = data.city;
        			pro = data.pro;
        		} 
        	}
             
        }  
	});   
}

/**
 * 加载日期选择器
 * @returns
 */
function loadJeDate(id, formatStr) {
    $("#" + id).jeDate({
    	//format: "YYYYMM" //YYYYMMDD
        format: formatStr //日期格式YYYY-MM-DD hh:mm:ss
		//minDate:"1900-01-01 00:00:00", //最小日期
		//maxDate:"2099-12-31 23:59:59", //最大日期
		//isinitVal:false, //是否初始化时间
		//isTime:true, //是否开启时间选择
		//isClear:true, //是否显示清空
		//festival:false, //是否显示节日
		//zIndex:999,  //弹出层的层级高度
		//marks:null, //给日期做标注
		//choosefun:function(val) {},  //选中日期后的回调
		//clearfun:function(val) {},   //清除日期后的回调
		//okfun:function(val) {}       //点击确定后的回调
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
    queryCustomReportForm();
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
 * 加载表名下拉框
 * @returns
 */
function loadTableCodeSelect() {
	$.ajax({
        type : "POST",  
        url : "customReportForm/getCustomTableList.do",   
        data : {},
		datatype : "json",
		async:false,
        success : function(data) { 
        	if (data != null) {
        		$("#tableCode").empty();
        		$("#tableCode").append("<option value=\"\"></option>");
        		for(var i in data){
        			$("#tableCode").append("<option value="+data[i].columnCode+">" + data[i].columnName + "</option>");  
        		}
        	}
        },
        error : function () {
        	$.jBox.error("获取自定义表信息列表异常，请联系管理员", '提示');
        }
	});	
}

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
 * 加载表字段下拉框
 * @returns
 */
function loadTableColumn() {
	var tableCode = $("#tableCode").val();
	if(tableCode == null || tableCode == '') {
		return false;
	}
	var params = {};
	params["tableCode"] = tableCode;
	$.ajax({
        type : "POST",
        url : "customReportForm/getTableColumn.do",
        //datatype : "text",
        data : params,
		datatype : "json",
		async : false,
        success : function(result) {
        	tableColumnData = result;
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
 * 监听表名下拉框改变执行
 * @returns
 */
function tableCodeOnChange() {
	loadZTreeNull();
	loadTableColumn();
	loadZTree();
	loadTemplateSelect();
	currentDemoId = 1;
	demoArray = {};
	$("#demo").empty();
	setLoadJeDateByTableCode();
}

/**
 * 根据表编码设置日期控件
 * @returns
 */
function setLoadJeDateByTableCode() {
	var tableCode = $("#tableCode").val();
	if (tableCode == "DM_CUSTOM") {
		$("#queryDate").attr("disabled", false);
		loadJeDate("queryDate", "YYYYMMDD");
	} else if (tableCode == "DM_CUSTOM_MONTH") {
		$("#queryDate").attr("disabled", false);
		loadJeDate("queryDate", "YYYYMM");
	} else {
		$("#queryDate").val("");
		$("#queryDate").attr("disabled", true);
	}
}

/**
 * 获取自定义报表列表
 * @returns
 */
function queryCustomReportForm() {
	
	var inVo = {};
	
	var tableCode = $("#tableCode").val();
	var mode = $("input[id=mode]:checked").val();
	var templateId = $("#templateId").val();
	var queryDate = $("#queryDate").val();
	
	var customSql = {};
	var targetColumnExpressionList = [];
	var conditionalExpressionList = [];
	
	var treeToSave = $.fn.zTree.getZTreeObj("menus_tree");
	var nodesToSave = treeToSave.getCheckedNodes(true);
	
	//初始化目标列表达式
	for (x in nodesToSave) {
		//只取非父节点
		//if (!nodesToSave[x].isParent) {
			var targetColumnExpression = {};
			//targetColumnExpression["num"] = x;
			targetColumnExpression["columnExpression"] = nodesToSave[x].id;
			//targetColumnExpression["isAs"] = false;
			//targetColumnExpression["asName"] = "";
			targetColumnExpressionList.push(targetColumnExpression);
		//}
	}
	
	//默认初始化日期条件表达式
	var conditionalExpression = {};
	conditionalExpression["multipleCondition"] = "AND";
	conditionalExpression["name"] = "ACCT_CYCLE";
	conditionalExpression["predicate"] = "=";
	conditionalExpression["value"] = queryDate;
	conditionalExpressionList.push(conditionalExpression);
	
	//初始化其它条件表达式
	$.each(demoArray, function(key) {
		//demoArray[key]; //获取对应的value
		var conditionalExpression = {};
		conditionalExpression["multipleCondition"] = $("#" + demoArray[key] + "_multipleCondition").val();
		conditionalExpression["name"] = $("#" + demoArray[key] + "_name").val();
		conditionalExpression["predicate"] = $("#" + demoArray[key] + "_predicate").val();
		conditionalExpression["value"] = $("#" + demoArray[key] + "_value").val();
		conditionalExpressionList.push(conditionalExpression);
	});
	
	customSql["tableName"] = tableCode;
	customSql["conditionalExpressionList"] = conditionalExpressionList;
	customSql["targetColumnExpressionList"] = targetColumnExpressionList;
	
	inVo["pageNo"] = pageNo;
	inVo["mode"] = mode;
	inVo["templateId"] = templateId;
	if (tableCode == "DM_CUSTOM_MONTH") {
		inVo["queryDate"] = queryDate + "01";
	} else {
		inVo["queryDate"] = queryDate;
	}
	inVo["customSql"] = customSql;
	
    $.ajax({
        url : "customReportForm/queryCustomReportForm.do",
        type : "post",
        data : JSON.stringify(inVo),
        dataType : 'json',
        contentType : 'application/json',
        success :function (data) {
        	
        	if (data.msg.flag) {

        		//alert("查询成功");
        		//开始渲染列表头
        		var titleHtml = "";
        		titleHtml += "<tr>";
        		var titleList = data.titleList;
        		for (var i in titleList) {
        			titleHtml += "<th width='300'>" + titleList[i].columnName + "</th>";
        		}
        		titleHtml += "</tr>";
        		$("#reportFormTitle").html(titleHtml);
        		//开始渲染列表体
        		var bodyList = data.page.objects;
        		var bodyHtml = "";
        		for (var i in bodyList) {
        			bodyHtml += "<tr>";
        			for (var j in titleList) {
        				var bodyValue = bodyList[i][titleList[j].columnCode];
        				bodyHtml += "<td>" + (bodyValue != null ? bodyValue : '') + "</td>";
        			}
        			bodyHtml += "</tr>";
        		}
        		$("#reportFormList").html(bodyHtml);
        		
                totalPage = data.page.totalPage;
                totalRecords = data.page.totalNumber;
                pageNo = data.page.currentPage;
                toPage();
        		
        	}else {
        		$.jBox.error(data.msg.msg, '提示');
        		return false;
        	}
        },
        error : function () {
            $.jBox.error("获取自定义报表列表失败，请联系管理员", '提示');
            return false;
        }
    });
}

/**
 * 导出自定义报表列表
 * @returns
 */
function exportCustomReportForm() {
	
	var inVo = {};
	
	var tableCode = $("#tableCode").val();
	var mode = $("input[id=mode]:checked").val();
	var templateId = $("#templateId").val();
	var queryDate = $("#queryDate").val();
	
	var customSql = {};
	var targetColumnExpressionList = [];
	var conditionalExpressionList = [];
	
	var treeToSave = $.fn.zTree.getZTreeObj("menus_tree");
	var nodesToSave = treeToSave.getCheckedNodes(true);
	
	//初始化目标列表达式
	for (x in nodesToSave) {
		//只取非父节点
		//if (!nodesToSave[x].isParent) {
			var targetColumnExpression = {};
			//targetColumnExpression["num"] = x;
			targetColumnExpression["columnExpression"] = nodesToSave[x].id;
			//targetColumnExpression["isAs"] = false;
			//targetColumnExpression["asName"] = "";
			targetColumnExpressionList.push(targetColumnExpression);
		//}
	}
	
	//默认初始化日期条件表达式
	var conditionalExpression = {};
	conditionalExpression["multipleCondition"] = "AND";
	conditionalExpression["name"] = "ACCT_CYCLE";
	conditionalExpression["predicate"] = "=";
	conditionalExpression["value"] = queryDate;
	conditionalExpressionList.push(conditionalExpression);
	
	//初始化其它条件表达式
	$.each(demoArray, function(key) {
		//demoArray[key]; //获取对应的value
		var conditionalExpression = {};
		conditionalExpression["multipleCondition"] = $("#" + demoArray[key] + "_multipleCondition").val();
		conditionalExpression["name"] = $("#" + demoArray[key] + "_name").val();
		conditionalExpression["predicate"] = $("#" + demoArray[key] + "_predicate").val();
		conditionalExpression["value"] = $("#" + demoArray[key] + "_value").val();
		conditionalExpressionList.push(conditionalExpression);
	});
	
	customSql["tableName"] = tableCode;
	customSql["conditionalExpressionList"] = conditionalExpressionList;
	customSql["targetColumnExpressionList"] = targetColumnExpressionList;
	
	inVo["pageNo"] = pageNo;
	inVo["mode"] = mode;
	inVo["templateId"] = templateId;
	if (tableCode == "DM_CUSTOM_MONTH") {
		inVo["queryDate"] = queryDate + "01";
	} else {
		inVo["queryDate"] = queryDate;
	}
	inVo["customSql"] = customSql;
	
    $.ajax({
        url : "customReportForm/exportCustomReportForm.do",
        type : "post",
        async : false,
        data : JSON.stringify(inVo),
        dataType : 'json',
        contentType : 'application/json',
        success :function (data) {
        	if (data.msg.flag) {
        		downloadFile(data.fileName);
        	}else {
        		$.jBox.error(data.msg.msg, '提示');
        		return false;
        	}
        },
        error : function () {
            $.jBox.error("导出自定义报表列表失败，请联系管理员", '提示');
            return false;
        }
    });
}

/**
 * 下载文件
 * @param fileName
 * @returns
 */
function downloadFile(fileName) {
    
    if(fileName){
        var form=$("<form>");//定义一个form表单
        form.attr("style","display:none");
        form.attr("target","");
        form.attr("method","post");
        form.attr("action","customReportForm/downLoadFile.do");
        var fileInput=$("<input>");
        fileInput.attr("type","hidden");
        fileInput.attr("id","fileName");//设置属性的名字
        fileInput.attr("name","fileName");//设置属性的名字
        fileInput.attr("value",fileName);//设置属性的值
        $("body").append(form);//将表单放置在web中
        form.append(fileInput);
        form.submit();//表单提交   
        //form.remove();
    }
}

var demoArray = {};
var currentDemoId = 1;
var tableColumnData = null;

/**
 * 添加条件表达式
 * @returns
 */
function addConditionalExpression() {
	//alert("当前ID:" + currentDemoId);
	var tableCode = $("#tableCode").val();
	if(tableCode == null || tableCode == '') {
		$.jBox.error("请选择表名", '提示');
		return false;
	}
	//var count = Object.keys(demoArray).length;//获取json中key的个数
	var addHtml = "";
	addHtml += "<div class='form-group cl' id='" + currentDemoId + "'>";
	addHtml += "<label class=' fl'>&nbsp;</label>";
	addHtml += "<select class='input-text' name='" + currentDemoId + "_multipleCondition' id='" + currentDemoId + "_multipleCondition' style='width:70px;'>";
	addHtml += "<option value='AND'>AND</option>";
	addHtml += "<option value='OR'>OR</option>";
	addHtml += "<option value='NOT'>NOT</option>";
	addHtml += "</select> ";
	addHtml += "<select class='input-text' name='" + currentDemoId + "_name' id='" + currentDemoId + "_name' onchange=\"setCurrentDemoPlaceholder('" + currentDemoId + "')\" style='width:100px;'>";
	if (tableColumnData != null) {
		for (var i in tableColumnData) {
			addHtml += "<option value='" + tableColumnData[i].columnCode + "'>" + tableColumnData[i].columnName + "</option>";
		}
	}
	addHtml += "</select> ";
	addHtml += "<select class='input-text' name='" + currentDemoId + "_predicate' id='" + currentDemoId + "_predicate' style='width:75px;'>";
	addHtml += "<option value='='>等于</option>";
	addHtml += "<option value='>'>大于</option>";
	addHtml += "<option value='>='>大于等于</option>";
	addHtml += "<option value='<''>小于</option>";
	addHtml += "<option value='<='>小于等于</option>";
	addHtml += "<option value='<>''>不等于</option>";
	addHtml += "</select> ";
	addHtml += "<input type='text' class='input-text input-text2' name='" + currentDemoId + "_value' id='" + currentDemoId + "_value' placeholder='" + tableColumnData[0].columnDesc + "' style='width: 130px;'> ";
	addHtml += "<button class='btn btn-close customReportForm' onclick=\"delConditionalExpression('" + currentDemoId + "')\">删除</button> ";
	addHtml += "</div>";
	$('#demo').append(addHtml);
	demoArray[currentDemoId] = currentDemoId;
	currentDemoId++;
}

/**
 * 删除条件表达式
 * @returns
 */
function delConditionalExpression(key) {
	delete demoArray[key];
	$("#" + key).remove();
}

/**
 * 设置currentDemoId_value
 * @returns
 */
function setCurrentDemoPlaceholder(id) {
	var columnCode = $("#" + id + "_name").val();
	for (var i in tableColumnData) {
		if (tableColumnData[i].columnCode == columnCode) {
			 $("#" + id + "_value").attr('placeholder',tableColumnData[i].columnDesc);
		}
	}
}

