/*
 * 此js文件为各类型(合约机、祼机、上网卡等)销售商品明细的新增页面调用
 */
//定义当前销售商品品类类型及各种销售商品品类类型的编码(未完待续)
var currentExtMarkCode;
var terminalExtMarkCode;
var contractTerminalExtMarkCode;
var netWorkExtMarkCode;

//合约机合约计划(类型与时长)
var packageObjectArray = [];
var packageTypeObjectArray = [];
var packageLimitObjectArray = [];

var firstProductId;//第一个终端货品id
var firstContractPlanId;//第一个合约计划id

//合约机相关的属性
var selectedSkuProductObjectArray = [];//已选中的sku终端货品

function loadProductAttrTest(channelGoodsId){
	return "<li><div class=\"leftt\">销售价格：</div>"+ 
		"<div class=\"rightt\"><label><input class=\"checkbox\" name=\"chkGoodsSku\" type=\"checkbox\" value=\"\" checked=\"checked\">黑色</label><input name=\"\" type=\"text\" value=\"5199\" style=\" width:170px\"><b>元</b></div>" + 
		"</li><li><div class=\"leftt\"></div>" + 
		"<div class=\"rightt\"><label><input class=\"checkbox\" name=\"chkGoodsSku\" type=\"checkbox\" value=\"\" checked=\"checked\">白色</label><input name=\"\" type=\"text\" value=\"5199\" style=\" width:170px\"><b>元</b></div>" + 
		"</li><li><div class=\"leftt\"></div>" + 
		"<div class=\"rightt\"><label><input class=\"checkbox\" name=\"chkGoodsSku\" type=\"checkbox\" value=\"\" checked=\"checked\">红色</label><input name=\"\" type=\"text\" value=\"5199\" style=\" width:170px\"><b>元</b></div>" + 
		"</li>";
}
/**
 * 加载终端对应的sku属性(该商品对应有货品的,则只选中相应有货品的复选框)
 * json串:如{list:[{"attrVal":"红色","productId":6},{"attrVal":"16G","productId":6},{"attrVal":"黑色","productId":7},{"attrVal":"16G","productId":7}]}
 * 
 * 返回格式串如果,第一个结果的li有销售价格
 *  <li>
		<div class="leftt">销售价格：</div>
		<div class="rightt"><label><input class="checkbox" name="" type="checkbox" value="" checked="checked">黑色</label><input name="" type="text" value="5199" style=" width:170px"><b>元</b></div>
	</li>
	<li>
		<div class="leftt"></div>
		<div class="rightt"><label><input class="checkbox" name="" type="checkbox" value="" checked="checked">白色</label><input name="" type="text" value="5199" style=" width:170px"><b>元</b></div>
	</li>
	<li>
		<div class="leftt"></div>
		<div class="rightt"><label><input class="checkbox" name="" type="checkbox" value="" checked="checked">红色</label><input name="" type="text" value="5199" style=" width:170px"><b>元</b></div>
	</li>
 * @return
 */
