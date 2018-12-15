/*
 * 此js文件为各类型(合约机、祼机、上网卡等)销售商品明细的新增页面调用
 */
//定义当前销售商品品类类型及各种销售商品品类类型的编码(未完待续)
var currentExtMarkCode;
var terminalExtMarkCode;
var contractTerminalExtMarkCode;
var netWorkExtMarkCode;

//合约数组、合约计划与合约时长数据
var packageObjectArray = [];
var packageTypeObjectArray = [];
var packageLimitObjectArray = [];

//合约机相关的属性
var selectedSkuProductObjectArray = [];//已选中的sku终端货品

/**
 * 加载终端对应的sku属性(调的老接口的过时方法)
 * json串:如{list:[{"attrVal":"红色","productId":6},{"attrVal":"16G","productId":6},{"attrVal":"黑色","productId":7},{"attrVal":"16G","productId":7}]}
 * <div><label><input type="checkbox" name="chkGoodsBlack">黑色</label>&nbsp;&nbsp;
	<input type="text" id="txtGoodsName" name="txtGoodsNameBlack" style="width:200px;height:25px;" />&nbsp;元</div>
	@param selectedClass
	@param selectedBrand
	@param selectedModel
	@param selectedMall
	@param extMarkCode
 * @return
 */
function loadProductAttrOld(selectedClass , selectedBrand , selectedModel , selectedMall , extMarkCode, selectedLanguage){
	var htmlResult = "";
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+
		selectedModel+"&mallCode="+selectedMall+"&extMarkCode="+extMarkCode+"&languageName="+selectedLanguage;
	$.ajax({
		url : rootPath + '/sale/loadProductAttr.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : paramData,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				var bigProductObject = {};
				var productId;//商品id
				var goodsId;//商品id
				var productAttrArray = [];//外层大数组
				for(var i = 0;i < result.list.length;i++){
					var tempObject = result.list[i];
					
					if(i == 0){//如果第一次循环
						productId = tempObject.productId;
						goodsId = tempObject.goodsId;
						productAttrArray.push(tempObject.attrVal);
					}else{
						if(extMarkCode == contractTerminalExtMarkCode){
							//否则判断上一个的productId与当前元素的productId是否一致
							if(productId == tempObject.productId){//如果一致
								productAttrArray.push(tempObject.attrVal);
								bigProductObject[productId] = productAttrArray.join(" ");
							}else{
								productId = tempObject.productId
								productAttrArray = [];
								productAttrArray.push(tempObject.attrVal);
								bigProductObject[productId] = productAttrArray.join(" ");
							}
						}else if(extMarkCode == terminalExtMarkCode){
							//否则判断上一个的productId与当前元素的productId是否一致
							if(goodsId == tempObject.goodsId){//如果一致
								productAttrArray.push(tempObject.attrVal);
								bigProductObject[goodsId] = productAttrArray.join(" ");
							}else{
								goodsId = tempObject.goodsId
								productAttrArray = [];
								productAttrArray.push(tempObject.attrVal);
								bigProductObject[goodsId] = productAttrArray.join(" ");
							}
						}
					}
				}
				if(bigProductObject){
					if(extMarkCode == contractTerminalExtMarkCode){
						for(var p in bigProductObject){
							var skuProductObject = bigProductObject[p];
							/*skuProductObject.productId = p;
							skuProductObject.productName = bigProductObject[p];
							selectedSkuProductObjectArray.push(skuProductObject);*/
							htmlResult += "<div><label style=\"cursor: pointer;\"><input type=\"checkbox\" id=\"chkGoodsSku"+p+"\" name=\"chkGoodsSku\" value=\""+p+"\" desc=\""+bigProductObject[p]+"\">&nbsp;&nbsp;"+bigProductObject[p]+"</label>&nbsp;&nbsp;"+
								"<input type=\"text\" id=\"txtGoodsName"+p+"\" name=\"txtGoodsName"+p+"\" style=\"width:200px;height:25px;\" />&nbsp;Dollars</div>";
						}
					}else if(extMarkCode == terminalExtMarkCode){
						for(var p in bigProductObject){
							htmlResult += "<div><label style=\"cursor: pointer;\"><input type=\"checkbox\" id=\"chkGoodsSku"+p+"\" name=\"chkGoodsSku\" value=\""+p+"\" desc=\""+bigProductObject[p]+"\">&nbsp;&nbsp;"+bigProductObject[p]+"</label>&nbsp;&nbsp;"+
								"<input type=\"text\" id=\"txtGoodsName"+p+"\" name=\"txtGoodsName"+p+"\" style=\"width:200px;height:25px;\" />&nbsp;Dollars</div>";
						}
					}
				}
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to load the SKU properties corresponding to the terminal.");
			$.dialog.alert("Failed to load the SKU properties corresponding to the terminal.",function(){});
		}
	});
	return htmlResult;
}

