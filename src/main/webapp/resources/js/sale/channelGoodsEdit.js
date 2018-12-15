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
		url : rootPath + '/saleChannel/loadProductAttr.do',
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

/**
 * 根据加载的相册构造图片表格
 * @param photoList
 * @param hideFileInput 是否隐藏文件上传
 * @return
 */
function fillPhotoTable(photoList , markType , channelGoodsId){
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
	if(!hideFileInput){
		htmlResult += "<li style=\"width:20px;font-weight:bold;cursor:pointer;\" onclick=\"leftPhoto(false ,'"+markType+"','"+channelGoodsId+"');\"><center style=\"margin-top:50px;\">&lt;</center></li>";
	}
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
						htmlResult += "<a href=\"javascript:void(0);\" class=\"aSetDefault\" title=\"设置为默认\"><label class=\"forl2\" style=\"cursor:pointer\"><input class=\"mg_l mg_t5\" type=\"radio\" name=\"radioPhoto\" "+checkedStyle+" onclick=\"setDefaultPhoto("+photoId+")\"></label></a>";
						htmlResult += "<a href=\"javascript:void(0);\" class=\"forr2\" onclick=\"deletePhoto("+photoId+" ,'"+markType+"','"+channelGoodsId+"')\"></a>";
					}
					htmlResult += "</div>";
				htmlResult += "</div><img name=\"goodsPhoto\" src=\""+imageAccessPath + "/" + photoPath + "\" photoId=\""+photoId+"\" photoPath=\""+photoPath+"\" photoName=\""+photoName+"\" markId=\""+channelGoodsId+"\" markType=\""+markType+"\" isDefault=\""+isDefault+"\" showFlag=\""+showFlag+"\"></li>";
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
			htmlResult += "</div><img src=\""+rootPath + "/resources/images/nopic.jpg\"></li>";
		}
	}
	if(!hideFileInput){
		htmlResult += "<li style=\"width: 125px;\"><center><input type=\"file\" name=\"photoFile\" style=\"width:70px;\" onchange=\"uploadFile(this , '" +markType + "' , '" +channelGoodsId + "');\" /></center></li>";
		htmlResult += "<li style=\"width:20px;font-weight:bold;cursor:pointer;\" onclick=\"rightPhoto(false ,'"+markType+"','"+channelGoodsId+"');\"><center style=\"margin-top:50px;\">&gt;</center></li>";
	}
	$("#ulPhoto").html("");
	$("#ulPhoto").html(htmlResult);
}

/**
 * 删除图片
 * @param photoId
 * @return
 */
function deletePhoto(photoId , markType , channelGoodsId){
	selectedFileArray = getCurrentSelectedFileArray();
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
	currentShowPhotoIndexEnd = currentShowPhotoIndexEnd - 1;
	fillPhotoTable(selectedFileArray , markType , channelGoodsId);
}

/**
 * 图片向左翻页显示
 * @param linkFirst 是否链至第一张
 * @return
 */
function leftPhoto(linkFirst , markType , channelGoodsId){
	//当前显示图片起止号currentShowPhotoIndex,currentShowPhotoIndexEnd每次切换个数photeNumberPerPage,总数三个参数selectedFileArray.length,只显示数量(其它设置不可见)showColumns
	//console.log("leftPhoto selectedFileArray="+JSON.stringify(selectedFileArray));
	selectedFileArray = getCurrentSelectedFileArray();
	if(selectedFileArray && selectedFileArray.length > 0){
		var newSelectedFileArray = [];
		if(currentShowPhotoIndex <= 0){//到底首端
			//$.messager.alert("提示","已经是第一张图片!");
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
			fillPhotoTable(selectedFileArray , markType , channelGoodsId);
		}
	}else{
		//$.messager.alert("提示","暂无图片,请先上传!");
		$.dialog.alert("暂无图片,请先上传!",function(){});
	}
}

/**
 * 图片向右翻页显示
 * @param linkLast 是否链至最后一张
 * @return
 */
