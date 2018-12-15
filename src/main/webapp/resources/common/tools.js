/**定义一个工具类，包含一些通用的js方法*/
var Tools=function(){
}

/**
 * 添加一个静态方法，用于设置图片的最大宽度
 * @param img 图片对象
 * @param maxWidth 最大宽度
 */
Tools.fitImg= function(img,maxWidth){
	 var initialWidth = img.width;
     if(initialWidth>maxWidth){
    	 img.width = maxWidth;   
     }
};

/**
 * 将dom对象的value的空格
 */
Tools.trimVal=function(domObj){
	domObj.value=$.trim(domObj.value);
	domObj.value = domObj.value.replace(/(^\s*)/g,""); // 前面的空格
	domObj.value = domObj.value.replace(/(\s*$)/g,""); // 后面的空格
	domObj.value = domObj.value.replace(/(\s*)/g,""); // 中间的空格
}

/**
 * 限制只允许输入字母、数字、特殊符号 
 */
Tools.check_Z_S_F=function(obj){
	// 先去空格
	Tools.trimVal(obj);
 
	obj.value = obj.value.replace(/([^a-zA-Z0-9!@#$%^&*()_+|{}?><\-\]\\[\/])/g,"");
}