function loadProductAttr(channelGoodsId){
	var htmlResult = "";
	var paramData = "channelGoodsId="+channelGoodsId;
	$.ajax({
		url : rootPath + '/saleChannel/loadProductAttrByChannelGoodsId.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : paramData,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				var bigProductObject = {};
				var productId;//商品id
				var productArray = [];//外层大数组
				for(var i = 0;i < result.list.length;i++){
					var tempObject = result.list[i];
					if(i == 0){//如果第一次循环
						productId = tempObject.productId;
						productArray.push(tempObject.attrVal);
					}else{
						var productObject = {};
						//否则判断上一个的productId与当前元素的productId是否一致
						if(productId == tempObject.productId){//如果一致
							productArray.push(tempObject.attrVal);
							bigProductObject[productId] = productArray.join(" ");
						}else{
							productId = tempObject.productId;
							productArray = [];
							productArray.push(tempObject.attrVal);
							bigProductObject[productId] = productArray.join(" ");
						}
						bigProductObject[productId] = productArray.join(" ");
					}
				}
				if(bigProductObject){
					var index = 0;
					var goodsPrice;
					for(var p in bigProductObject){
						for(var i = 0;i < result.list.length;i++){
							var tempObject = result.list[i];
							if(tempObject.productId == p){
								goodsPrice = tempObject["goodsPrice"];
								break;
							}
						}
						var divLabel = "销售价格：";
						if(index == 0){
							firstProductId = p;
						}else{
							divLabel = "";
						}
						htmlResult += "<li><div class=\"leftt\">"+divLabel+"</div>";
						htmlResult += "<div class=\"rightt\"><label><input class=\"checkbox\" name=\"chkGoodsSku\" type=\"checkbox\" value=\""+p+"\" checked=\"checked\" onclick=\"return false;\" style=\"display:none;\">"+bigProductObject[p]+"</label>"+
							"<input id=\"txtGoodsName"+p+"\" name=\"txtGoodsName"+p+"\" type=\"text\" value=\""+goodsPrice+"\" style=\" text-align:right;width:80px;border: 0px;\" readonly />&nbsp;元</div>";
						htmlResult += "</li>";
						
						//如果为合约机(显示出条件筛选的部分层)
						if(currentExtMarkCode == contractTerminalExtMarkCode){
							var skuProductObject = {};
							skuProductObject.productId = p;
							skuProductObject.productAttrVal = bigProductObject[p];
							selectedSkuProductObjectArray.push(skuProductObject);
						}
						index++;
					}
				}
				
				//如果为合约机
				if(currentExtMarkCode == contractTerminalExtMarkCode){
					showDivCondition();
					//loadContractPlanProduct(firstProductId);//加载第一个sku(终端货品)的合约计划
					//$("#spanSku"+firstProductId).addClass("on");
				}
			}
		},
		error : function(result){
			//$.messager.alert("提示","加载终端对应的sku属性失败.");
			$.dialog.alert("加载终端对应的sku属性失败.",function(){});
		}
	});
	return htmlResult;
}

/**
 * 遍历出productId合约计划对应的货品(可能多个)
 * @param productId 终端productId
 * @return
 */