/**
 * 加载终端对应的sku属性
 * json串:如{list:[{"attrVal":"红色","productId":6},{"attrVal":"16G","productId":6},{"attrVal":"黑色","productId":7},{"attrVal":"16G","productId":7}]}
 * <div><label><input type="checkbox" name="chkGoodsBlack">黑色</label>&nbsp;&nbsp;
	<input type="text" id="txtGoodsName" name="txtGoodsNameBlack" style="width:200px;height:25px;" />&nbsp;元</div>
	@param selectedClass
	@param selectedBrand
	@param selectedModel
	@param selectedMall
	@param extMarkCode
	@param selectedLanguage
 * @return
 */
function loadProductAttr(selectedClass , selectedBrand , selectedModel , selectedMall , extMarkCode, selectedLanguage){
	var htmlResult = "";
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+
		selectedModel+"&mallCode="+selectedMall+"&extMarkCode="+extMarkCode+"&languageName="+selectedLanguage;
	$.ajax({
		url : rootPath + '/sale/loadProductAttr.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : paramData,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				for(var i = 0;i < result.list.length;i++){
					var tempObject = result.list[i];
					var productName = tempObject["productName"];
					var actExternalSysList = tempObject["actExternalSysList"];
					if(extMarkCode == contractTerminalExtMarkCode){
						var productId = tempObject["productId"];
						htmlResult += "<div><label style=\"cursor: pointer;\"><input type=\"checkbox\" id=\"chkGoodsSku"+productId+"\" name=\"chkGoodsSku\" value=\""+productId+"\" desc=\""+productName+"\">&nbsp;&nbsp;"+productName+"</label>&nbsp;&nbsp;"+
						"<input type=\"text\" id=\"txtGoodsName"+productId+"\" name=\"txtGoodsName"+productId+"\" style=\"width:200px;height:25px;\" />&nbsp;Dollars";
						 for (var a = 0; a < actExternalSysList.length; a++) {
						 	htmlResult += "<label style='margin-left:20px;'><a href='javascript:void(0);' onclick='toDetail(\"" + actExternalSysList[a]["actId"] + "\")'>" + actExternalSysList[a]["actName"] + "</a></label>";
                        }
                        htmlResult +="</div>";
					}else if(extMarkCode == terminalExtMarkCode){
						var goodsId = tempObject["goodsId"];
						htmlResult += "<div><label style=\"cursor: pointer;\"><input type=\"checkbox\" id=\"chkGoodsSku"+goodsId+"\" name=\"chkGoodsSku\" value=\""+goodsId+"\" desc=\""+productName+"\">&nbsp;&nbsp;"+productName+"</label>&nbsp;&nbsp;"+
						"<input type=\"text\" id=\"txtGoodsName"+goodsId+"\" name=\"txtGoodsName"+goodsId+"\" style=\"width:200px;height:25px;\" />&nbsp;Dollars";
						 for (var a = 0; a < actExternalSysList.length; a++) {
                            htmlResult += "<label style='margin-left:20px;'><a href='javascript:void(0);' onclick='toDetail(\"" + actExternalSysList[a]["actId"] + "\")'>" + actExternalSysList[a]["actName"] + "</a></label>";
                        }
                        htmlResult +="</div>";
					}
				}
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to load the SKU properties corresponding to the terminal.");
			$.dialog.alert("Failed to load the SKU properties corresponding to the terminal.",function(){});
		}
	});
	return htmlResult;
}

/**
 * 遍历出productId合约计划对应的货品(可能多个)
 * @param selectedClass
 * @param selectedBrand
 * @param selectedModel
 * @param selectedMall
 * @param productId 终端货品编号
 * @param selectedLanguage
 * @return
 */
