






































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
    <link rel="stylesheet" href="css/jedate.css">
   
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
    <script type="text/javascript" src="js/jquery.jedate.js"></script>
<%-- main.js用于获取当前登录用户可操作功能数据 --%>
<script type="text/javascript" src="resources/easyui13/jquery.easyui.min.js"></script>
<script type="text/javascript" src="resources/easyui13/locale/easyui-lang-en.js"></script>
<script type="text/javascript" src="resources/common/easyui-expand.js"></script>
<script type="text/javascript" src="resources/common/easyui-validate.js"></script>

<script type="text/javascript" src="resources/js/system/main.js"></script>
<script type="text/javascript" src="resources/js/menu.js"></script>


<script type="text/javascript" src="js/echarts.min.js"></script>
</head>
<body style="min-height: 1200px;">
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
	loadJeDate("monthDay");
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
        		//searchList();
        		pieDate.splice(0,pieDate.length);//清空数组 
        		page = 1; 
          		param["monthDay"] = data.date;
          		$("#monthDay").val(data.date);
          		getHomePgFourChart();                                            
          	
        	}
        }  
	});    

	
}); 


function setDisplayContent(type){
	
/*
	var monthDay = $("#monthDay").val();
	var accountNum = $("#accountNum").html().trim();
	var accountNumRate =$("#accountNumRate").html()==undefined?"":$("#accountNumRate").html().trim();// add 20180929
	var connectNum = $("#connectNum").html().trim();
	var orderTrend = $("#orderTrend").html().trim();
	var incomeTrend = $("#incomeTrend").html().trim();                 
	var incomeTrendRate = $("#incomeTrendRate").html()==undefined?"":$("#incomeTrendRate").html().trim();    //add 20180921
	var customerNum = $("#customerNum").html().trim();
	var customerNumRate =$("#customerNumRate").html()==undefined?"":$("#customerNumRate").html().trim();// add 20180929
*/	
	var activityTrend = $("#activityTrend").html().trim();
	
	//var connectNumRate = $("#connectNumRate").html()==undefined?"":$("#connectNumRate").html().trim();        //add 20180921
	//var six_data =accountNum+"a"+connectNum+"a"+activityTrend.substr(0,activityTrend.length-1)+"a"+orderTrend+"a"+incomeTrend+"a"+customerNum;
	//var six_data =accountNum+"a"+connectNum+"a"+activityTrend.substr(0,activityTrend.length-1)+"a"+orderTrend+"a"+incomeTrend+"a"+customerNum +"a"+incomeTrendRate+"a"+connectNumRate+"a"+accountNumRate+"a"+customerNumRate;
	var data1=activityTrend.substr(0,activityTrend.length-1);
	//$("#number-"+displayContent).css("background-color","#db1316");
	//window.location.href= "piechart/toPage.do?displayContent="+type+"&type=1&monthDay="+monthDay+"&six_data="+six_data; 
}

</script>
<input type="hidden" id="roleId" />
<!-- 获取列表 -->
<script type="text/javascript">
	var totalPage;
	var totalRecords;
	var page = 1;
	var param = {};
	function addDate(date,days){ 
      var d=new Date(date); 
      d.setDate(d.getDate()+days); 
      var m=d.getMonth()+1; 
      return d.getFullYear()+'-'+m+'-'+d.getDate(); 
    }
	function setBeforeDay(){
		var monthDay = $("#monthDay").val();
		monthDay = addDate(monthDay,-1);
		if(monthDay<"2018-1-1"||monthDay<"2018-01-01"){
			alert("2017年数据为空，无法查询！");
		}else{
			$("#monthDay").val(monthDay);
			searchList();
		}
		
	}
	function setNextDay(){
		var monthDay = $("#monthDay").val();
		monthDay = addDate(monthDay,1);

		var d=new Date;
	    var m=d.getMonth()+1; 
	    
	    if(monthDay>d.getFullYear()+'-'+m+'-'+d.getDate()){
	    	alert("大于系统当前时间数据为空，无法查询！");
	    }else{
	    	$("#monthDay").val(monthDay);
			searchList();
	    }
	    	
		
	}
	function searchList(){
		pieDate.splice(0,pieDate.length);//清空数组 
		page = 1; 
		var monthDay = $("#monthDay").val();
  		param["monthDay"] = monthDay.trim();
  		getHomePgFourChart();                                 
  		//getConNumActivityTrend();//连接数-激活率-活跃率 getPieChart();
  		//getPlatformBusiness();//平台商机和客户情况 getLineChartByConnHisTrend();
  		//getPlatformIncome();//平台收入分省情况 getActiveRateByTrend();
  		//getConNum();//全国连接数趋势 getTotalChargeRend();
  		//getCustomerNum();//全国客户数趋势 getOrderTrend();
  		//getIncome();//全国收入趋势
	}
