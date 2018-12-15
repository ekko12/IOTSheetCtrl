var currentAccessType;//当前点击的接入方式
var lastAccessType;//上一次点击的接入方式

var currentShowPhotoIndex = -1;//当前显示图片的起始位置(从0开始)
var currentShowPhotoIndexEnd = -1;//当前显示图片的结束位置
var photeNumberPerPage = 1;//每次切换的数量
var showColumns = 5;//显示的图片数量(多出的将隐藏)

//定义接入方式切换数组变量记录各个接入方式是否被切换过,以便于下次切换时进行记录,数据格式如:[{accessType:1,defaultFirst:true},{accessType:2,defaultFirst:false},...{accessType:3,defaultFirst:false}]
var accessTypeTabChangeArray = [];

//工单上传的控制input
var generateFileInputHtml = function(imgId , labelId , spanId){ 
	return "<img width=\"140px\" height=\"120px\" id=\""+imgId+"\" src=\""+rootPath + "/upload.png\" /><br/><br/>" + 
	"<input imgId=\""+imgId+"\" type=\"file\" name=\"photoFile\" style=\"width:72px;\" onchange=\"uploadFile(this);\" />"+
	"<label id=\""+labelId+"\" style=\"display:none;\"><input type=\"radio\" name=\"setDefault\" />Default</label>&nbsp;&nbsp;&nbsp;&nbsp;"+
	"<span id=\""+spanId+"\" imgId=\""+imgId+"\" style=\"cursor:pointer;display:none;\" onclick=\"deletePhoto();\">Delete</span>";
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
			//$.messager.alert("Prompt","Failed to save the product.");
			$.dialog.alert("Failed to save the product.",function(){});
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
			//$.messager.alert("Prompt","Failed to load Model .");
			$.dialog.alert("Failed to load Model .",function(){});
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
		data:'classId='+selectedClass+'&brandId='+selectedBrand+'&modelId='+selectedModel,
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
			//$.messager.alert("Prompt","Failed to load Model .");
			$.dialog.alert("Failed to load Model .",function(){});
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
					$("#liAccessType" + accessType).attr("validFlag","true");
					if(findFirst){
						currentAccessType = accessType;//第一次进来将第一个接入方式的值赋给当前接入方式变量
						lastAccessType = accessType;//第一次进来将第一个接入方式的值赋给上一个选择接入方式变量
						accessTypeTabChangeArray.push({accessType:currentAccessType , defaultFirst:true});//初次时调用时,让第一个标签置为true
						$("#liAccessType" + accessType).addClass("on");
						$("#aAccessType" + accessType).css("background-color","#FFFFFF");
						findFirst = false;
					}else{
						$("#aAccessType" + accessType).css("background-color","#F0F0F0");
					}
				}
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to load the access method corresponding to the website.");
			$.dialog.alert("Failed to load the access method corresponding to the website.",function(){});
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
					//var modelId = result.list[i].modelId;
					//var modelName = result.list[i].modelName;
					//htmlResult += "<tr id=\"tr"+modelId+"\" value=\""+modelId+"\" desc=\""+modelName+"\"><td height=\"28px;\" style=\"cursor: pointer;\">"+modelName+"</td></tr>";
					var productId = result.list[i].productId;
					var productName = result.list[i].productName;
					htmlResult += "<tr id=\"tr"+productId+"\" value=\""+productId+"\" desc=\""+productName+"\"><td height=\"28px;\" style=\"cursor: pointer;\">"+productName+"</td></tr>";
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
				fillPhotoTableHight(result.list);
			}
		},
		error : function(result){
			//$.messager.alert("Prompt","Failed to load the product picture.");
			$.dialog.alert("Failed to load the product picture.",function(){});
		}
	});
}