function loadContractPlanProduct(productId){
	var paramData = "productId="+productId+"&channelGoodsId="+channelGoodsId;
	$.ajax({
		url : rootPath + '/saleChannel/loadContractPlanProductByChannelGoodsId.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : paramData,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				packageObjectArray = [];
				//遍历pmProduct(每个元素中有pmProduct,pmAttrValList)
				packageTypeObjectArray = [];
				packageLimitObjectArray = [];
				for(var i = 0;i < result.list.length;i++){
					var pmProductObject = result.list[i];
					if(pmProductObject && pmProductObject.pmProduct && pmProductObject.pmAttrValList){
						//遍历pmAttrValList(合约类型与合约时长)
						for(var j = 0;j < pmProductObject.pmAttrValList.length;j++){
							var pmAttrValObject = pmProductObject.pmAttrValList[j];
							packageObjectArray.push(pmAttrValObject);
							if(pmAttrValObject.extMarkCode == wcsAttrPackageType){//合约计划
								packageTypeObjectArray.push(pmAttrValObject);
							}else if(pmAttrValObject.extMarkCode == wcsAttrPackageLimit){//合约期限
								packageLimitObjectArray.push(pmAttrValObject);
							}
						}
						
					}
				}
				
				//分别构造合约计划类型选项复选框(<label style="margin:4px 50px 0 0;"><input class="checkbox" name="" type="checkbox" value="" checked="checked">存话费送手机</label>)
				/*var htmlResult = "";
				$("#divPreferentialActivity").html("");
				//遍历合约计划类型
				for(var i = 0;i < packageTypeObjectArray.length;i++){
					var packageTypeProductId = packageTypeObjectArray[i]["productId"];
					if(i == 0){
						loadPackagePlanLimitData(productId , packageTypeProductId , packageLimitObjectArray);
					}
					htmlResult += "<label style=\"margin:4px 50px 0 0;\"><input class=\"checkbox\" name=\"chkPackageType\" type=\"checkbox\" value=\""+
						packageTypeProductId+"\" checked=\"checked\">" + packageTypeObjectArray[i]["attrVal"] + "</label>";
				}
				$("#divPreferentialActivity").html(htmlResult);
				
				//注删合约计划类型复选框的点击事件
				$("input[name=chkPackageType]").click(function(e){
					loadPackagePlanLimitData(productId , $(this).val() , packageLimitObjectArray);
					$(this).attr("checked",true);
				});*/
				
				/*构造合约计划类型复选框(<div class="lefttext">合约类型</div>
            	<div class="righttext">
                	<span><label><input name="" type="checkbox" value="" class="checkbox">预存话费送手机</label></span>
                    <span class="on"><label><input name="" type="checkbox" value="" class="checkbox" checked="checked">定制机购机送费</label></span>
                </div>)*/
				
				//新版本
				var htmlResult = "<div class=\"lefttext\">合约类型</div><div class=\"righttext\">";
				packageTypeObjectArray = distinctArray(packageTypeObjectArray , "attrVal");
	
				//合约类型的行数据删除及隐藏(及当前选中样式取消)
				$("#liContractType").html("");
				$("#liContractType > div > span").removeClass("on");
				$("#liContractType").hide();
				
				//合约期限的行数据删除及隐藏(及当前选中样式取消)
				$("#liContractLimit").html("");
				$("#liContractLimit > div > span").removeClass("on");
				$("#liContractLimit").hide();
				if(packageTypeObjectArray && packageTypeObjectArray.length > 0){
					//遍历合约计划类型
					for(var i = 0;i < packageTypeObjectArray.length;i++){
						htmlResult += "<span class=\"contract\" name=\"spanPlanType\" id=\"spanPlanType"+packageTypeObjectArray[i]["attrVal"]+"\" value=\""+packageTypeObjectArray[i]["attrVal"]+"\" title=\""+packageTypeObjectArray[i]["attrVal"]+"\"><label class=\"contract\"><input type=\"checkbox\" class=\"checkbox\" style=\"display:none;\" onclick=\"return false;\">&nbsp;&nbsp;&nbsp;&nbsp;"+packageTypeObjectArray[i]["attrVal"]+"</span>";
						if(i == 0){
							
						}
					}
					htmlResult += "</div>";
					$("#liContractType").html(htmlResult);
					$("#liContractType").show();
					
					//合约类型的点击事件加载显示对应的合约时长
					$("span[name=spanPlanType]").click(function(e){
	
						//给所选条件对象赋值
						selectedCondition["planTypeAttrVal"] = $(this).attr("value");
						
						//合约期限的行数据删除及隐藏(及当前选中样式取消),合约类型选中
						$("#liContractLimit").html("");
						$("#liContractLimit > div > span").removeClass("on");
						$("#liContractLimit").hide();
						
						$("#liContractType > div > span").addClass("on");
						//加载合约时长
						loadContractPlanLimit(productId , $(this).attr("value"));
	
						var currentObjectId = $(this).attr("id");
						//移除其它的span的选中样式
						$("span[name=spanPlanType]").each(function(e){
							if(currentObjectId != $(this).attr("id")){
								$(this).removeClass("on");
							}
						});
					});
				}
			}
		},
		error : function(result){
			//$.messager.alert("提示","加载合约计划失败.");
			$.dialog.alert("加载合约计划失败.",function(){});
		}
	});
}

/**
 * 根据终端货品编号与合约类型的货品编号加载合约计划时长,按渠道商品编辑页面的方式加载(高保)
 * @param productId 终端货品编号
 * @param planTypeAttrVal 合约类型的属性值
 * @return
 */