function rightPhoto(linkLast , markType , channelGoodsId){
	//当前显示图片起止号currentShowPhotoIndex,currentShowPhotoIndexEnd每次切换个数photeNumberPerPage,总数三个参数selectedFileArray.length,只显示数量(其它设置不可见)showColumns
	selectedFileArray = getCurrentSelectedFileArray();
	if(selectedFileArray && selectedFileArray.length > 0){
		if(currentShowPhotoIndexEnd == selectedFileArray.length - 1 && !linkLast){//到达末端
			//$.messager.alert("提示","已经是最后一张图片!");
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
			fillPhotoTable(selectedFileArray , markType , channelGoodsId);
		}
	}else{
		//$.messager.alert("提示","暂无图片,请先上传!");
		$.dialog.alert("暂无图片,请先上传!",function(){});
	}
}

/**
 * 设置为默认图片
 * @param photoId
 * @return
 */
function setDefaultPhoto(photoId){
	$("img[name=goodsPhoto]").each(function(item){
		$(this).attr("isDefault",defaultCheckedNo);
	});
	$("img[photoId="+photoId+"]").attr("isDefault",defaultCheckedYes);
}

/**
 * 上传文件
 * @param fileElement
 * @return
 */
function uploadFile(fileElement , markType , channelGoodsId){
	if(fileElement.value && fileElement.value != ''){
		$("#photoFileForm").ajaxSubmit({
			type: "post",
			url: rootPath + '/sale/uploadFileRequest.do',
			dataType:"json",
			success: function (result) {
				if(result){
					if(result.flag == 'true'){
						//$.messager.alert("提示","图片上传成功!");
						if(result.photoPath){
							selectedFileArray = getCurrentSelectedFileArray();
							//构造json
							selectedFileArray.push({
								markType:channelGoodsMarkType,
								isDefault:selectedFileArray.length > 0 ? defaultCheckedNo : defaultCheckedYes,
								showFlag : defaultCheckedYes,
								photoId:result.photoId,
								photoPath:result.photoPath,
								photoName:result.photoName
							});
							//console.log("upload selectedFileArray="+JSON.stringify(selectedFileArray));
							fillPhotoTable(selectedFileArray , markType , channelGoodsId);
							rightPhoto(true , markType , channelGoodsId);//上传成功一条,则图片移至最后一张
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
 * 取得当前支付方式对象
 * @return
 */
function getCurrentSelectedPayArray(){
	var currentSelectedObjectArray = [];
	$("input[name=chkPay]:checked").each(function(item){
		currentSelectedObjectArray.push({
			payModeCode:$(this).val()
		});
	});
	return currentSelectedObjectArray;
}

/**
 * 取得当前标签对象
 * @return
 */
function getCurrentSelectedLabelArray(){
	var currentSelectedObjectArray = [];
	$("input[name=chkLabel]:checked").each(function(item){
		currentSelectedObjectArray.push({
			labelId:$(this).val()
		});
	});
	return currentSelectedObjectArray;
}

/**
 * 取得当前提货方式对象
 * @return
 */
function getCurrentSelectedDeliveryArray(){
	var currentSelectedObjectArray = [];
	$("input[name=chkDelivery]:checked").each(function(item){
		currentSelectedObjectArray.push({
			deliveryCode:$(this).val()
		});
	});
	return currentSelectedObjectArray;
}

/**
 * 保存商品
 * @return
 */
function saveGoods(saleGoodsDataArray){
	$.ajax({
		contentType : 'application/json',
		url : rootPath + '/saleChannel/saveChannelGoods.do',
		type : 'post',
		dataType : 'json',
		async : false,
		data : JSON.stringify(saleGoodsDataArray),
		success : function(result){
			if(result){
				//$.messager.alert("提示",result.msg);
				$.dialog.alert(result.msg,function(){});
			}
			window.location.href = rootPath + '/saleChannel/index.do';
		},
		error : function(result){
			//$.messager.alert("提示","保存商品失败.");
			$.dialog.alert("保存商品失败.",function(){});
		}
	});
}

/**
 * 取消
 * @return
 */
function cancelSave(){
	window.open('','_self','');
	window.close();
}