/**
 * 根据加载的相册构造图片表格(低保)
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
	var photeNumberPerPage = showColumns;//每次图片翻页时的个数
	htmlResult += "<tr align=\"center\"><td width=\"20\" align=\"center\" style=\"font-weight:bold;cursor:pointer;\" onclick=\"viewPhotoByPage("+(photeNumberPerPage*-1)+");\">&lt;</td>";
	
	var photoId = 0;
	//如果不需要显示现有的图片
	if(length > 0){
		var displayStyle = "";//是否显示
		var checkedStyle = "";//是否默认(是则选中)
		for(var j = 0;j < length;j++){//循环
			var photoPath = (photoList[j]) ? photoList[j].photoPath : null;
			photoId = (photoList[j]) ? photoList[j].photoId : null;
			var photoName = (photoList[j]) ? photoList[j].photoName : null;
			var isDefault = (photoList[j]) ? photoList[j].isDefault : null;
			var showFlag = (photoList[j]) ? photoList[j].showFlag : null;
			if(isDefault && isDefault == defaultCheckedYes){
				checkedStyle = " checked=\"true\"";
			}else{
				checkedStyle = "";
			}
			if(showFlag && showFlag == defaultCheckedYes){
				displayStyle = "";
			}else{
				displayStyle = "style=\"display:none;\"";
			}
			/*
			if(j < showColumns){
				displayStyle = "";
			}else{
				displayStyle = "style=\"display:none;\"";
			}*/
			
			htmlResult += "<td width=\""+(96/(showColumns + 1))+"%\" "+displayStyle+">"+
			"<img id=\"imgId"+photoId+"\" width=\"140px\" height=\"120px\" src=\""+imageAccessPath + "/" + photoPath + "\" title=\""+photoName+"\"/><br/><br/>"+
			"<label><input type=\"radio\" name=\"radioSetDefault\" value=\""+photoId+"\" "+checkedStyle+" onclick=\"setDefaultPhoto("+photoId+")\" />Default</label>&nbsp;&nbsp;&nbsp;&nbsp;"+
			"<span imgId=\"imgId"+photoId+"\" style=\"cursor:pointer;\" onclick=\"deletePhoto("+photoId+");\">Delete</span></td>";
			
		}
		photoId = photoId + 1;
	}
	htmlResult += "<td width=\""+(96/(showColumns + 1))+"%\" align=\"center\">" + generateFileInputHtml("imgIdUpload"+photoId , "labelIdUpload"+photoId , "spanUpload"+photoId) + "</td>";

	//不足3列,填充空列
	if(length < showColumns){
		for(var i = 0;i < (showColumns - length);i++){
			htmlResult += "<td width=\""+(96/(showColumns + 1))+"%\">&nbsp;</td>";
		}
	}
	
	htmlResult += "<td align=\"center\" width=\"20\" style=\"font-weight:bold;cursor:pointer;\" onclick=\"viewPhotoByPage("+(photeNumberPerPage)+");\">&gt;</td></tr>";
	$("#tblPhoto > tbody").remove();
	$("#tblPhoto").html(htmlResult);
}

/**
 * 根据加载的相册构造图片表格(高保)
 * @param photoList
 * @return
 */
function fillPhotoTableHight(photoList){
	var htmlResult = "";
	htmlResult += "<li style=\"width:20px;font-weight:bold;cursor:pointer;\" onclick=\"leftPhoto();\"><center style=\"margin-top:50px;\">&lt;</center></li>";
	//显示的div总个数理论上无上限,但只显示4个(最右边一个为上传文件,另三个为已存在文件数,其余的全部隐藏)
	var length = (photoList && photoList.length) ? photoList.length : 0;
	
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
						htmlResult += "<a href=\"javascript:void(0);\" class=\"aSetDefault\" title=\"Set as default\"><label class=\"forl2\" style=\"cursor:pointer\"><input class=\"mg_l mg_t5\" type=\"radio\" name=\"radioPhoto\" "+checkedStyle+" onclick=\"setDefaultPhoto("+photoId+")\"></label></a>";
						htmlResult += "<a href=\"javascript:void(0);\" class=\"forr2\" onclick=\"deletePhotoHight("+photoId+")\"></a>";
					htmlResult += "</div>";
				htmlResult += "</div><img id=\""+photoId+"\" name=\"goodsPhoto\" src=\""+imageAccessPath + "/" + photoPath + "\" photoId=\""+photoId+"\" photoPath=\""+photoPath+"\" photoName=\""+photoName+"\" markType=\""+saleGoodsMarkType+"\" isDefault=\""+isDefault+"\" showFlag=\""+showFlag+"\"></li>";
			}
		}
		currentShowPhotoIndex = tempFirstShowPhotoIndex;
		currentShowPhotoIndexEnd = tempLastShowPhotoIndex;
	}
	htmlResult += "<li style=\"width: 125px;\"><center><input type=\"file\" name=\"photoFile\" style=\"width:70px;\" onchange=\"uploadFile(this);\" /></center></li>";
	htmlResult += "<li style=\"width:20px;font-weight:bold;cursor:pointer;\" onclick=\"rightPhoto();\"><center style=\"margin-top:50px;\">&gt;</center></li>";
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
 * 删除图片(低保)
 * @param photoId
 * @return
 */