function loadContractPlanProduct(selectedClass , selectedBrand , selectedModel , selectedMall , productId, selectedLanguage){
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+selectedModel+"&mallCode="+selectedMall+"&productId="+productId+"&languageName="+selectedLanguage;
	$.ajax({
		url : rootPath + '/sale/loadContractPlanProduct.do',
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
				
				//构造合约计划类型复选框(<label><input type="checkbox" />存话费送手机</label>与<label><input type="checkbox" />12个月合约</label>)
				var htmlResult = "";
				$("#packagePlanTypeTd").html("");
				packageTypeObjectArray = distinctArray(packageTypeObjectArray , "attrVal");
				//遍历合约计划类型
				for(var i = 0;i < packageTypeObjectArray.length;i++){
					htmlResult += "<label style=\"cursor: pointer;\"><input type=\"checkbox\" name=\"chkPackageType\" value=\""+packageTypeObjectArray[i]["attrVal"]+"\" />&nbsp;"+packageTypeObjectArray[i]["attrVal"]+"</label>&nbsp;&nbsp;";
				}
				$("#packagePlanTypeTd").html(htmlResult);
				
				//合约类型的点击事件加载显示对应的合约时长
				$("input[name=chkPackageType]").click(function(e){
					loadContractPlanLimit(productId , $(this).val());
				});
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to load the contract plan .");
			$.dialog.alert("Failed to load the contract plan .",function(){});
		}
	});
}

/**
 * 根据终端货品编号与合约类型的货品编号加载合约计划时长
 * @param productId 终端货品编号
 * @param planTypeAttrVal 合约类型的属性值
 * @return
 */
function loadContractPlanLimit(productId , planTypeAttrVal){
	htmlResult = "";
	$("#packagePlanLimitTd").html("");
	//遍历所有合约计划类型与时长
	for(var i = 0;i < packageObjectArray.length;i++){
		//如果合约类型的属性值与数组中的属性相同时
		if(planTypeAttrVal == packageObjectArray[i]["attrVal"]){
			//根据合约类型的属性值匹配对应的productId数据
			var productId2 = packageObjectArray[i]["productId"];
			for(var j = 0;j < packageObjectArray.length;j++){
				if(productId2 == packageObjectArray[j]["productId"] && packageObjectArray[j].extMarkCode == wcsAttrPackageLimit){
					htmlResult += "<label style=\"cursor: pointer;\"><input type=\"checkbox\" name=\"chkPackageLimit\" value=\""+productId2+"\" />&nbsp;"+packageObjectArray[j]["attrVal"]+"</label>&nbsp;&nbsp;";
				}
			}
		}
	}
	$("#packagePlanLimitTd").html(htmlResult);
	//合约时长的复选点击事件
	$("input[name=chkPackageLimit]").click(function(e){
		var currentObject = $(this);
		var productId2 = $(this).val();
		if($(this).attr("checked")){
			loadPackageProduct(goodsClassId , goodsBrandId , goodsModelId , mallCode , productId , productId2);
			cancelSelectOther("chkPackageLimit" , productId2);
		}
	});
}

/**
 * 加载套餐
 * @param selectedClass
 * @param selectedBrand
 * @param selectedModel
 * @param selectedMall
 * @param productId1
 * @param productId2
 * @param selectedLanguage
 * @return
 */