function getHomePgFourChart() {
		$.ajax({
  			type: "POST",
  			url: "piechart/getHomePgFourTb.do",
  			data: param,
  			datatype: "json",
  			success: function(data){

  				var myChart7 = echarts.init(document.getElementById('main8'));
  				$("#activityTrend").html(Number(data.datas[0].activityTrend).toFixed(2)+"%");
  				var option = {
  					    tooltip : {
  					        formatter: "{a} <br/>{b} : {c}%"
  					    },
  					    toolbox: {
  					        feature: {
  					            restore: {},
  					            saveAsImage: {}
  					        }
  					    },
  					    series: [
  					        {
  					            name: '业务指标',
  					            type: 'gauge',
  					            detail: {formatter:'{value}%'},
  					            data: [{value: 50, name: '连接数激活率'}]
  					        }
  					    ]
  					};

  					setInterval(function () {
  					    option.series[0].data[0].value = Number(data.datas[0].activityTrend).toFixed(2);/*(Math.random() * 100).toFixed(2) - 0;*/
  					    myChart7.setOption(option, true);
  					},2000);
  				
  			},
			error : function () {
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
			}
  		});
	}
	
/**
 * 加载日期选择器
 * @returns
 */
function loadJeDate(id) {
    $("#" + id).jeDate({
        format: "YYYY-MM-DD", //日期格式YYYY-MM-DD hh:mm:ss
        minDate:"2018-01-01 00:00:00", //最小日期
        choosefun:function(val) {
        	var monthDay = $("#monthDay").val();

    		var d=new Date;
    	    var m=d.getMonth()+1; 
    	    if(Number(m)<10){
    	    	m="0"+m;
    	    }
    	    var day = d.getDate();
    	    if(Number(day)<10){
    	    	day="0"+day;
    	    }
    	    if(monthDay>d.getFullYear()+'-'+m+'-'+day){
    	    	alert("大于系统当前时间，数据为空，无法查询！");
    	    }else{
    			searchList();
    	    }
        },
        okfun:function(val) {
        	var monthDay = $("#monthDay").val();

    		var d=new Date;
    	    var m=d.getMonth()+1; 
    	    if(Number(m)<10){
    	    	m="0"+m;
    	    }
    	    var day = d.getDate();
    	    if(Number(day)<10){
    	    	day="0"+day;
    	    }
    	    if(monthDay>d.getFullYear()+'-'+m+'-'+day){
    	    	alert("大于系统当前时间，数据为空，无法查询！");
    	    }else{
    			searchList();
    	    }
        } 
    });
}
</script>
<div class="List-cont box-cont">
	<div class="panel panel-default">
	    <div class="panel-header">
	      <h4>首页</h4>
	    </div>
		<div id="panel-body" class="panel-body">
        	<!--搜索模块-->
            <div class="search-form">
            	<form id="searchForm">
                 <div class="row cl clclclcl">
                 	<ul>
						 <li class="before" onclick="setBeforeDay();">
							 <a><img src="img/before.svg" alt="before"></a>
					     </li>
						 <li class="time">
							 <input type="text" class="input-text time-box" id="monthDay" name="monthDay" placeholder="yyyy-mm-dd" readonly>
				         </li>
						 <li class="next" onclick="setNextDay();">
							 <a><img src="img/next.svg" alt="next"></a>
				         </li>
				         
					 </ul>
                 <div class="col-sm-1 text-r" style="display:none;">
                    <a onClick="searchList();" class="btn btn-primary ">查询</a>  
                 </div><br/><br/>
                 </div>
                </form> 
              </div>
                <!-- 为仪表盘准备好一个具备大小的（宽高）的DOM -->
            <div id="main8" style="width: 450px;height:300px;"></div><!-- add in 2018-10-22 -->
          
		
	       </div> 
	  	 </div>                                      
        </div>       
 

 

</body>
</html>