function deletePhoto(photoId){
	var newSelectedFileArray = [];
	if(selectedFileArray && selectedFileArray.length > 0){
		var deletedPhotoIndex = -1;//被删除的图片的索引号(初始值-1)
		var foundNextHidePhoto = false;//是否找到下一个不显示的图片
		for(var i = 0;i < selectedFileArray.length;i++){
			var tempObject = selectedFileArray[i];
			if(photoId != tempObject["photoId"]){
				//如果在被删除图片位置后的第一条不显示的图变为可显示
				if(deletedPhotoIndex > i && !foundNextHidePhoto){
					if(tempObject["showFlag"] != defaultCheckedYes){
						tempObject["showFlag"] = defaultCheckedYes;
						foundNextHidePhoto = true;
					}
				}
				newSelectedFileArray.push(tempObject);
				deletedPhotoIndex = i;
			}
		}
	}
	selectedFileArray = newSelectedFileArray;
	fillPhotoTable(selectedFileArray);
}

/**
 * 图片向左翻页显示
 * @param linkFirst 是否链至第一张
 * @return
 */
function leftPhoto(linkFirst){
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
			fillPhotoTableHight(selectedFileArray);
		}
	}else{
		//$.messager.alert("Prompt","No pictures, please upload!");
		$.dialog.alert("暂无图片,请先上传!",function(){});
	}
}

/**
 * 图片向右翻页显示
 * @param linkLast 是否链至最后一张
 * @return
 */
function rightPhoto(linkLast){
	//当前显示图片起止号currentShowPhotoIndex,currentShowPhotoIndexEnd每次切换个数photeNumberPerPage,总数三个参数selectedFileArray.length,只显示数量(其它设置不可见)showColumns
	selectedFileArray = getCurrentSelectedFileArray();
	//console.log("rightPhoto selectedFileArray="+JSON.stringify(selectedFileArray));
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
			fillPhotoTableHight(selectedFileArray);
		}
	}else{
		//$.messager.alert("Prompt","No pictures, please upload!");
		$.dialog.alert("暂无图片,请先上传!",function(){});
	}
}


/**
 * 删除图片(高保)
 * @param photoId
 * @return
 */
function deletePhotoHight(photoId){
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
	fillPhotoTableHight(selectedFileArray);
}

/**
 * 每次翻页显示时显示图片的个数(低保)
 * @param photeNumberPerPage 如果为正,则为向右翻页,为负则为左翻页
 * @return
 */
function viewPhotoByPage(photeNumberPerPage){
	//当前显示图片起始号currentShowPhotoIndex,每次切换个数photeNumberPerPage,总数三个参数selectedFileArray.length,只显示数量showColumns
	if(selectedFileArray && selectedFileArray.length > 0){
		var newSelectedFileArray = [];
		if(selectedFileArray.length > showColumns){
			var moveDirection = "right";//移位方向(大于0则右移,否则左移)
			if(photeNumberPerPage < 0){
				moveDirection = "left";
			}
			photeNumberPerPage = Math.abs(photeNumberPerPage);
			
			//判断移位
			if(moveDirection == "right"){
				if(currentShowPhotoIndex == selectedFileArray.length - 1){//到达末端
					//$.messager.alert("Prompt","This is the last picture!");
					$.dialog.alert("已经是最后一张图片!",function(){});
				}else{//可移动个数(即最终移动个数)
					photeNumberPerPage = (selectedFileArray.length - 1 - currentShowPhotoIndex);
					for(var i = 0;i < selectedFileArray.length;i++){
						var tempObject = selectedFileArray[i];
						if(i >= (currentShowPhotoIndex + photeNumberPerPage) && i < (currentShowPhotoIndex + photeNumberPerPage + showColumns)){
							tempObject["showFlag"] = defaultCheckedYes;
						}else{
							tempObject["showFlag"] = defaultCheckedNo;
						}
						newSelectedFileArray.push(tempObject);
					}
					currentShowPhotoIndex = currentShowPhotoIndex + photeNumberPerPage;//当前显示的顺序号重新赋值
					selectedFileArray = newSelectedFileArray;
					fillPhotoTable(selectedFileArray);
				}
			}else{
				if(currentShowPhotoIndex == 0){//到底首端
					//$.messager.alert("Prompt","This is the first picture!");
					$.dialog.alert("已经是第一张图片!",function(){});
				}else{//可移动个数(即最终移动个数)
					photeNumberPerPage = (currentShowPhotoIndex < photeNumberPerPage ? currentShowPhotoIndex : photeNumberPerPage);
					for(var i = 0;i < selectedFileArray.length;i++){
						var tempObject = selectedFileArray[i];
						if(i >= (currentShowPhotoIndex - photeNumberPerPage) && i < (currentShowPhotoIndex - photeNumberPerPage + showColumns)){
							tempObject["showFlag"] = defaultCheckedYes;
						}else{
							tempObject["showFlag"] = defaultCheckedNo;
						}
						newSelectedFileArray.push(tempObject);
					}
					currentShowPhotoIndex = currentShowPhotoIndex - photeNumberPerPage;//当前显示的顺序号重新赋值
					selectedFileArray = newSelectedFileArray;
					fillPhotoTable(selectedFileArray);
				}
			}
		}else{
			for(var i = 0;i < selectedFileArray.length;i++){
				var tempObject = selectedFileArray[i];
				tempObject["showFlag"] = defaultCheckedYes;
				newSelectedFileArray.push(tempObject);
			}
			currentShowPhotoIndex = 0;//当前显示的顺序号重新赋值
			selectedFileArray = newSelectedFileArray;
			fillPhotoTable(selectedFileArray);
		}
	}
}

