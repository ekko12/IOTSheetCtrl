
/**
 * 加载终端对应的sku属性
 * json串:如{list:[{"attrVal":"红色","productId":6},{"attrVal":"16G","productId":6},{"attrVal":"黑色","productId":7},{"attrVal":"16G","productId":7}]}
 * <div><label><input type="checkbox" name="chkGoodsBlack">黑色</label>&nbsp;&nbsp;
	<input type="text" id="txtGoodsName" name="txtGoodsNameBlack" style="width:200px;height:25px;" />&nbsp;元</div>
 * @return
 */
function loadProductAttr(selectedClass , selectedBrand , selectedModel , selectedMall){
	var htmlResult = "";
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+selectedModel+"&mallCode="+selectedMall;
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
						//否则判断上一个的productId与当前元素的productId是否一致
						if(productId == tempObject.productId){//如果一致
							productArray.push(tempObject.attrVal);
							bigProductObject[productId] = productArray.join(" ");
						}else{
							productArray = [];
							productArray.push(tempObject);
							bigProductObject[productId] = productArray.join(" ");
						}
					}
				}
				if(bigProductObject){
					for(var p in bigProductObject){
						htmlResult += "<div><label style=\"cursor: pointer;\"><input type=\"checkbox\" name=\"chkGoodsSku\" value=\""+p+"\" desc=\""+bigProductObject[p]+"\">&nbsp;&nbsp;"+bigProductObject[p]+"</label>&nbsp;&nbsp;"+
							"<input type=\"text\" id=\"txtGoodsName"+p+"\" name=\"txtGoodsName"+p+"\" style=\"width:200px;height:25px;\" />&nbsp;元</div>";
					}
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
 * @param selectedClass
 * @param selectedBrand
 * @param selectedModel
 * @param selectedMall
 * @param productId
 * @return
 */
function loadContractPlanProduct(selectedClass , selectedBrand , selectedModel , selectedMall , productId){
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+selectedModel+"&mallCode="+selectedMall+"&productId="+productId;
	$.ajax({
		url : rootPath + '/sale/loadContractPlanProduct.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : paramData,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				//遍历pmProduct(每个元素中有pmProduct,pmAttrValList)
				var packageTypeArray = [];
				var packageLimitArray = [];
				for(var i = 0;i < result.list.length;i++){
					var pmProductObject = result.list[i];
					if(pmProductObject && pmProductObject.pmProduct && pmProductObject.pmAttrValList){
						//遍历pmAttrValList(合约类型与合约时长)
						for(var j = 0;j < pmProductObject.pmAttrValList.length;j++){
							var pmAttrValObject = pmProductObject.pmAttrValList[j];
							if(pmAttrValObject.extMarkCode == 'package_type'){//合约计划
								packageTypeArray.push(pmAttrValObject);
							}else if(pmAttrValObject.extMarkCode == 'package_limit'){//合约期限
								packageLimitArray.push(pmAttrValObject);
							}
						}
						
					}
				}
				
				//分别构造复选框(<label><input type="checkbox" />存话费送手机</label>与<label><input type="checkbox" />12个月合约</label>)
				var htmlResult = "";
				$("#packagePlanTypeTd").html("");
				packageTypeArray = distinctArray(packageTypeArray , "attrValOptionsValue" , "extMarkCode");
				//遍历合约计划类型
				for(var i = 0;i < packageTypeArray.length;i++){
					htmlResult += "<label style=\"cursor: pointer;\"><input type=\"checkbox\" name=\"chkPackageType\" value=\""+packageTypeArray[i]["valId"]+"\" />&nbsp;"+packageTypeArray[i]["attrVal"]+"</label>&nbsp;&nbsp;";
				}
				$("#packagePlanTypeTd").html(htmlResult);
				
				htmlResult = "";
				$("#packagePlanLimitTd").html("");
				packageLimitArray = distinctArray(packageLimitArray , "attrValOptionsValue" , "extMarkCode");
				//遍历合约计划时长
				for(var i = 0;i < packageLimitArray.length;i++){
					htmlResult += "<label style=\"cursor: pointer;\"><input type=\"checkbox\" name=\"chkPackageLimit\" value=\""+packageLimitArray[i]["productId"]+"\" />&nbsp;"+packageLimitArray[i]["attrVal"]+"</label>&nbsp;&nbsp;";
				}
				$("#packagePlanLimitTd").html(htmlResult);
				//合约时长的复选点击事件
				$("input[name=chkPackageLimit]").click(function(e){
					var currentObject = $(this);
					var productId2 = $(this).val();
					if($(this).attr("checked")){
						loadPackageProduct(selectedClass , selectedBrand , selectedModel , selectedMall , productId , productId2);
						cancelSelectOther("chkPackageLimit" , productId2);
					}
				});
			}
		},
		error : function(result){
			//$.messager.alert("提示","加载合约计划失败.");
			$.dialog.alert("加载合约计划失败.",function(){});
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
 * @return
 */
function loadPackageProduct(selectedClass , selectedBrand , selectedModel , selectedMall , productId1 , productId2){
	var htmlResult = "<tr style=\"background-color: #CCCCCC;\"><td width=\"14%\">套餐月费</td><td width=\"14%\">月返还</td><td width=\"14%\">手机款</td>" +
		"<td width=\"14%\">入网返还</td><td width=\"14%\">预存款</td><td width=\"14%\">是否推荐</td><td style=\"display:none;\">标记</td></tr>";
	var paramData = "goodsClassId="+selectedClass+"&goodsBrandId="+selectedBrand+"&goodsModelId="+selectedModel+"&mallCode="+selectedMall+"&productId1="+productId1+"&productId2="+productId2;
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
						"<td width=\"14%\" style=\"background-color: #CCCCCC;\">"+pmProductObject["pmProduct"]["productName"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\">"+pmProductObject["pmGoods"]["monthPresentFee"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\">"+pmProductObject["pmGoods"]["phoneFee"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\">"+pmProductObject["pmGoods"]["netReturnFee"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\">"+pmProductObject["pmGoods"]["preDeposit"]+"</td>"+
						"<td width=\"14%\" style=\"background-color: #FFFFFF;\" align=\"center\"><input type=\"checkbox\" name=\"chkRecommended\" value=\""+pmProductObject["pmProduct"]["goodsId"]+"\" /></td>"+
						"<td align=\"center\" style=\"background-color: #FFFFFF;display:none;\"><select><option value\"1\">无</option><option value\"2\">热销</option><option value\"3\">0元购</option></select></td></tr>";
				}
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

/**
 * 对name相同的其它复选框对象取消选择
 */
function cancelSelectOther(checkboxName , currentValue){
	$("input[name="+checkboxName+"]").each(function(item){
		if($(this).val() != currentValue){
			$(this).attr("checked",false);
		}
	});
}