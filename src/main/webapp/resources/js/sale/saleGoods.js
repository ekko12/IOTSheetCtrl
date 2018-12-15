//工单上传的控制input
var generateFileInputHtml = function(imgId , labelId , spanId){ 
	return "<img width=\"140px\" height=\"100px\" id=\""+imgId+"\" src=\""+rootPath + "/upload.png\" /><br/><br/>" + 
	"<input imgId=\""+imgId+"\" type=\"file\" name=\"photoFile\" style=\"width:60px;\" value\"本地上传\" onchange=\"uploadFile(this);\" />"+
	"<label id=\""+labelId+"\" style=\"display:none;\"><input type=\"radio\" name=\"setDefault\" />默认</label>&nbsp;&nbsp;&nbsp;&nbsp;"+
	"<span id=\""+spanId+"\" imgId=\""+imgId+"\" style=\"cursor:pointer;display:none;\" onclick=\"deletePhoto();\">删除</span>";
}

//记录图片文件的对象
var selectedFileArray = [];

/*
 * 根据品类编号取得品牌数据列表
 * @param classId 品类编号
 * @return html:例如:<tr id=\"tr1\" value=\"1\" desc=\"中兴\"><td height=\"28px;\" style=\"cursor: pointer;\">中兴</td></tr>
 */
function loadBrandByClassId(classId){
	var htmlResult = "";
	$.ajax({
		url : rootPath + '/sale/getBrandListByClassId.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : "classId=" + classId,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				for(var i = 0;i < result.list.length;i++){
					var brandId = result.list[i].brandId;
					var brandName = result.list[i].brandName;
					htmlResult += "<tr id=\"tr"+brandId+"\" value=\""+brandId+"\" desc=\""+brandName+"\"><td height=\"28px;\" style=\"cursor: pointer;\">"+brandName+"</td></tr>";
				}
			}
		},
		error : function(result){
			//$.messager.alert("提示","加载品牌失败.");
			$.dialog.alert("加载品牌失败.",function(){});
		}
	});
	return htmlResult;
}

/*
 * 根据品牌编号取得品牌机型列表
 * @param brandId 品类编号
 * @return html:例如:<tr id=\"tr1\" value=\"1\" desc=\"中兴\"><td height=\"28px;\" style=\"cursor: pointer;\">中兴</td></tr>
 */
function loadModelByBrandId(brandId){
	var htmlResult = "";
	$.ajax({
		url : rootPath + '/sale/getModelListByBrandId.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : "brandId=" + brandId,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				for(var i = 0;i < result.list.length;i++){
					var modelId = result.list[i].modelId;
					var modelName = result.list[i].modelName;
					htmlResult += "<tr id=\"tr"+modelId+"\" value=\""+modelId+"\" desc=\""+modelName+"\"><td height=\"28px;\" style=\"cursor: pointer;\">"+modelName+"</td></tr>";
				}
			}
		},
		error : function(result){
			//$.messager.alert("提示","加载品牌型号失败.");
			$.dialog.alert("加载品牌型号失败.",function(){});
		}
	});
	return htmlResult;
}

/*
 * 根据品牌编号取得品牌机型列表
 * @param brandId 品类编号
 * @return html:例如:<tr><td height="28px;"><label><input type="radio" name="radioMall" value=""/> 沃货架</label></td></tr>
 */
function loadAllMall(){
	var htmlResult = "";
	$.ajax({
		url : rootPath + '/sale/getAllValidMallList.do',
		type : 'POST',
		dataType : 'json',
		async : false,//同步
		success : function(result){
			if(result && result.list && result.list.length > 0){
				var columns = 3;
				var length = result.list.length;
				var rows = Math.ceil(length/columns);
				var mod = length % columns;
				for(var i = 0;i < rows;i++){//循环行
					htmlResult += "<tr>";
					for(var j = 0;j < columns;j++){//循环列
						var mallCode = (result.list[i * columns + j]) ? result.list[i * columns + j].mallCode : null;
						var mallName = (result.list[i * columns + j]) ? result.list[i * columns + j].mallName : null;
						if(mallCode && mallName){
							htmlResult += "<td width=\""+(100/columns)+"%\" height=\"28px;\"><label style=\"cursor: pointer;\"><input type=\"radio\" name=\"radioMall\" value=\""+mallCode+"\" desc=\""+mallName+"\"/> "+mallName+"</label></td>";
						}else{
							htmlResult += "<td height=\"28px;\">&nbsp;</td>";
						}
					}
					htmlResult += "</tr>";
				}
			}
		},
		error : function(result){
			//$.messager.alert("提示","加载品牌型号失败.");
			$.dialog.alert("加载品牌型号失败.",function(){});
		}
	});
	return htmlResult;
}

/*
 * 根据商城code加载接入方式,对电脑版、手机版、pad版进行启/禁用配置控制
 * @param mallCode 商城编码
 */