/**
 * 设置为默认图片(低高保均可)
 * @param photoId
 * @return
 */
function setDefaultPhoto(photoId){
	/*var newSelectedFileArray = [];
	selectedFileArray = getCurrentSelectedFileArray();
	if(selectedFileArray && selectedFileArray.length > 0){
		for(var i = 0;i < selectedFileArray.length;i++){
			var tempObject = selectedFileArray[i];
			if(photoId == selectedFileArray[i]["photoId"]){
				tempObject["isDefault"] = defaultCheckedYes;
			}else{
				tempObject["isDefault"] = defaultCheckedNo;
			}
			newSelectedFileArray.push(tempObject);
		}
	}
	selectedFileArray = newSelectedFileArray;*/
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
function uploadFile(fileElement){
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
							
							//$("#" + $(fileElement).attr("imgId")).attr("src" , rootPath + "/imagePath/" + result.photoPath);
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
							fillPhotoTableHight(selectedFileArray);
							rightPhoto(true);//上传成功一条,则图片向右移至底
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
			markType:$(this).attr("markType"),
			isDefault:$(this).attr("isDefault"),
			showFlag:$(this).attr("showFlag")
		});
	});
	return currentSelectedFileArray;
}

/**
 * 保存商品
 * @param saleGoodsDataArray 数据对象数组
 * @param confirmClose 是否提示关闭
 * @return
 */
function saveGoods(saleGoodsDataArray , confirmClose){
	//console.log(JSON.stringify(saleGoodsDataArray));
	$.ajax({
		contentType : 'application/json',
		url : rootPath + '/sale/saveSaleGoods.do',
		type : 'post',
		dataType : 'json',
		async : false,
		data : JSON.stringify(saleGoodsDataArray),
		success : function(result){
			if(result){
				//$.messager.alert("Prompt",resuPrompt.msg);
				$.dialog.alert(result.msg,function(){});
				if(result.flag == "true"){
					var newSubmitDataArray = [];
					for(var i = 0;i < saleGoodsDataArray.length;i++){
						var tempObject = saleGoodsDataArray[i];
						var saleGoodsIds = result.saleGoodsIds;
						var accessTypes = result.accessTypes;
						var saleGoodsIdsArray = saleGoodsIds.split(",");
						var accessTypesArray = accessTypes.split(",");
						for(var j = 0;j < accessTypesArray.length;j++){
							if(tempObject["accessType"] == accessTypesArray[j]){
								tempObject["saleGoodsId"] = saleGoodsIdsArray[j];
								break;
							}
						}
						newSubmitDataArray.push(tempObject);
					}
					submitDataArray = newSubmitDataArray;
					//console.log(" after save goods submitDataArray="+ JSON.stringify(submitDataArray));
					window.location.href = rootPath + "/sale/visitSaleGoodsMainPage.do";//跳转至列表
				}else{
					operating = false;
				}
			}else{
                    operating = false;
                }
		},
		error : function(result){
			operating = false;
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
				}else{
				    operating = false;
				}
			}else{
				operating = false;
			}
		},
		error : function(result){
			operating = false;
			//$.messager.alert("Prompt","Failed to save the product.");
			$.dialog.alert("保存商品失败.",function(){});
		}
	});
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

/**
 * 加载语种
 */
function loadLanguage(languageName){
}