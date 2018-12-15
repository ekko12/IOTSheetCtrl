/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	/*config.language = 'zh-cn';
	config.uiColor = '#cccccc';
	config.autoUpdateElement = true;
	//图片上传的服务端路径,CTX网站上下文路径，需要在引入ckeditor.js之前赋值
	config.filebrowserImageUploadUrl='${ctxPath }/imgUpload!doUpload.action';*/
	//config.filebrowserImageUploadUrl='sale/ckeditUpload.do';

	//var pathName = window.document.location.pathname;
	    //获取带"/"的项目名，如：/uimcardprj
	    //var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);alert("pn="+pathName);alert("pn1="+projectName);alert("rp="+rootPath);
	    //config.filebrowserImageUploadUrl = projectName+'/ckeditUpload.do'; //固定路径
	//填写以下内容，图片，flash路径
	config.filebrowserUploadUrl="ckeditUpload.do";//注意不要带包名(可能仅适用于销售管理下的页面)
	config.uiColor = '#F7F8F9'
    config.scayt_autoStartup = false
    config.language = 'en'; //中文
	config.autoUpdateElement = true;
	
};