function loadAccessTypeByMallCode(mallCode){
	$.ajax({
		url : rootPath + '/sale/loadAccessTypeByMallCode.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : "mallCode=" + mallCode,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				var findFirst = true;
				for(var i = 0;i < result.list.length;i++){
					var accessType = result.list[i]["accessType"];
					$("#chkAccessType" + accessType).attr("checked",true);
					$("#chkAccessType" + accessType).attr("disabled",false);
					if(findFirst){
						$("#aAccessType" + accessType).css("background-color","#FFFFFF");
						findFirst = false;
					}else{
						$("#aAccessType" + accessType).css("background-color","#F0F0F0");
					}
				}
			}
		},
		error : function(result){
			//$.messager.alert("提示","加载商城对应的接入方式失败.");
			$.dialog.alert("加载商城对应的接入方式失败.",function(){});
		}
	});
	
}

/**
 * 根据接入方式数组控制对应的选项卡(选项卡样式(背景色)、复选框启/禁用、是否当前)
 * @param accessTypeArray
 * @return
 */
function controlAccessType(accessTypeArray){
	if(accessTypeArray && accessTypeArray.length > 0){
		//1.先循环接入方式全局变量的map
		//2.再循环商城对应的接入方式
		var matched;
		for(var p in wcsAccessTypeMapJson){
			matched = false;
			for(var i = 0;i < accessTypeArray.length;i++){
				if(p.key == accessTypeArray[i]){
					matched = true;
				}
			}
			if(matched){
				$("#li" + p).css("class","liEnabledNotCurrent");
			}else{
				$("#li" + p).css("class","liEnabledNotCurrent");
			}
		}
	}else{
		//循环接入方式变量map
		for(var p in wcsAccessTypeMapJson){
			$("#li" + p.key).css("class","liDisabled");
		}
	}
}

/**
 * 加载终端对应的sku属性
 * @return
 */
