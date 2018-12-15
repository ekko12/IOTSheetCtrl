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
<title>自定义报表模板</title>
<base href="<%=basePath1 %>" />
<!--[if lt IE 9]>
<script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
<link rel="stylesheet" href="js/jbox/jbox.css">
<link rel="stylesheet" href="js/jbox/jbox.css">
<link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
<script type="text/javascript" src="js/jquery-2.1.4.js"></script>
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

<script type="text/javascript" src="js/views/system/reportForms/customTemplateList.js"></script>

<!--[if IE 6]>
<script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('.pngfix,.icon');</script>
<![endif]-->
</head>
<body>

<!-------------------------CONT---------------------------->
<div class="List-cont box-cont">
    <div class="panel panel-default">
        <div class="panel-header">
            <h4>自定义模板</h4>
        </div>
        <div class="panel-body">
            <!--搜索模块-->
            <div class="search-form">
                <form id="searchForm">
                    <div class="row cl">
                        <div class="col-sm-2">
                            <label class="form-label" for="">名称：</label>
                            <div class="formControls">
                            	<input type="text" class="input-text" name="keywordTemplateName" id="keywordTemplateName">
                        	</div>
                        </div>
                        <div class="col-sm-2">
                            <label class="form-label" for="">表名：</label>
                            <div class="formControls">
	                            <select class="input-text" name="keywordTableCode" id="keywordTableCode">
	                            </select>
                        	</div>
                        </div>
                        <div class="col-sm-2">
                            <label class="form-label" for="">状态：</label>
                            <div class="formControls">
	                            <select class="input-text" name="keywordStatus" id="keywordStatus">
	                                <option value="">全部</option>
	                                <option value="1">有效</option>
	                                <option value="0">无效</option>
	                            </select>
                        	</div>
                        </div>
                        <div class="col-sm-6 text-r">
                            <a onclick="searchTemplateList();" class="btn btn-primary" >查询</a>
							<a href="#userDetail" class="btn btn-secondary" data-toggle="modal" onclick="resetAddForm();">新增</a>
							<a class="btn btn-secondary" onclick="javascript:history.go(-1)">返回</a>
                        </div>
                	</div>
            	</form>
			</div>
            <!--列表-->
            <table class="table table-primary mt-30">
                <thead>
	                <tr>
	                	<th>表名</th>
	                    <th>模板名称</th>
	                    <th>状态</th>
	                    <th>描述</th>
	                    <th>创建时间</th>
	                    <th colspan="2">操作</th>
	                </tr>
                </thead>
                <tbody id="templateList"></tbody>
            </table>
            <!--分页-->
            <div id="kkpager"></div>
		</div>
	</div>

</div>
<!-------------------------/CONT---------------------------->
<!--------------------------MODAL---------------------------->
<!-- 模板编辑窗口 -->
<div id="userDetail" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-header">
		<h3 id="myModalLabel">编辑</h3>
		<a class="close" data-dismiss="modal" aria-hidden="true"
			href="javascript:void();"><i class="fa fa-times"></i>
		</a>
	</div>
	<input id="templateId" name="templateId" maxlength="32" type="hidden" class="input-text" value="">
	<div class="form-group cl">
		<label class=" fl">表名：</label>
           <select class="input-text" name="tableCode" id="tableCode" onchange="tableCodeOnChange()">
           </select>
	</div> 
    <div class="form-group cl">
		<label class=" fl">名称：</label>
		<input id="templateName" name="templateName" maxlength="100" type="text" class="input-text" value="">
	</div> 
	<div class="form-group cl">
		<label class=" fl">状态：</label>
           <select class="input-text" name="status" id="status">
               <option value="1">有效</option>
               <option value="0">无效</option>
           </select>
	</div> 
	<div class="form-group cl">
		<label class=" fl">描述：</label>
		<textarea class="textarea" name="templateDesc" maxlength="300" id="templateDesc" cols="30" rows="3"></textarea>
	</div> 
    <div class="form-group cl">
           <label class=" fl" for="">选择报表项：</label>
           <div class="custom-setting-wrap">
               <div class="box">
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
		<button id="btn-sure" class="btn btn-primary" onclick="submitCustomTemplate();">提交</button>
	</div>
</div>

<!--删除对话框--->
<div id="Modal-delete" class="modal w300 hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <div class="modal-header">
    <h3 id="myModalLabel">删除</h3><a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();"><i class="fa fa-times"></i></a>
 </div>
  <div class="modal-body">
 <p>确定删除此自定义模板？</p>
 </div>
  <div class="modal-footer text-c">
	<button class="btn btn-close" data-dismiss="modal" aria-hidden="true">关闭</button>
	<button id="btn-del" onclick="deleteCustomTemplate();" class="btn btn-primary">确定</button> 
 </div>
</div>
<!--------------------------/MODAL----------------------------> 

</body>
</html>