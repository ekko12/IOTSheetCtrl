<%@ page language="java" pageEncoding="utf-8" isELIgnored="false" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path1 = request.getContextPath();
String basePath1 = request.getScheme() + "://"
          + request.getServerName() + ":" + request.getServerPort() + path1 + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath1 %>" />
	<title>角色管理页-中国联通研究院大数据运营后台管理系统</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
    <script type="text/javascript" src="js/jquery-2.1.4.js"></script> 
    <script type="text/javascript" src="js/validate/jquery.validate.min.js"></script> 
    <script type="text/javascript" src="js/validate/additional-methods.min.js"></script> 
    <script type="text/javascript" src="js/validate/messages_zh.js"></script> 
    <script type="text/javascript" src="js/kkpager/kkpager.min.js"></script> 
    <script type="text/javascript" src="js/modal/bootstrap-modal.js"></script> 
    <script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script>
</head>
<body>
  <!-------------------------CONT---------------------------->  
<div class="Detail-cont box-cont">
	<div class="panel panel-default">
	    <div class="panel-header">
	      <h4>角色管理</h4>
	    </div>
	    <div class="panel-body">
	    	<div class="panel panel-primary">
	        	<div class="panel-header">
	            	<h4>查看角色</h4>
	        	</div>
	        	<div class="panel-body">
                    <p><span class="c-999">角色编码：</span>${role.roleCode }</p>
                    <p><span class="c-999">状态：</span>${role.status eq 1?"有效":"无效"}</p>
                    <p><span class="c-999">角色名：</span>${role.roleName }</p>
                    <p><span class="c-999">备注：</span>${role.roleDesc }</p> 
	            </div>
	        </div>
			<div class="btn-wrap pl-20 mt-10">
				<a class="btn btn-secondary ml-10" onclick="javascript:history.go(-1);return false;">关闭</a>
	        </div>
       </div> 
   </div>                                      
</div>
</body>
</html>