function loadContractPlanLimit(productId , planTypeAttrVal){
	htmlResult = "<div class=\"lefttext\">合约期限</div><div class=\"righttext\">";
	$("#liContractLimit").html("");
	//遍历所有合约计划类型与时长
	for(var i = 0;i < packageObjectArray.length;i++){
		//如果合约类型的属性值与数组中的属性相同时
		if(planTypeAttrVal == packageObjectArray[i]["attrVal"]){
			//根据合约类型的属性值匹配对应的productId数据
			var productId2 = packageObjectArray[i]["productId"];
			for(var j = 0;j < packageObjectArray.length;j++){
				/*<div class="lefttext">合约期限</div>
	            	<div class="righttext">
	                	<span><label><input name="" type="checkbox" value="" class="checkbox">12个月合约</label></span>
	                    <span class="on"><label><input name="" type="checkbox" value="" class="checkbox" checked="checked">24个月合约</label></span>
	                </div>*/
				if(productId2 == packageObjectArray[j]["productId"] && packageObjectArray[j].extMarkCode == wcsAttrPackageLimit){
					htmlResult += "<span id=\"spanPlanLimit"+productId2+"\" name=\"spanPlanLimit\" value=\""+productId2+"\" desc=\""+packageObjectArray[j]["attrVal"]+"\"><label><input type=\"checkbox\" class=\"checkbox\" style=\"display:none;\" onclick=\"return false;\">&nbsp;&nbsp;&nbsp;&nbsp;"+packageObjectArray[j]["attrVal"]+"</label></span>&nbsp;&nbsp;&nbsp;&nbsp;";
				}
			}
		}
	}
	htmlResult += "</div>";
	$("#liContractLimit").html(htmlResult);
	$("#liContractLimit").show();
	
	//合约时长的复选点击事件
	$("span[name=spanPlanLimit]").click(function(e){

		//给所选条件对象赋值
		selectedCondition["planLimitProductId"] = $(this).attr("value");
		selectedCondition["planLimitAttrVal"] = $(this).attr("desc");
		//console.log("selectedConditionObjectArray="+JSON.stringify(selectedConditionObjectArray));
		//console.log("selectedCondition="+JSON.stringify(selectedCondition));
		//如果之前未有加载过,则将条件对象加入至数组中
		if(!getDataObjectInArray(selectedConditionObjectArray ,selectedCondition["productId"] , selectedCondition["planLimitProductId"] , selectedCondition["planLimitAttrVal"])){
			var tempSelectedCondition = {};//用临时变量过渡一下,不能直接用全局变量,否则同一个对象会不断在变化
			for(var p in selectedCondition){
				tempSelectedCondition[p] = selectedCondition[p];
			}
			selectedConditionObjectArray.push(tempSelectedCondition);
			//console.log("selectedConditionObjectArray2="+JSON.stringify(selectedConditionObjectArray));
		}
		$(this).addClass("on");
		var currentObject = $(this);
		var productId2 = $(currentObject).attr("value");

		//构造套餐大表格
		//1.先查找指定条件数据div层与表格是否存在,存在则将其展示,否则重新加载
		var productIdGroup = productId + splitSymbol + productId2;
		var foundElements = $("#divPackageAll").find("#tblPackage" + productIdGroup);
		if(foundElements && foundElements.length > 0){
			$("#divPackageAll").find("#tblPackage" + productIdGroup).show();
		}else{
			loadPackageProductHight(saleGoodsId , productId , productId2);
		}

		//移除其它的span的选中样式
		$("span[name=spanPlanLimit]").each(function(e){
			if($(currentObject).attr("id") != $(this).attr("id")){
				$(this).removeClass("on");
			}
		});
		iframePageAutoHeight();//自动调整高度
	});
}

function loadPackagePlanLimitData(productId , packageTypeProductId , packageLimitObjectArray){
	var htmlResult = "";
	$("#ulContractPlan").html("");
	
	//遍历合约计划时长(<li class="on"><label><input name="" type="checkbox" value="" checked="checked">12个月合约</label></li>)
	var matched = 0;
	for(var i = 0;i < packageLimitObjectArray.length;i++){
		var classStyle = "";
		if(matched == 0){
			classStyle = "class=\"on\"";
		}
		var packagePlanLimitproductId = packageLimitObjectArray[i]["productId"];
		//判断合约类型货品productId与对应的合约时长的货品id是否一致,一致的才加入
		if(packageTypeProductId == packagePlanLimitproductId){
			
			htmlResult += "<li "+classStyle+"><label><input name=\"chkPackageLimit\" type=\"checkbox\" value=\""+packagePlanLimitproductId+"\" checked=\"checked\">"+
			packageLimitObjectArray[i]["attrVal"]+"</label></li>";
			//默认加载第一个合约计划时长对应的套餐计划
			loadPackageProduct(channelGoodsId , productId , packagePlanLimitproductId);
			if(matched == 0){
				
			}
			matched = 1;
		}
	}
	$("#ulContractPlan").html(htmlResult);
	//合约时长的复选点击事件
	$("input[name=chkPackageLimit]").click(function(e){
		$(this).attr("checked",true);
		var currentObject = $(this);
		var productId2 = $(this).val();
		if($(this).attr("checked")){
			loadPackageProduct(channelGoodsId , productId , productId2);
		}
	});
}

