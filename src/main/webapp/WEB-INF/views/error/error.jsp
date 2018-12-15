<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path1 = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort() + path1 + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>错误页-中国联通研究院大数据运营后台管理系统</title>
    <base href="<%=basePath %>" />
    <!--[if lt IE 9]>
      <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="css/components.css">
    <link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
    <script type="text/javascript" src="js/jquery-2.1.4.js"></script> 
    <script type="text/javascript" src="js/validate/jquery.validate.min.js"></script> 
    <script type="text/javascript" src="js/validate/additional-methods.min.js"></script> 
    <script type="text/javascript" src="js/validate/messages_zh.js"></script> 
    <script type="text/javascript" src="js/kkpager/kkpager.min.js"></script> 
    <script type="text/javascript" src="js/modal/bootstrap-modal.js"></script> 
    <script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script> 

  
    <script type="text/javascript" src="js/app.js"></script>
    <!--[if IE 6]> 
      <script type="text/javascript" src="Lib/DD_belatedPNG_0.0.8a-min.js" ></script>
      <script>DD_belatedPNG.fix('.pngfix,.icon');</script> 
    <![endif]--> 
</head>
<body>
  
  <!-------------------------CONT---------------------------->  
  <div class="Detail-cont box-cont">
            <div class="panel panel-default">             
                <div class="panel-body"> 
                     <!--错误提示-->
                   
                <div class="error-panel text-c ">
                   <div class=" mt-90 mb-50"><img src="img/error_icon.png" width="108" height="108" 商户配置图标 alt=""></div>
                   <h4 class="mb-50">哎呀...您访问的页面可能有点问题，请稍后再尝试一下吧</h4>
                   <a class="btn btn-primary" href="javascript:window.history.go(-1)">返回</a>
                </div>          
            </div>    
                         
                         
                 </div> 
            </div>                                      

</body>
</html>