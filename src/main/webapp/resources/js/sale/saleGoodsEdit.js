//记录图片文件的对象
var selectedFileArray = [];

var currentAccessType;//当前点击的接入方式
var lastAccessType;//上一次点击的接入方式

var currentShowPhotoIndex = -1;//当前显示图片的起始位置号(从0开始)
var currentShowPhotoIndexEnd = -1;//当前显示图片的结束位置号(从0开始)
var photeNumberPerPage = 1;//图片每次移动张数
var showColumns = 5;
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
			//$.messager.alert("Prompt","Failed to load the SKU properties corresponding to the terminal.");
			$.dialog.alert("加载终端对应的sku属性失败.",function(){});
		}
	});
	return htmlResult;
}

/**
 * 根据加载的相册构造图片表格
 * @param photoList
 * @param hideFileInput 是否隐藏文件上传
 * @return
 */
function fillPhotoTable(photoList , markType , saleGoodsId){
	//console.log("fillPhotoTable selectedFileArray="+JSON.stringify(selectedFileArray));
/*<li style="width: 125px;" onmousemove="show('div2')" onmouseout="hide('div2')">
		        	<div class="ban" id="div2" style="display: none;">
		            	<div class="delete"><a href="javascript:void(0);" class="delete_icon1"></a></div>
		                <div class="leftrightben">
		                	<a href="javascript:void(0);" class="forl"></a>
		                    <a href="javascript:void(0);" class="forr"></a>
		                </div>
		            </div>
		        	<img src="../images/photo/photo_1.png">
		        </li>
		        */
	var htmlResult = "";
	//显示的div总个数理论上无上限,但只显示4个(最右边一个为上传文件,另三个为已存在文件数,其余的全部隐藏)
	var length = (photoList && photoList.length) ? photoList.length : 0;
	
	htmlResult += "<li style=\"width:20px;font-weight:bold;cursor:pointer;\" onclick=\"leftPhoto(false ,'"+markType+"','"+saleGoodsId+"');\"><center style=\"margin-top:50px;\">&lt;</center></li>";
	//如果不需要显示现有的图片
	if(length > 0){
		var checkedStyle = "";//设置默认
		var displayStyle = "";
		var tempFirstShowPhotoIndex = -1;//临时变量,第一张显示的图片的索引位置号,循环结束后赋值给全局变量
		var tempLastShowPhotoIndex = -1;//临时变量,最后一张显示的图片的索引位置号,循环结束后赋值给全局变量
		for(var j = 0;j < length;j++){//循环
			var photoObject = photoList[j];
			var photoPath = photoObject.photoPath;
			var photoId = photoObject.photoId;
			var photoName = photoObject.photoName;
			var isDefault = photoObject.isDefault;
			var showFlag = photoObject.showFlag;
			if(isDefault && isDefault == defaultCheckedYes){
				checkedStyle = "checked=\"true\"";
			}else{
				checkedStyle = "";
			}
			if(showFlag && showFlag == defaultCheckedYes){
				if(tempFirstShowPhotoIndex == -1){
					tempFirstShowPhotoIndex = j;
				}else{
					//tempFirstShowPhotoIndex = () ? : ;
				}
				tempLastShowPhotoIndex = j;
				displayStyle = "";
			}else{
				displayStyle = "display:none;";
			}
			if(photoId && photoPath){
				htmlResult += "<li style=\"width: 125px;" + displayStyle + "\" onmousemove=\"show('divPhoto"+photoId+"')\">";
				htmlResult += "<div class=\"ban\" id=\"divPhoto"+photoId+"\" style=\"display: none;\" onmousemove=\"show('divPhoto"+photoId+"')\" onmouseout=\"hide('divPhoto"+photoId+"')\">";
					//htmlResult += "<div class=\"delete\"><a href=\"javascript:void(0);\" class=\"delete_icon1\" onclick=\"\"></a></div>";
					htmlResult += "<div class=\"leftrightben\">";
					//如果不为详情,则放开默认与删除按钮
					if(!hideFileInput){
						htmlResult += "<a href=\"javascript:void(0);\" class=\"aSetDefault\" title=\"Set as default\"><label class=\"forl2\" style=\"cursor:pointer\"><input type=\"radio\" name=\"radioPhoto\" "+checkedStyle+" onclick=\"setDefaultPhoto("+photoId+")\"></label></a>";
						htmlResult += "<a href=\"javascript:void(0);\" class=\"forr2\" onclick=\"deletePhoto("+photoId+",'"+markType+"','"+saleGoodsId+"');\"></a>";
					}
					htmlResult += "</div>";
				htmlResult += "</div><img photoId=\""+photoId+"\" name=\"goodsPhoto\" src=\""+imageAccessPath + "/" + photoPath + "\" photoId=\""+photoId+"\" photoPath=\""+photoPath+"\" photoName=\""+photoName+"\" markId=\""+saleGoodsId+"\" markType=\""+markType+"\" isDefault=\""+isDefault+"\" showFlag=\""+showFlag+"\"></li>";
			}
		}
		currentShowPhotoIndex = tempFirstShowPhotoIndex;
		currentShowPhotoIndexEnd = tempLastShowPhotoIndex;
	}else{
		if(hideFileInput){//如果无图片并且为详情页面,则显示无图片的图片
			htmlResult += "<li style=\"width: 125px;" + displayStyle + "\" onmousemove=\"show('divPhoto"+photoId+"')\">";
			htmlResult += "<div class=\"ban\" id=\"divPhoto"+photoId+"\" style=\"display: none;\" onmousemove=\"show('divPhoto"+photoId+"')\" onmouseout=\"hide('divPhoto"+photoId+"')\">";
				//htmlResult += "<div class=\"delete\"><a href=\"javascript:void(0);\" class=\"delete_icon1\" onclick=\"\"></a></div>";
				htmlResult += "<div class=\"leftrightben\"></div>";
			htmlResult += "</div><img photoId=\""+photoId+"\" src=\""+rootPath + "/resources/images/nopic.jpg\"></li>";
		}
	}
	if(!hideFileInput){
		htmlResult += "<li style=\"width: 125px;\"><center><input type=\"file\" name=\"photoFile\" style=\"width:70px;\" onchange=\"uploadFile(this , '" +markType + "' , '" +saleGoodsId + "');\" /></center></li>";
	}
	htmlResult += "<li style=\"width:20px;font-weight:bold;cursor:pointer;\" onclick=\"rightPhoto(false ,'"+markType+"','"+saleGoodsId+"');\"><center style=\"margin-top:50px;\">&gt;</center></li>";
	$("#ulPhoto").html("");
	$("#ulPhoto").html(htmlResult);
	
	/**此处为生产机延迟加载*/
	if(length > 0){
		for(var j = 0;j < length;j++){//循环
			if(j==(length-1)){
				var photoObject0 = photoList[j];
				var photoPath0 = photoObject0.photoPath;
				var photoId0=photoObject0.photoId;
				setTimeout("$('#"+photoId0+"').attr('src','"+imageAccessPath+"' + '/' + '"+photoPath0+"');",2000);
			}
		}
	}
}