/**
 * 加载套餐,按渠道商品编辑页面的方式加载
 * @param saleGoodsId 销售商品编号
 * @param productId1 SKU终端货品
 * @param productId2 合约期限对应的产品编号
 * @return
 */
function loadPackageProductHight(saleGoodsId , productId1 , productId2){
	//selectedCondition;//所选条件的json对象,详细属性参考变量定义
	var defaultSelectedStr = "checked=\"checked\"";
	//console.log("selectedCondition2="+JSON.stringify(selectedCondition));
	var packageProductName = window.parent.document.getElementById("spanGoodsName").innerText + 
		" " + selectedCondition["productAttrVal"] + " " + selectedCondition["planTypeAttrVal"] + 
		" " + selectedCondition["planLimitAttrVal"];
	var productIdGroup = productId1 + splitSymbol + productId2;//两个产品id的组合,确保唯一性
	var htmlResult = "<div class=\"contText\"><div id=\"divPackage"+productIdGroup+"\" class=\"ttit\">";
	htmlResult += "<strong>"+packageProductName+"</strong><a href=\"javascript:void(0);\" title=\"隐藏/展开\" style=\"width:80px;\" onclick=\"showOrHide('tblPackage"+productIdGroup+"')\" class=\"deleteCloss\">隐藏/展开</a>";
	//htmlResult += "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0);\" title=\"删除\" onclick=\"removeELementByIds('tblPackage"+productIdGroup+"','divPackage"+productIdGroup+"')\" class=\"deleteCloss\">删除</a>";
	htmlResult += "</div>";
	htmlResult += "<table class=\"packageTableStyle\" id=\"tblPackage"+productIdGroup+"\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
	htmlResult += "<tr><th>套餐月费</th><th>月返还</th><th>手机款</th><th>入网返还</th><th>预存款</th><th>是否推荐</th></tr>";
	var paramData = "saleGoodsId="+saleGoodsId+"&productId1="+productId1+"&productId2="+productId2;
	$.ajax({
		url : rootPath + '/sale/loadPackageProductBySaleGoodsId.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : paramData,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				var pmProductObject;
				for(var i = 0;i < result.list.length;i++){
					pmProductObject = result.list[i];
					htmlResult += "<tr>"+
						"<td>"+pmProductObject["monthFee"]+ " " + pmProductObject["planType"]+"</td>"+
						"<td>"+pmProductObject["monthPresentFee"]+"</td>"+
						"<td>"+pmProductObject["phoneFee"]+"</td>"+
						"<td>"+pmProductObject["netReturnFee"]+"</td>"+
						"<td>"+pmProductObject["preDeposit"]+"</td>"+
						"<td><input type=\"checkbox\" id=\"chkRecommended"+(productIdGroup+splitSymbol+pmProductObject["goodsId"])+"\" name=\"chkRecommended\" value=\""+pmProductObject["goodsId"]+"\" "+defaultSelectedStr+" onclick=\"return false;\"/></td></tr>";
				}
			}
			
		},error : function(result){
			//$.messager.alert("提示","加载合约计划失败.");
			$.dialog.alert("加载合约计划失败.",function(){});
		}
	});
	htmlResult += "</table></div>";
	var existsPackageData = $("#divPackageAll").html();
	//console.log("existsPackageData="+existsPackageData);
	//console.log("htmlResult="+htmlResult);
	$("#divPackageAll").html(htmlResult + existsPackageData);
	iframePageAutoHeight();//自动调整高度
}

/**
 * 加载套餐(之前的函数,不再使用,使用上一个函数loadPackageProductHight)
 * @param selectedClass
 * @param selectedBrand
 * @param selectedModel
 * @param selectedMall
 * @param productId1
 * @param productId2
 * @return
 */