function loadPackageProduct(selectedClass , selectedBrand , selectedModel , selectedMall , productId1 , productId2, selectedLanguage){
	var htmlResult = "<tr style=\"background-color: #CCCCCC;\"><td width=\"14%\">Package monthly fee</td><td width=\"14%\">Monthly return</td><td width=\"14%\">Device payment</td>" +
		"<td width=\"14%\">Registration return</td><td width=\"14%\">Prepaid</td><td width=\"14%\"><label><input type=\"checkbox\" id=\"allSelectRecommended\" />Whether to recommend</label></td><td style=\"display:none;\">Mark</td></tr>";
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+selectedModel+"&mallCode="+selectedMall+"&productId1="+productId1+"&productId2="+productId2+"&languageName="+selectedLanguage;
	$.ajax({
		url : rootPath + '/sale/loadPackageProduct.do',
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
						"<td width=\"14%\" style=\"background-color: #CCCCCC;\">"+pmProductObject["monthFee"]+ " " + pmProductObject["planType"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\">"+pmProductObject["monthPresentFee"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\">"+pmProductObject["phoneFee"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\">"+pmProductObject["netReturnFee"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\">"+pmProductObject["preDeposit"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\" align=\"center\"><input type=\"checkbox\" name=\"chkRecommended\" value=\""+pmProductObject["goodsId"]+"\" /></td>"+
						"<td align=\"center\" style=\"background-color: #FFFFFF;display:none;\"><select><option value\"1\">None</option><option value\"2\">Hot selling</option><option value\"3\">Free for purchase</option></select></td></tr>";
				}
			}
			
		},error : function(result){
			//$.messager.alert("Prompt","Failed to load the contract plan .");
			$.dialog.alert("Failed to load the contract plan .",function(){});
		}
	});
	$("#tblPackage > tbody").remove();
	$("#tblPackage").html(htmlResult);
	
	//是否推荐-全选
	$("#allSelectRecommended").click(function(e){
		var checked = $(this).attr("checked");
		$("input[name=chkRecommended]").each(function(e){
			$(this).attr("checked" , checked ? true : false)
		});
	});
}

/**
 * 加载终端对应的sku属性(该商品对应有货品的,则只选中相应有货品的复选框),高保切割页面所用的方法
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
 * @param selectedClass
 * @param selectedBrand
 * @param selectedModel
 * @param selectedMall
 * @param extMarkCode
 * @param selectedLanguage
 * @return
 */
function loadProductAttrHight(selectedClass , selectedBrand , selectedModel , selectedMall , extMarkCode, selectedLanguage){
	var htmlResult = "";
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+
	selectedModel+"&mallCode="+selectedMall+"&extMarkCode="+extMarkCode+"&languageName="+selectedLanguage;
	$.ajax({
		url : rootPath + '/sale/loadProductAttr.do',
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
						htmlResult += "<div class=\"rightt\"><label><input class=\"checkbox\" name=\"chkGoodsSku\" type=\"checkbox\" value=\""+p+"\" checked=\"checked\">"+bigProductObject[p]+"</label>"+
							"<input id=\"txtGoodsName"+p+"\" name=\"txtGoodsName"+p+"\" type=\"text\" value=\""+goodsPrice+"\" style=\" width:170px;\" readonly />&nbsp;Dollars</div>";
						htmlResult += "</li>";
						index++;
					}
				}
				
				//如果为合约机
				if(currentExtMarkCode == contractTerminalExtMarkCode){
					loadContractPlanProduct(firstProductId);//加载第一个sku(终端货品)的合约计划
				}
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to load the SKU properties corresponding to the terminal.");
			$.dialog.alert("Failed to load the SKU properties corresponding to the terminal.",function(){});
		}
	});
	return htmlResult;
}

/**
 * 遍历出productId合约计划对应的货品(可能多个),高保页面用的方法
 * @param selectedClass
 * @param selectedBrand
 * @param selectedModel
 * @param selectedMall
 * @param productId 终端货品编号
 * @param selectedLanguage
 * @return
 */
function loadContractPlanProductHight(selectedClass , selectedBrand , selectedModel , selectedMall , productId, selectedLanguage){
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+selectedModel+"&mallCode="+selectedMall+"&productId="+productId+"&languageName="+selectedLanguage;
	$.ajax({
		url : rootPath + '/sale/loadContractPlanProduct.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : paramData,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				//遍历pmProduct(每个元素中有pmProduct,pmAttrValList)
				packageTypeObjectArray = [];
				packageLimitObjectArray = [];
				for(var i = 0;i < result.list.length;i++){
					var pmProductObject = result.list[i];
					if(pmProductObject && pmProductObject.pmProduct && pmProductObject.pmAttrValList){
						//遍历pmAttrValList(合约类型与合约时长)
						for(var j = 0;j < pmProductObject.pmAttrValList.length;j++){
							var pmAttrValObject = pmProductObject.pmAttrValList[j];
							if(pmAttrValObject.extMarkCode == wcsAttrPackageType){//合约计划
								packageTypeObjectArray.push(pmAttrValObject);
							}else if(pmAttrValObject.extMarkCode == wcsAttrPackageLimit){//合约期限
								packageLimitObjectArray.push(pmAttrValObject);
							}
						}
						
					}
				}
				
				//分别构造合约计划类型选项复选框(<label style="margin:4px 50px 0 0;"><input class="checkbox" name="" type="checkbox" value="" checked="checked">存话费送手机</label>)
				var htmlResult = "";
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
				});
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to load the contract plan .");
			$.dialog.alert("Failed to load the contract plan .",function(){});
		}
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
			loadPackageProduct(saleGoodsId , productId , packagePlanLimitproductId);
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
			loadPackageProduct(saleGoodsId , productId , productId2);
		}
	});
}