/**
 * 删除图片
 * @param photoId 图片id
 * @param markType 类型
 * @param saleGoodsId 商品编号
 * @return
 */
function deletePhoto(photoId , markType , saleGoodsId){
	selectedFileArray = getCurrentSelectedFileArray();
	//console.log("deletePhoto before selectedFileArray="+JSON.stringify(selectedFileArray));
	var newSelectedFileArray = [];
	if(selectedFileArray && selectedFileArray.length > 0){
		var isDefaultPhoto = false;
		for(var i = 0;i < selectedFileArray.length;i++){
			var tempObject = selectedFileArray[i];
			if(photoId != tempObject["photoId"]){
				newSelectedFileArray.push(tempObject);
			}else{
				//如果删除的图片为默认图片,则第一个图片设置为默认
				if(tempObject["isDefault"] == defaultCheckedYes){
					isDefaultPhoto = true;
				}
			}
		}
		if(isDefaultPhoto){//如果删除的图片为默认图片
			selectedFileArray = [];
			for(var i = 0;i < newSelectedFileArray.length;i++){
				var tempObject = newSelectedFileArray[i];
				if(i == 0){
					tempObject["isDefault"] = defaultCheckedYes;
				}
				selectedFileArray.push(tempObject);
			}
		}else{//如果删除的图片不为默认图片
			selectedFileArray = newSelectedFileArray;
		}
	}
	//console.log("deletePhoto after selectedFileArray="+JSON.stringify(selectedFileArray));
	currentShowPhotoIndexEnd = currentShowPhotoIndexEnd - 1;
	fillPhotoTable(selectedFileArray , markType , saleGoodsId);
}

