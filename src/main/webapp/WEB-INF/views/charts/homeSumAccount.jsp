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
	<title>首页应收账款页-中国联通研究院大数据运营后台管理系统</title>
	<base href="<%=basePath1 %>" />

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    <link rel="stylesheet" href="adminLTE/dist/css/AdminLTE.min.css">
 
    <script type="text/javascript" src="js/jquery-2.1.4.js"></script> 
    <script type="text/javascript" src="js/validate/jquery.validate.min.js"></script> 
    <script type="text/javascript" src="js/validate/additional-methods.min.js"></script> 
    <script type="text/javascript" src="js/validate/messages_zh.js"></script> 
    <script type="text/javascript" src="js/kkpager/kkpager.min.js"></script> 
    <script type="text/javascript" src="js/modal/bootstrap-modal.js"></script> 
    <script type="text/javascript" src="js/modal/bootstrap-modalmanager.js"></script> 
    <script type="text/javascript" src="js/jbox/jquery.jBox-2.3.min.js"></script> 
    <script type="text/javascript" src="js/jbox/jquery.jbox-zh-cn.js"></script> 
    
	<%-- main.js用于获取当前登录用户可操作功能数据 --%>
	<script type="text/javascript" src="resources/easyui13/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="resources/easyui13/locale/easyui-lang-en.js"></script>
	<script type="text/javascript" src="resources/common/easyui-expand.js"></script>
	<script type="text/javascript" src="resources/common/easyui-validate.js"></script>
	
	<script type="text/javascript" src="resources/js/system/main.js"></script>
	<script type="text/javascript" src="resources/js/menu.js"></script>
	
    <script type="text/javascript" src="js/echarts.min.js"></script>
    <script type="text/javascript" src="js/china.js"></script>
</head>
<body style="min-height: 900px;">
	
<input type="hidden" id="roleId" />
<!-------------------------CONT---------------------------->  
<div class="List-cont box-cont">
	<div class="panel panel-default">
	    <div class="panel-header">
	      <h4>应收账款（元）</h4>
	    </div>
		<div id="panel-body" class="panel-body">
            <div class="data" style="width:100%; height:460px; overflow:scroll;"> 
				       <table class="table table-primary mt-10" style="width:500px; height:250px;">
						<thead>
							<tr>
								<th rowspan='2'>行业</th>
								<th colspan ="3">上海</th> 
								<th colspan ="3">云南</th>
								<th colspan ="3">内蒙古</th> 
								<th colspan ="3">北京</th>
								<th colspan ="3">吉林</th>
								<th colspan ="3">四川</th>
								<th colspan ="3">天津</th>
								<th colspan ="3">宁夏</th>
								<th colspan ="3">安徽</th>
								<th colspan ="3">山东</th>
								<th colspan ="3">山西</th>
								<th colspan ="3">广东</th>
								<th colspan ="3">广西</th>
								<th colspan ="3">新疆</th>
								<th colspan ="3">江苏</th>
								<th colspan ="3">江西</th>
								<th colspan ="3">河北</th>
								<th colspan ="3">河南</th>
								<th colspan ="3">浙江</th>
								<th colspan ="3">海南</th>
								<th colspan ="3">湖北</th>
								<th colspan ="3">湖南</th>
								<th colspan ="3">澳门</th>
								<th colspan ="3">甘肃</th>
								<th colspan ="3">福建</th>
								<th colspan ="3">西藏</th>
								<th colspan ="3">贵州</th>
								<th colspan ="3">辽宁</th>
								<th colspan ="3">重庆</th>
								<th colspan ="3">陕西</th>
								<th colspan ="3">青海</th>
								<th colspan ="3">黑龙江</th>
							</tr>
							<tr> 
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
								<th>总数</th> 
								<th>占比</th>
								<th>环比</th>  
							</tr>
						</thead>
						<tbody id="custom5">

						</tbody>
						</table>
					</div>
	   </div> 
	</div>                                      
</div>   

<script type="text/javascript">
var param = {};
var page = 1;
var customStateType = "03"
$(document).ready(function() {
	var date=new Date;
	var yearNow=date.getFullYear();
	var params = {};
	var pro;
	$.ajax({
        type: "POST",  
        url: "piechart/getDate.do",   
        data: params,
		datatype: "json",
        success: function(data){ 
        	if (data!=null){
        		pro = data.date;
        		page = 1; 
          		//param["monthDay"] = data.date;
          		param["monthDay"] = '20180526';
          		//param["customStateType"] = customStateType;
          		getCustInduProv();                                            
        	}
        }  
	});    
	  
}); 

function getCustInduProv() {  
	$.ajax({
			type: "POST",
			url: "piechart/getHomeSumAccuList.do",
			data: param,
			datatype: "json",
			success: function(data){ 
				var listString = "";
				
			  	for(var key in data){
					listString += "<tr >"; 
					listString += "<td >"+key+"</td>";  
					var infos = data[key];
					for(var d in infos){
						
						if (null == infos[d].value || infos[d].value.length ==0 ){
							listString += "<td></td>"; 
						}else{
							listString += "<td>"+(Number(infos[d].value)).toFixed(2)+"</td>"; 
						}
						
						if (null == infos[d].value1 || infos[d].value1.length ==0){
							listString += "<td></td>"; 
						}else{
							listString += "<td>"+(Number(infos[d].value1)*100).toFixed(2)+"%"+"</td>"; 
						}
						
						if (null == infos[d].value2 || infos[d].value2.length ==0){
							listString += "<td></td>"; 
						}else{
							listString += "<td>"+(Number(infos[d].value2)*100).toFixed(2)+"%"+"</td>"; 
						}
	  					
					}
					listString += "</tr>";	
				}     
				$("#custom5").html(listString); 	  		
			},
		error : function () {
			$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
			return false;
		}
		});
}


</script>
    
</body>
</html>