function loadPackageProduct(channelGoodsId , productId1 , productId2){
	var htmlResult = "<tr><th>套餐月费</th><th>月返还</th><th>手机款</th><th>入网返还</th><th>预存款</th>"+
			    "<th>是否推荐</th><td style=\"display:none;\">标记</td></tr>";
	var paramData = "channelGoodsId="+channelGoodsId+"&productId1="+productId1+"&productId2="+productId2;
	$.ajax({
		url : rootPath + '/saleChannel/loadPackageProductByChannelGoodsId.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : paramData,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				var pmProductObject;
				for(var i = 0;i < result.list.length;i++){
					pmProductObject = result.list[i];
					htmlResult += "<tr>"+
						"<td>"+pmProductObject["monthFee"]+ " " + pmProductObject["planType"]+"</td>"+
						"<td>"+pmProductObject["monthPresentFee"]+"</td>"+
						"<td>"+pmProductObject["phoneFee"]+"</td>"+
						"<td>"+pmProductObject["netReturnFee"]+"</td>"+
						"<td>"+pmProductObject["preDeposit"]+"</td>"+
						"<td align=\"center\"><input type=\"checkbox\" name=\"chkRecommended\" value=\""+pmProductObject["goodsId"]+"\" checked=\"true\" /></td>"+
						"<td align=\"center\" style=\"background-color: #FFFFFF;display:none;\"><select><option value\"1\">无</option><option value\"2\">热销</option><option value\"3\">0元购</option></select></td></tr>";
				}
				
				//绑定是否推荐的复选框
				$("input[name=chkRecommended]").click(function(){
					$(this).attr("checked",true);
				});
			}
		},error : function(result){
			//$.messager.alert("提示","加载合约计划失败.");
			$.dialog.alert("加载合约计划失败.",function(){});
		}
	});
	$("#tblPackage > tbody").remove();
	$("#tblPackage").html(htmlResult);
}

/**
 * 去除数组的相同元素
 * @param objectArray
 * @param field
 * @return
 */
function distinctArray(objectArray , field1,field2){
	var newArray = [];
	for(var i = 0;i < objectArray.length;i++){
		var obj = objectArray[i];
		if(i == 0){
			newArray.push(obj);
		}else{
			if(!existInArray(newArray , obj , field1,field2)){
				newArray.push(obj);
			}
		}
	}
	return newArray;
}

/**
 * 判断指定属性的值是否在数组中存在
 * @param dataArray
 * @param field1
 * @param field2
 * @return
 */
function existInArray(dataArray , dataObject , field1 , field2){
	var exists = false;
	for(var i = 0;i < dataArray.length;i++){
		var obj = dataArray[i];
		if(obj[field1] == dataObject[field1] && obj[field2] == dataObject[field2]){
			exists = true;
			break;
		}
	}
	return exists;
}

//最小的商品价格
var smallestSalePrice;

/**
 * 拼接商品属性的json对象(渠道销售商品变为一级元素数组)
 */
function getGoodsPropertyJsonData(){
	var packageGoodsIdArray = [];//套餐合约的货品
	//遍历套餐合约的"是否推荐"
	$("input[name=chkRecommended]").each(function(item){
		if($(this).attr("checked")){
			packageGoodsIdArray.push($(this).val());
		}
	});
	
	var goodsDataArray = [];
	//遍历销售价格sku属性货品
	$("input[name=chkGoodsSku]").each(function(item){
		if($(this).attr("checked")){
			var val = $(this).val();//复选框的值
			var goodsPrice = $("#txtGoodsName"+val).val();//对应价格文本框的值

			//如果销售价格变量为空
			if(!smallestSalePrice){
				smallestSalePrice = goodsPrice;
			}else{
				if(goodsPrice < smallestSalePrice){
					smallestSalePrice = goodsPrice;
				}
			}
			var oneGoodsDataArray = [];//单个货品数组
			for(var i = 0;i < packageGoodsIdArray.length;i++){
				var salChannelGoodsListObj = {
					goodsId:packageGoodsIdArray[i],
					goodsPrice:goodsPrice
				}
				goodsDataArray.push(salChannelGoodsListObj);
			}
		}
	});
	//console.log(allGoodsDataArray);
	return allGoodsDataArray;
}

/**
 * 对name相同的其它复选框对象取消选择
 */
function cancelSelectOther(checkboxName , currentValue){
	$("input[name="+checkboxName+"]").each(function(item){
		if($(this).val() != currentValue){
			//$(this).attr("checked",false);
		}
	});
}

/**
 * iframe框架页面高度自适应
 */
function iframePageAutoHeight(){
	parent.document.getElementById("frmGoods").style.height=document.body.scrollHeight; 
}

// 活动详情
function toDetail(actId) {
    $.dialog({
        title : '活动详情',
        content : "url:actext/getDetail.do?actId=" + actId,
        width : 800,
        height : 500,
        lock : true,
        cancelVal : '关闭',
        cancel : true
    })
}