/**
 * 图片向左翻页显示
 * @param linkFirst 是否链至第一张
 * @param markType 类型
 * @param saleGoodsId 商品编号
 * @return
 */
function leftPhoto(linkFirst , markType , saleGoodsId){
	//当前显示图片起止号currentShowPhotoIndex,currentShowPhotoIndexEnd每次切换个数photeNumberPerPage,总数三个参数selectedFileArray.length,只显示数量(其它设置不可见)showColumns
	selectedFileArray = getCurrentSelectedFileArray();
	//console.log("leftPhoto selectedFileArray="+JSON.stringify(selectedFileArray));
	if(selectedFileArray && selectedFileArray.length > 0){
		var newSelectedFileArray = [];
		if(currentShowPhotoIndex <= 0){//到底首端
			//$.messager.alert("Prompt","This is the first picture!");
			$.dialog.alert("已经是第一张图片!",function(){});
		}else{
			if(linkFirst){
				currentShowPhotoIndex = 0;
			}else{
				currentShowPhotoIndex = currentShowPhotoIndex - 1;
			}
			currentShowPhotoIndexEnd = currentShowPhotoIndex + showColumns;
			currentShowPhotoIndexEnd = (currentShowPhotoIndexEnd > selectedFileArray.length - 1) ? (selectedFileArray.length - 1) : currentShowPhotoIndexEnd;
			for(var i = 0;i < selectedFileArray.length;i++){
				var tempObject = selectedFileArray[i];
				if(i >= currentShowPhotoIndex && i < currentShowPhotoIndexEnd){
					tempObject["showFlag"] = defaultCheckedYes;
				}else{
					tempObject["showFlag"] = defaultCheckedNo;
				}
				newSelectedFileArray.push(tempObject);
			}
			selectedFileArray = newSelectedFileArray;
			fillPhotoTable(selectedFileArray , markType , saleGoodsId);
		}
	}else{
		//$.messager.alert("Prompt","No pictures, please upload!");
		$.dialog.alert("暂无图片,请先上传!",function(){});
	}
}

/**
 * 图片向右翻页显示
 * @param linkLast 是否链至最后一张
 * @param markType 类型
 * @param saleGoodsId 商品编号
 * @return
 */
function rightPhoto(linkLast , markType , saleGoodsId){
	//当前显示图片起止号currentShowPhotoIndex,currentShowPhotoIndexEnd每次切换个数photeNumberPerPage,总数三个参数selectedFileArray.length,只显示数量(其它设置不可见)showColumns
	selectedFileArray = getCurrentSelectedFileArray();
	if(selectedFileArray && selectedFileArray.length > 0){
		if(currentShowPhotoIndexEnd == selectedFileArray.length - 1 && !linkLast){//到达末端
			//$.messager.alert("Prompt","This is the last picture!");
			$.dialog.alert("已经是最后一张图片!",function(){});
		}else{//可移动个数(即最终移动个数)
			var newSelectedFileArray = [];
			if(linkLast){
				currentShowPhotoIndexEnd = selectedFileArray.length - 1;
			}else{
				currentShowPhotoIndexEnd = currentShowPhotoIndexEnd + 1;
			}
			currentShowPhotoIndex = currentShowPhotoIndexEnd - showColumns + 1;
			currentShowPhotoIndex = currentShowPhotoIndex < 0 ? 0 : currentShowPhotoIndex;
			for(var i = 0;i < selectedFileArray.length;i++){
				var tempObject = selectedFileArray[i];
				if(i >= (currentShowPhotoIndex + photeNumberPerPage - 1) && i < (currentShowPhotoIndex + photeNumberPerPage + showColumns - 1)){
					tempObject["showFlag"] = defaultCheckedYes;
				}else{
					tempObject["showFlag"] = defaultCheckedNo;
				}
				newSelectedFileArray.push(tempObject);
			}
			selectedFileArray = newSelectedFileArray;
			fillPhotoTable(selectedFileArray , markType , saleGoodsId);
		}
	}else{
		//$.messager.alert("Prompt","No pictures, please upload!");
		$.dialog.alert("暂无图片,请先上传!",function(){});
	}
}

/**
 * 设置为默认图片
 * @param photoId
 * @return
 */