/**
 * 加载套餐
 * @param selectedClass
 * @param selectedBrand
 * @param selectedModel
 * @param selectedMall
 * @param productId1
 * @param productId2
 * @param selectedLanguage
 * @return
 */
function loadPackageProduct(selectedClass , selectedBrand , selectedModel , selectedMall , productId1 , productId2, selectedLanguage){
	var htmlResult = "<tr><th>Package monthly fee</th><th>Monthly return</th><th>Device payment</th><th>Registration return</th><th>Prepaid</th>"+
			    "<th>Whether to recommend</th><td style=\"display:none;\">Mark</td></tr>";
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+selectedModel+"&mallCode="+selectedMall+"&productId1="+productId1+"&productId2="+productId2+"&languageName="+selectedLanguage;
	$.ajax({
		url : rootPath + '/sale/loadPackageProduct.do',
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
						"<td align=\"center\" style=\"background-color: #FFFFFF;display:none;\"><select><option value\"1\">None</option><option value\"2\">Hot selling</option><option value\"3\">Free for purchase</option></select></td></tr>";
				}
				
				//绑定是否推荐的复选框
				$("input[name=chkRecommended]").click(function(){
					$(this).attr("checked",true);
				});
			}
		},error : function(result){
			//$.messager.alert("Prompt","Failed to load the contract plan .");
			$.dialog.alert("Failed to load the contract plan .",function(){});
		}
	});
	$("#tblPackage > tbody").remove();
	$("#tblPackage").html(htmlResult);
}

/**
 * 按对象指定属性名去除数组的相同对象
 * @param objectArray
 * @param field1
 * @return
 */
function distinctArray(objectArray , field1){
	var newArray = [];
	for(var i = 0;i < objectArray.length;i++){
		var obj = objectArray[i];
		if(i == 0){
			newArray.push(obj);
		}else{
			if(!existInArray(newArray , obj , field1)){
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
function existInArray(dataArray , dataObject , field1){
	var exists = false;
	for(var i = 0;i < dataArray.length;i++){
		var obj = dataArray[i];
		if(obj[field1] == dataObject[field1]){
			exists = true;
			break;
		}
	}
	return exists;
}

//最小的商品价格(目前仅限合约机和裸机有用到)
var smallestSalePrice;
/**
 * 取选中的货品里最低的价格
 */
function getSmallestSalePrice(){
	return smallestSalePrice;
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
function iframePageAutoHeight(){//alert("document.body.scrollHeight="+document.body.scrollHeight);
	//parent.document.getElementById("frmGoods").style.height=document.body.scrollHeight;//适用于IE,firefox浏览器
	//$(parent.document.getElementById("frmGoods")).attr("height",document.body.scrollHeight);//适用于chrome浏览器
	$("#frmGoods",window.parent.document).attr("height",document.body.scrollHeight);//飞哥提供的写法(IE8完善,chrome稍欠缺)
	//alert(document.body.scrollHeight);
}

// 活动详情
function toDetail(actId) {
    $.dialog({
        title : 'Activity details',
        content : "url:actext/getDetail.do?actId=" + actId,
        width : 800,
        height : 500,
        lock : true,
        cancelVal : 'Close',
        cancel : true
    })
}

//校验正整数，用于虚拟币
function checkVirtualPrice(obj) {
	var vPrice = obj.value;
	var reg1 =  /^\d+$/;
	if(vPrice != null && vPrice != ''){
		if(vPrice.trim().match(reg1) == null){
			$.dialog.alert("海币数量必须是正整数!",function(){});
			obj.value = "";
			return;
		}
		
	}
}
