<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path1 = request.getContextPath();
    String basePath1 = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort() + path1 + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>自定义报表</title>
<base href="<%=basePath1 %>" />
<!--[if lt IE 9]>
<script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/jedate.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
<link rel="stylesheet" href="js/jbox/jbox.css">
<link rel="stylesheet" href="js/jbox/jbox.css">
<link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
<script type="text/javascript" src="js/jquery-2.1.4.js"></script>
<script type="text/javascript" src="js/jquery.jedate.js"></script>
<script type="text/javascript" src="js/validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/validate/additional-methods.min.js"></script>
<script type="text/javascript" src="js/validate/messages_zh.js"></script>
<script type="text/javascript" src="js/kkpager/kkpager.min.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modal.js"></script>
<script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script>
<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>

<script type="text/javascript" src="js/views/system/reportForms/customReportFormList.js"></script>

<!--[if IE 6]>
<script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('.pngfix,.icon');</script>
<![endif]-->
<script type="text/javascript">


	</script>
	<!-- 最新的引入文件 -->
 	<link rel="stylesheet" href="webapp2.0/css/base.css">
 	<link rel="stylesheet" href="webapp2.0/css/unicom.css">
	<link rel="stylesheet" href="webapp2.0/css/bootstrap.min.css">
	
	<link rel="stylesheet" href="webapp2.0/css/swiper.min.css">
	<link rel="stylesheet" href="webapp2.0/css/css/unicom.css">
	<script src="webapp2.0/js/bootstrap.min.js"></script>
	<script src="webapp2.0/js/btn.js"></script>
	<script src="webapp2.0/js/swiper.min.js"></script>
	<!-- 省市查询插件 -->
	<script src="webapp2.0/js/distpicker.data.js"></script>
	<script src="webapp2.0/js/distpicker.js"></script>
	<!-- 最新的引入文件-结束 -->
	
</head>
<body>
<div class="unicom"> 
	<div class="header header2">
		<span>客户画像</span>
	</div>
	<!--搜索模块-->
    <div class="search">
			<form data-toggle="distpicker">
	    	<div class="select-box">
        		<div class="name">省份：</div>
				<label class="box">
            		<select name="" id="province1"></select>
        		</label>
        	</div>
        	<div class="select-box grid-left">
        		<div class="name">城市：</div>
				<label class="box">
            		<select name="" id="city1"></select>
        		</label>
        	</div>
        	<div class="select-box grid-left">
        		<div class="name">区/县：</div>
				<label class="box">
            		<select name="" id="district1""></select>
        		</label>
        	</div>
        	<div class="select-box grid-left">
        		<div class="name">用户：</div>
				<label class="box">
            		<select name="">
		                <option value="001">活跃用户</option>
						<option value="010">高危用户</option>
            		</select>
        		</label>
        	</div>
	        <div class="btn-box">
				<a  class="unicom-btn grid-left">查&nbsp;&nbsp;询</a>
	     	</div>
     	</form> 
	</div>
	<!--  -->
	<div class="unicom-data">
		表格
	</div>
	<!--搜索模块-->
   	<div class="search" style="margin:-2px 0 0 0;border-top:0.0625em solid #425361;">
		<form>
	    	<div class="select-box">
        		<div class="name">客户名称：</div>
				<label class="box">
            		<select>
            			<option value="001">虚拟ID</option>
						<option value="010">账户ID</option>
            		</select>
        		</label>
        	</div>
        	<div class="select-box grid-left">
        		<div class="name">ID：</div>
        		<input type="text"  style="width:120px">
        	</div>
        	<div class="btn-box" id="searchForm">
				<a  class="unicom-btn grid-left" href="#userDetail" data-toggle="modal" >查&nbsp;&nbsp;询</a>
     		</div>
    	</form> 
	</div>
</div>
<div class="footer">
	<p>Copyright&nbsp;©&nbsp;1999-2018 ChinaUnicom&nbsp;中国联通&nbsp;版权所有&nbsp;&nbsp;&nbsp;&nbsp;技术支持：中国联通研究院-大数据研究中心</p>
</div> 
</body>
</html>