function setDefaultPhoto(photoId){
	/*var newSelectedFileArray = [];
	if(selectedFileArray && selectedFileArray.length > 0){
		for(var i = 0;i < selectedFileArray.length;i++){
			var tempObject = selectedFileArray[i];
			if(selectedFileArray[i]["photoId"] != photoId){
				tempObject["isDefault"] = defaultCheckedNo;
			}else{
				tempObject["isDefault"] = defaultCheckedYes;
			}
			newSelectedFileArray.push(tempObject);
		}
	}
	selectedFileArray = newSelectedFileArray;*/
	$("img[name=goodsPhoto]").each(function(item){
		$(this).attr("isDefault",defaultCheckedNo);
	});
	$("img[photoId="+photoId+"]").attr("isDefault",defaultCheckedYes);
	//console.log("setDefaultPhoto selectedFileArray="+JSON.stringify(selectedFileArray));
	//fillPhotoTable(selectedFileArray);
}

/**
 * 上传文件
 * @param fileElement
 * @return
 */
function uploadFile(fileElement , markType , saleGoodsId){
	if(fileElement.value && fileElement.value != ''){
		$("#photoFileForm").ajaxSubmit({
			type: "post",
			url: rootPath + '/sale/uploadFileRequest.do',
			dataType:"json",
			success: function (result) {
				if(result){
					if(result.flag == 'true'){
						//$.messager.alert("Prompt","Upload successfully!");
						if(result.filePath){
							selectedFileArray = getCurrentSelectedFileArray();
							//构造json
							selectedFileArray.push({
								markType:saleGoodsMarkType,
								isDefault:selectedFileArray.length > 0 ? defaultCheckedNo : defaultCheckedYes,
								showFlag : defaultCheckedYes,
								photoId:result.photoId,
								photoPath:result.filePath,
								photoName:result.fileName
							});
							//console.log("upload selectedFileArray="+JSON.stringify(selectedFileArray));
							fillPhotoTable(selectedFileArray , markType , saleGoodsId);
							rightPhoto(true ,markType,saleGoodsId);//上传成功一条,则图片移至最后一张
						}
					}else{
						//$.messager.alert("Prompt","Upload failed!");
						fileElement.value = '';
						$.dialog.alert(result.msg,function(){});
					}
				}
			},
			error : function(result){
				//$.messager.alert("Prompt","Background program error!");
				$.dialog.alert("后台程序出错!",function(){});
			}
		});
	}
	return false;
}

/**
 * 取得当前商品图片对象
 * @return
 */
function getCurrentSelectedFileArray(){
	var currentSelectedFileArray = [];
	$("img[name=goodsPhoto]").each(function(item){
		currentSelectedFileArray.push({
			photoId:$(this).attr("photoId"),
			photoPath:$(this).attr("photoPath"),
			photoName:$(this).attr("photoName"),
			markId:$(this).attr("markId"),
			markType:$(this).attr("markType"),
			isDefault:$(this).attr("isDefault"),
			showFlag:$(this).attr("showFlag")
		});
	});
	return currentSelectedFileArray;
}

/**
 * 保存商品
 * @return
 */
function saveGoods(saleGoodsDataArray){
	$.ajax({
		contentType : 'application/json',
		url : rootPath + '/sale/saveSaleGoods.do',
		type : 'post',
		dataType : 'json',
		async : false,
		data : JSON.stringify(submitDataArray),
		success : function(result){
			if(result){
				//$.messager.alert("Prompt",result.msg);
				$.dialog.alert(result.msg,function(){});
				window.location.href = rootPath + "/sale/visitSaleGoodsMainPage.do";
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to save the product.");
			$.dialog.alert("保存商品失败.",function(){});
		}
	});
}

/**
 * 转向至商品发布
 * @return
 */
function goodsToPublish(saleGoodsDataArray){
	$.ajax({
		contentType : 'application/json',
		url : rootPath + '/sale/saveSaleGoods.do',
		type : 'post',
		dataType : 'json',
		async : false,
		data : JSON.stringify(saleGoodsDataArray),
		success : function(result){
			if(result){
				//$.messager.alert("Prompt",result.msg);
				$.dialog.alert(result.msg,function(){});
				if(result && result["flag"] == "true"){
					var saleGoodsIds = result["saleGoodsIds"];
					var accessTypes = result["accessTypes"];
					window.location.href = rootPath + "/sale/toPubSaleGoods.do?saleGoodsId="+saleGoodsIds+"&accessType="+accessTypes;
				}
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to save the product.");
			$.dialog.alert("保存商品失败.",function(){});
		}
	});
}