function loadProductAttr(){
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
				for(var i = 0;i < result.list.length;i++){
					var modelId = result.list[i].modelId;
					var modelName = result.list[i].modelName;
					htmlResult += "<tr id=\"tr"+modelId+"\" value=\""+modelId+"\" desc=\""+modelName+"\"><td height=\"28px;\" style=\"cursor: pointer;\">"+modelName+"</td></tr>";
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


/*
 * 回到顶部
 */
function goTop(acceleration, time) {  
    acceleration = acceleration || 0.1;  
    time = time || 16;  
   
    var x1 = 0;  
    var y1 = 0;  
    var x2 = 0;  
    var y2 = 0;  
    var x3 = 0;  
    var y3 = 0;  
   
    if (document.documentElement) {  
        x1 = document.documentElement.scrollLeft || 0;  
        y1 = document.documentElement.scrollTop || 0;  
    }  
    if (document.body) {  
        x2 = document.body.scrollLeft || 0;  
        y2 = document.body.scrollTop || 0;  
    }  
    var x3 = window.scrollX || 0;  
    var y3 = window.scrollY || 0;  
   
    // 滚动条到页面顶部的水平距离   
    var x = Math.max(x1, Math.max(x2, x3));  
    // 滚动条到页面顶部的垂直距离   
    var y = Math.max(y1, Math.max(y2, y3));  
   
    // 滚动距离 = 目前距离 / 速度, 因为距离原来越小, 速度是大于 1 的数, 所以滚动距离会越来越小   
    var speed = 1 + acceleration;  
    window.scrollTo(Math.floor(x / speed), Math.floor(y / speed));  
   
    // 如果距离不为零, 继续调用迭代本函数   
    if(x > 0 || y > 0) {  
        var invokeFunction = "goTop(" + acceleration + ", " + time + ")";  
        window.setTimeout(invokeFunction, time);  
    }  
}

/**
 * 根据货品编号加载图片
 * @param markType
 * @param productId
 * @return
 */
function loadPhotoByProductId(markType , productId){
	$.ajax({
		url : rootPath + '/sale/loadPhotoByProductId.do',
		type : 'POST',
		dataType : 'json',
		async : false,
		data : "markType=" + markType + "&productId=" + productId,
		success : function(result){
			if(result && result.list && result.list.length > 0){
				fillPhotoTable(result.list);
			}
		},
		error : function(result){
			//$.messager.alert("提示","加载货品图片失败.");
			$.dialog.alert("加载货品图片失败.",function(){});
		}
	});
}

/**
 * 根据加载的相册构造图片表格
 * @param photoList
 * @return
 */
function fillPhotoTable(photoList){
/*<tr>
<td height="200" align="center"><img src="${ctxPath }/resources/images/sale/u33_normal.png" />
<br/><span>删除</span></td>
<td align="center"><img src="${ctxPath }/resources/images/sale/u33_normal.png" />
<br/><span>删除</span></td>
</tr>*/	
	var htmlResult = "";
	
	//表格总列数为图片数,但只显示4列(最右边一列为上传文件列,另三列为已存在文件数)
	var length = (photoList && photoList.length) ? photoList.length : 0;
	var showColumns = 3;
	
	htmlResult += "<tr align=\"center\"><td width=\"20\" align=\"center\">&lt;</td>";
	
	//如果不需要显示现有的图片
	if(length > 0){
		var setDefault = "";//设置默认
		var displayStyle = "";
		for(var j = 0;j < length;j++){//循环
			if(j == 0){
				setDefault = "checked=\"true\"";
			}else{
				setDefault = "";
			}
			if(j < showColumns){
				displayStyle = "";
			}else{
				displayStyle = "style=\"display:none;\"";
			}
			var photoPath = (photoList[j]) ? photoList[j].photoPath : null;
			var photoId = (photoList[j]) ? photoList[j].photoId : null;
			var photoName = (photoList[j]) ? photoList[j].photoName : null;
			if(photoId && photoPath){
				htmlResult += "<td width=\""+(96/(showColumns + 1))+"%\" "+displayStyle+">"+
				"<img id=\"imgId"+photoId+"\" width=\"140px\" height=\"100px\" src=\""+rootPath + photoPath + "\" /><br/><br/>"+
				"<label><input type=\"radio\" name=\"setDefault\" value=\""+photoId+"\" "+setDefault+" />默认</label>&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<span imgId=\"imgId"+photoId+"\" style=\"cursor:pointer;\" onclick=\"deletePhoto();\">删除</span></td>";
			}
			selectedFileArray.push({
				markType:saleGoodsMarkType,
				isDefault:setDefault.length > 0 ? "1" : "0",
				photoPath:photoPath,
				photoId:photoId,
				photoName:photoName
			});
		}
	}
	htmlResult += "<td width=\""+(96/(showColumns + 1))+"%\">" + generateFileInputHtml("imgIdUpload1" , "labelIdUpload1" , "spanUpload1") + "</td>";

	//不足3列,填充空列
	if(length < showColumns){
		for(var i = 0;i < (showColumns - length);i++){
			htmlResult += "<td width=\""+(96/(showColumns + 1))+"%\">&nbsp;</td>";
		}
	}
	
	htmlResult += "<td align=\"center\" width=\"20\">&gt;</td></tr>";
	$("#tblPhoto > tbody").remove();
	$("#tblPhoto").html(htmlResult);
}

/**
 * 上传文件
 * @param fileElement
 * @return
 */
function uploadFile(fileElement){
	/*$.ajaxFileUpload({
        url:rootPath + '/sale/uploadFile.action',
        secureuri:false,
        fileElementId:fileElement.id,
        dataType: 'json',
        success: function (data, status)
        {
          //如果文件上传成功
          //$.blockUI({message:data.msg});
        },
        error: function (data, status, e)
        {
          //$.blockUI({message:data.erro});
        }
    });*/

	//$("#photoFileForm").submit(function(){
		$("#photoFileForm").ajaxSubmit({
			type: "post",
			url: rootPath + '/sale/uploadFileRequest.do',
			dataType:"json",
			success: function (result) {
				if(result){
					if(result.flag == 'true'){
						//$.messager.alert("提示","图片上传成功!");
						$.dialog.alert("图片上传成功!",function(){});
						if(result.photoPath){
							$("#" + $(fileElement).attr("imgId")).attr("src" , rootPath + "/imagePath/" + result.photoPath);
							
							//构造json
							selectedFileArray.push({
								markType:saleGoodsMarkType,
								isDefault:selectedFileArray.length > 0 ? "0" : "1",
								photoPath:result.photoPath,
								photoName:result.photoName
							});
						}
					}else{
						//$.messager.alert("提示","图片上传失败!");
						$.dialog.alert("图片上传失败!",function(){});
					}
				}
			},
			error : function(result){
				//$.messager.alert("提示","后台程序报错!");
				$.dialog.alert("后台程序报错!",function(){});
			}
		});
		return false;
		
	//});
}

/**
 * 保存商品
 * @return
 */
function saveGoods(submitDataArray){
	//console.log(JSON.stringify(submitDataArray));
	$.ajax({
		contentType : 'application/json',
		url : rootPath + '/sale/saveSaleGoods.do',
		type : 'post',
		dataType : 'json',
		async : false,
		data : JSON.stringify(submitDataArray),
		success : function(result){
			if(result){
				//$.messager.alert("提示",result.msg);
				/*$.messager.confirm('提示','确定关机本窗口?',function(r){
					if(r){
						window.close();
					}
				});
				 */
				$.dialog.alert(result.msg,function(){});
				$.dialog.confirm('确定关闭本窗口?',function(){
					window.close();
				},function(){});
			}
		},
		error : function(result){
			//$.messager.alert("提示","保存商品失败.");
			$.dialog.alert("保存商品失败.",function(){});
		}
	});
}

/**
 * 转向至商品发布
 * @return
 */
function goodsToPublish(){
	saveGoods();//先保存
}

/**
 * 对name相同的其它复选框对象取消选择
 */
function cancelSelectOther(checkboxName){
	/*$("input[name="+checkboxName+"]").each(function(item){
		if($(item).attr("name") != checkboxName){
			$(item).attr("checked",false);
		}
	});*/
}