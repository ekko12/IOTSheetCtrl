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
<title>角色管理页-中国联通研究院大数据运营后台管理系统</title>
<base href="<%=basePath1 %>" />

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
    
   
	  <!-- Ionicons -->
	  <link rel="stylesheet" href="adminLTE/bower_components/Ionicons/css/ionicons.min.css">
	  <!-- Theme style -->
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
</head>
<body style="min-height: 900px;">
<script type="text/javascript">
var flag =3;
var pieDate =[]; 
var proCode = 0;
var cityCode = 0;
$(document).ready(function() {
	var date=new Date;
	var yearNow=date.getFullYear();
	$("#year").empty();
	for(var i =0;i<5;i++){
		var y = yearNow-i;
		$("#year").append("<option value="+y+">" + y + "年</option>");
	}
	$("#city2C").hide();
	$("#pro2C").hide();   
	var params = {};
	param["firstFlag"] = 0; 
	var pro;
	var city;
	
	$.ajax({
        type: "POST",  
        url: "piechart/getOrg.do",   
        data: params,
		datatype: "json",
        success: function(data){ 
        	if (data!=null){
        		flag = data.flag;
          		param["isFlag"] = 1;
          		
          		getHomePgFourChart();
        	}
             
        }  
	});    

	
}); 

function toTrendGraph(type){
	window.location.href= "piechart/toTrend.do?type="+type; 
	
}
</script>
<input type="hidden" id="roleId" />
<!-- 获取列表 -->
<script type="text/javascript">
	var totalPage;
	var totalRecords;
	var page = 1;
	var param = {};
	function searchList(){
		param["firstFlag"] = 1; 
		pieDate.splice(0,pieDate.length);//清空数组 
		page = 1; 
  		param["isFlag"] = 1;  
  		
  		getHomePgFourChart();
	}
	function getHomePgFourChart() {
  		var date=new Date;
  		var yearNow=date.getFullYear();
  		param["busAccYear"] = yearNow;
		$.ajax({
  			type: "POST",
  			url: "busAccSnap/getHomePgFourTb.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				$("#customerNum").html(data.datas[0].customerNumber+"人");
  				$("#accountNum").html(data.datas[0].companyNumber+"个");
  				$("#connectNum").html(data.datas[0].connections+"个");
  				$("#connectIncome").html(Number(data.datas[0].totalCharge).toFixed(2));
  				$("#connectRealIncome").html("0");
  				$("#customerPay").html("0");
  			},
			error : function () {
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
			}
  		});
	}
	
</script> 
 
<!-------------------------CONT---------------------------->  
<div class="List-cont box-cont">
	<div class="panel panel-default">
	    <div class="panel-header">
	      <h4>首页</h4>
	    </div>
		<div id="panel-body" class="panel-body" style="background-image: url(img/background-img.png);background-repeat:no-repeat;background-size:100% 100%;-moz-background-size:100% 100%;">
           <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
           <div class="row cl" style="margin-left:20%;margin-top:8%;margin-bottom:10%;">
           
					<div class="col-sm-12" style="height:100%;">
					
						<div class="col-sm-3">
				          <div style="background-color:#db1316;color:white;height:85px;" onclick="toTrendGraph(6);">
				            <div style="float:left;">
				              <p1 style="position:absolute;margin-left:20px;margin-top:8px;">客户数</p1>
							  <img src="img/customerNum.png" style="margin-top:5px;"/>
							 </div>
				            <div style="position:absolute;margin-left:32%;margin-top:25px;">
							  <img src="img/progressBar.png" style="width:90%;"/>
							  <p id="customerNum" style="margin-left:30%;">loading...</p>
				            </div> 
				           </div>
				          </div>
				        <div class="col-sm-3">
				          <div style="background-color:#db1316;color:white;height:85px;" onclick="toTrendGraph(1);">
				            <div style="float:left;">
				              <p1 style="position:absolute;margin-left:20px;margin-top:8px;">账户数</p1>
				              <img src="img/accountNum.png" style="margin-top:5px;"/>
				            </div>
				            <div style="position:absolute;margin-left:52%;margin-top:12px;">
				              <img src="img/progressCircle.png" style="width:80%;"/>
							  <p id="accountNum" style="margin-left:20%;margin-top:-40px;">loading...</p>
				            </div> 
				            
				          </div>
				        </div>
				    </div>
 					<!-- </div> -->
 					
 					
 					<div class="col-sm-12" style="margin-top:20px;">
						<div class="col-sm-3">
				          <div style="background-color:#254c67;color:white;height:85px;" onclick="toTrendGraph(2);">
				            <div style="float:left;">
				              <p1 style="position:absolute;margin-left:20px;margin-top:8px;">连接数</p1>
				              <img src="img/connectNum.png" style="margin-top:5px;"/>
				            </div>
				            <div style="position:absolute;margin-left:32%;margin-top:22px;">
							  <img src="img/progressBar.png" style="width:90%;"/>
							  <p id="connectNum">loading...</p>
				            </div> 
				            
				          </div>
				        </div> 
				                
				        <div class="col-sm-3">
				          <div style="background-color:#a7beb3;color:white;height:85px;" onclick="toTrendGraph(5);">
				            <div style="float:left;">
				              <p1 style="position:absolute;margin-left:20px;margin-top:8px;">平台应收</p1>
				              <img src="img/connectIncome.png" style="margin-top:5px;"/>
				            </div>
				            <div style="position:absolute;margin-left:52%;margin-top:12px;">
				               <img src="img/progressCircle.png" style="width:80%;"/> 
								<p id="connectIncome" style="margin-left:20%;margin-top:-40px;">loading...</p>
				            </div> 
				            
				          </div>
				        </div>
				        
 					</div>
 					
 					<div class="col-sm-12" style="margin-top:20px;">
						<div class="col-sm-3">
				          <div style="background-color:#739588;color:white;height:85px;">
				            <div style="float:left;">
				              <p1 style="position:absolute;margin-left:20px;margin-top:8px;">平台实收</p1>
				              <img src="img/connectRealIncome.png" style="margin-top:5px;"/>
				            </div>
				            <div style="position:absolute;margin-left:32%;margin-top:25px;">
							<img src="img/progressBar.png" style="width:90%;"/>
				             <p id="connectRealIncome" style="margin-left:30%;">loading...</p>
				            </div> 
				            
				          </div>
				        </div> 
				                
				        <div class="col-sm-3">
				          <div style="background-color:#61a0a8;color:white;height:85px;">
				            <div style="float:left;">
				              <p1 style="position:absolute;margin-left:20px;margin-top:8px;">客户缴纳款</p1>
				              <img src="img/customerPay.png" style="margin-top:5px;"/>
				            </div>
				            <div style="position:absolute;margin-left:52%;margin-top:12px;">
				               <img src="img/progressCircle.png" style="width:80%;"/> 
							   <p id="customerPay" style="margin-left:20%;margin-top:-40px;">loading...</p>
				            </div> 
				            
				          </div>
				        </div>
				        
 					</div>
 					
				  </div>
				  
	  <script type="text/javascript">
    </script> 
	       </div> 
	  	 </div>                                      
        </div>       
 

 

</body>
</html>
