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
</head>
<body>

<!-------------------------CONT---------------------------->
<div class="List-cont box-cont">
    <div class="panel panel-default">
        <div class="panel-header">
            <h4>自定义报表</h4>
        </div>
        <div class="panel-body">
            <!--搜索模块-->
            <div class="search-form">
                <form id="searchForm">
                    <div class="row cl">
                        <div class="col-sm-12 text-r">
                            <a href="#userDetail" class="btn btn-primary" data-toggle="modal" >查询</a>
                            <a class="btn btn-secondary" data-toggle="modal" onclick="exportCustomReportForm();">导出</a>
							<a href="customReportForm/templatesList.do" class="btn btn-secondary" data-toggle="modal" >模板</a>
                        </div>
                	</div>
            	</form>
			</div>
            <!--列表-->
            <div style="width: 100%;overflow-x: scroll;">
	            <table class="table table-primary mt-30" style="table-layout:fixed">
	                <thead id="reportFormTitle">
	                	<tr>
		                    <th>报表</th>
		                </tr>
	                </thead>
	                <tbody id="reportFormList"></tbody>
	            </table>
            </div>
            <!--分页-->
            <div id="kkpager"></div>
		</div>
	</div>
</div>
<!-------------------------/CONT---------------------------->
<!--------------------------MODAL---------------------------->
<!-- 检索框 -->
<div id="userDetail" class="reportformmodal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-header">
		<h3 id="myModalLabel">定制查询</h3>
		<a class="close" data-dismiss="modal" aria-hidden="true"
			href="javascript:void();"><i class="fa fa-times"></i>
		</a>
	</div>
	<div class="form-group cl" >
		<label class=" fl">表名：</label>
        <select class="input-text" name="tableCode" id="tableCode" onchange="tableCodeOnChange()" style="width: 386px;">
        </select>
        <button class="btn btn-close customReportForm" onclick="addConditionalExpression()">条件</button>
	</div> 
    <div class="form-group cl">
		<label class=" fl">日期：</label>
        <input type="text" class="input-text" id="queryDate" name="queryDate" disabled="false" readonly style="width: 386px;">
	</div>
	<div id="demo">
	</div>
	 
	<div class="form-group cl">
		<label class=" fl">方式：</label>
        <input type="radio"  name="mode" id="mode" value="0" checked> 自定义
        <input type="radio"  name="mode" id="mode" value="1" > 按模板
	</div>   
	<div class="form-group cl" id="templateMode" style="display:none">
		<label class=" fl">模板：</label>
		<select class="input-text" name="templateId" id="templateId" style="width: 386px;">
                <option value=""></option>
        </select>
	</div> 
   	<div class="form-group cl" id="treeMode" style="display:none">
        <label class=" fl" for="">指标：</label>
        <div class="custom-setting-wrap">
            <div class="box" style="width: 386px;">
                <div class="hd">列表</div>
                <div class="bd">
                     <ul id="menus_tree" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group"></div>
	<div class="modal-footer text-c">
		<button class="btn btn-close" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button id="btn-sure" class="btn btn-primary" data-dismiss="modal" onclick="queryCustomReportForm();">查询</button>
	</div>
</div>
<!--------------------------/MODAL----------------------------> 

</body>
</html>