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
	<script type="text/javascript" src="./js/china.js"></script>
	
	
	<script type="text/javascript" src="js/echarts.min.js"></script>
	
	<!-- 最新的引入文件 -->
 	<link rel="stylesheet" href="webapp2.0/css/base.css">
 	<link rel="stylesheet" href="webapp2.0/css/unicom.css">
	<link rel="stylesheet" href="webapp2.0/css/bootstrap.min.css">
	
	<link rel="stylesheet" href="webapp2.0/css/swiper.min.css">
	<link rel="stylesheet" href="webapp2.0/css/css/unicom.css">
	<script src="webapp2.0/js/bootstrap.min.js"></script>
	<script src="webapp2.0/js/btn.js"></script>
	<script src="webapp2.0/js/swiper.min.js"></script>
	<!-- 最新的引入文件-结束 -->
	
</head>
<script type="text/javascript">
var flag =3;
var pieDate =[]; 
var proCode = 0;
var cityCode = 0;
var param = {};
var page = 1;
var customStateType = "03";
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
        		page = 1; 
          		
          		pieDate.splice(0,pieDate.length);//清空数组 
        		page = 1; 
        		param["monthDay"] = data.date;  
          		$("#monthDay").val(data.date);
          		//param["customStateType"] = customStateType;  
          		var displayContent = "2";
				var daPingFlag = "1";
				param["displayContent"] = displayContent;
				param["daPingFlag"] = daPingFlag;
        		getHomeAcctChargeLiveRateRate();
        		getHomeChargeConnectRate();
        		getActiNumRate();
        		getCustomListCompare();
        		getCustomActiCompare();
        		getCustomNewAndCurrent();
        		getActiveByTrend();
        		getPlatformIncome();
        		getIncome();
        		getAreaTop();
        		getHomePgFourChart();
        	}
        }  
	});    
	  
}); 
</script> 
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
		getHomeAcctChargeLiveRateRate();
		getHomeChargeConnectRate();
		getActiNumRate();
		getCustomListCompare();
		getCustomActiCompare();
		getCustomNewAndCurrent();
		getActiveByTrend();
		getPlatformIncome();
		getIncome();
		getAreaTop();
		getHomePgFourChart();
}
//四个数据
function getHomePgFourChart() {                           		
	$.ajax({
			type: "POST",
			url: "piechart/getHomePgFourTb.do",
			data: param,
			datatype: "json",
			success: function(data){  
				
				var accountNumValue=(Number(data.datas[0].accountNumRate)).toFixed(2)*100;//add in 2018-09-26 
				var customerNumValue=(Number(data.datas[0].customerNumRate)).toFixed(2)*100;//add in 2018-09-26
				var incomeTrendValue=(Number(data.datas[0].incomeTrendRate)).toFixed(2)*100;//add in 2018-09-26 
				var connectNumValue=(Number(data.datas[0].connectNumRate)).toFixed(2)*100;//add in 2018-09-26
				 
		 
			var customNumString ="";
			var accountNumString ="";
			var incomeTrendString ="";
			var connectNumString ="";
			if(accountNumValue>0){
				accountNumString +=accountNumValue+"%⇡";
			}else{
				accountNumString +=accountNumValue+"%⇣";
			}
			if(customerNumValue>0){
				customNumString +=customerNumValue+"%⇡";
			}else{
				customNumString +=customerNumValue+"%⇣";
			}
			if(incomeTrendValue>0){
				incomeTrendString +=incomeTrendValue+"%⇡";
			}else{
				incomeTrendString +=incomeTrendValue+"%⇣";
			}
			if(connectNumValue>0){
				connectNumString +=connectNumValue+"%⇡";
			}else{
				connectNumString +=connectNumValue+"%⇣";
			}
			$("#customerNumber").html((Number(data.datas[0].customerNumber)/10000).toFixed(2));
			$("#accountNum").html((Number(data.datas[0].accountNum)/10000).toFixed(2));
			$("#connectNum").html((Number(data.datas[0].connectNum)/10000).toFixed(2));
			$("#incomeTrend").html((Number(data.datas[0].incomeTrend)/10000).toFixed(2));
			
			$("#customerNumRate").html(customNumString);
			$("#accountNumRate").html(accountNumString);
			$("#connectNumRate").html(connectNumString);
			$("#incomeTrendRate").html(incomeTrendString); 
  	
			},
		error : function () {
			$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
			return false;
		}
		});
}

function getHomeChargeConnectRate() {        //仪表盘 连接出账率                   		
	$.ajax({
			type: "POST",
			url: "piechart/getHomeRate.do",
			data: param,
			datatype: "json",
			//success: function(data){
			//	console.log(data);
			//	var accountNumValue=(Number(data.datas[0].accountNumRate)).toFixed(2);//add in 2018-09-26
		//	$("#accountNum").html((data.datas[0].accountNum)+ "  环比：" + (data.datas[0].accountNumRate)+"%"); 	
	success: function(data){
			if (data.datas.length>0) {
				if(data.code==200){
					datas = data.datas; 
  					var chargeConnectRate =(Number( datas[0].chargeConnectRate)).toFixed(2)*100;
  					var chargeConRate = (Number( datas[0].chargeConnectRate)).toFixed(2);
  					//var acctChargeLiveRate = datas[0].acctChargeLiveRate*100;
  	
  					/* option5 = {
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
  						          	radius: '90%',
  						          	axisLine: {
        	                                lineStyle: {
        	                                    color: [[0.0, '#0083fe'], [0.2, '#0083fe'], [0.8, '#0070fd'], [1, '#0066fe']]
        	                                },
  						        	},
  						          	detail : {
    										formatter:'{value}%',
    										borderColor: '#fff',	    	              
    										offsetCenter: [0, '70%'],  // x, y，单位px
    										textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    										       	 	fontWeight: 'bolder',
    										         	fontSize: '20',	
    										         	color:'#0083fe'
    										       	  }
    										     },
  						            //data: [{value: chargeConnectRate, name: '连接出账率'}]
  						          	data: [{value: chargeConnectRate, name: ''}]
  						        }
  						    ]


  						}; */
  						var option5 = {
  								
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
  				                        type: "gauge",
  				                        center: ["50%", "50%"], // 默认全局居中
  				                        radius: "94%",
  				                        axisLine: {
  				                            show: false,
  				                            lineStyle: { // 属性lineStyle控制线条样式
  				                                color: [
  				                                    [chargeConRate, "#ffd71a"],
  				                                    [1, "#494c3b"]
  				                                ],
  				                                width: 5
  				                            }
  				                        },
  				                        splitLine: {
  				                            show: false
  				                        },
  				                        axisTick: {
  				                            show: false
  				                        },
  				                        axisLabel: {
  				                            show: false
  				                        },
  				                        pointer: {
  				                            show: true
  				                        },
  				                        detail: {
  				                            formatter : "{score|{value}%}\n{name|连接出账率}",
  				                            offsetCenter: [0, "5%"],
  				                          	offsetCenter: [0, '40%'],  // x, y，单位px
  				                            rich : {
  				                                score : {
  				                                    color : "#ffd71a",
  				                                    fontFamily : "微软雅黑",
  				                                    fontSize : 25
  				                                },
  				                                name : {
  				                                    height : 25,
  				                                    color : "#526680",
  				                                    fontFamily : "微软雅黑",
  				                                    fontSize : 14
  				                                }
  				                            }
  				                        },
  				                      data: [{value: chargeConnectRate, name: ''}]
  				                    },
  				                    {
  				                        type : "gauge",
  				                        center: ["50%", "50%"], // 默认全局居中
  				                        radius : "83%",
  				                        axisLine : {
  				                            show : true,
  				                            lineStyle : { // 属性lineStyle控制线条样式
  				                                color : [
  				                                    [ 0.1,  new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
  				                                        offset: 1,
  				                                        color: "rgba(59, 71, 82, 0)" // 0% 处的颜色
  				                                    }, {
  				                                        offset: 0,
  				                                        color: "rgba(59, 71, 82, 0.5)" // 100% 处的颜色
  				                                    }], false) ],
  				                                    [ 0.9, "rgba(59, 71, 82, 0.5)" ],
  				                                    [ 1,  new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
  				                                        offset: 1,
  				                                        color: "rgba(59, 71, 82, 0.5)" // 0% 处的颜色
  				                                    },
  				                                        {
  				                                            offset: 0.8,
  				                                            color: "rgba(59, 71, 82, 0.3)" // 0% 处的颜色
  				                                        },
  				                                        {
  				                                            offset: 0.5,
  				                                            color: "rgba(59, 71, 82, 0.2)" // 0% 处的颜色
  				                                        },
  				                                        {
  				                                            offset: 0,
  				                                            color: "rgba(59, 71, 82, 0)" // 100% 处的颜色
  				                                        }], false) ]
  				                                ],
  				                                width : 18
  				                            }
  				                        },
  				                        splitLine : {
  				                            show : false,
  				                            length : 2
  				                        },
  				                        axisTick : {
  				                            show : false
  				                        },
  				                        axisLabel : {
  				                            formatter : function ( e ) {
  				                                if ( e == 0 || e == 100 ) {
  				                                    return "";
  				                                }
  				                                return e;
  				                            },
  				                            color : "#c2b6b6",
  				                            fontFamily : "Arial",
  				                            distance : 0
  				                        },
  				                        pointer : {
  				                            show : false
  				                        },
  				                        detail : {
  				                            show : false
  				                        }
  				                    }
  				                ]
  				            };
  						//echart图表自适应
			            window.addEventListener("resize", function () {
			            myChart5.resize();
			            });

  						/*setInterval(function () {
  							echarts.dispose(document.getElementById("main5"));
			  	  	        var myChart5 = echarts.init(document.getElementById('main5'));
			  	  	        option5.series[0].data[0].value = (Math.random() * 100).toFixed(2) - 0;
  						    myChart5.setOption(option5, true);
  						    $("#nodata5").css("display","none"); 
	    					$("#main5").css("display","block"); 
  						},2000);*/
  					echarts.dispose(document.getElementById("main5"));
	  					var myChart5 = echarts.init(document.getElementById('main5'));
	  			        myChart5.setOption(option5); 
	  			    	$("#nodata5").css("display","none"); 
						$("#main5").css("display","block");	                    

				}else{ 
					$("#main5").html("<br/><br/><img src=\"img/codeerror.gif\" />");				
				}
				
			}else{
				$("#nodata5").css("display","block");
				$("#main5").css("display","none");
			}
		},
	error : function () {
		$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
		return false;
	}
	});		
					
}
function getHomeAcctChargeLiveRateRate() {     //仪表盘                       连接活跃率		
	$.ajax({
			type: "POST",
			url: "piechart/getHomeRate.do",
			data: param,
			datatype: "json",
			//success: function(data){
			//	console.log(data);
			//	var accountNumValue=(Number(data.datas[0].accountNumRate)).toFixed(2);//add in 2018-09-26
		//	$("#accountNum").html((data.datas[0].accountNum)+ "  环比：" + (data.datas[0].accountNumRate)+"%"); 	
	success: function(data){
			if (data.datas.length>0) {
				if(data.code==200){
					datas = data.datas; 
  					var acctChargeLiveRate = Number(datas[0].acctChargeLiveRate).toFixed(2)*100;

  					var acctChargeLiveRate2 = Number(datas[0].acctChargeLiveRate).toFixed(2);
  					/* option7 = {
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
  						          	radius: '90%',
  						            axisLine: {
        	                                lineStyle: {
        	                                    color: [[0.0, '#0083fe'], [0.2, '#0083fe'], [0.8, '#0070fd'], [1, '#0066fe']]
        	                                },
  						        	},
  						          	detail : {
  										formatter:'{value}%',
  										borderColor: '#fff',	    	              
  										offsetCenter: [0, '70%'],  // x, y，单位px
  										textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
  										       	 fontWeight: 'bolder',
  										         fontSize: '20',	
  										         color:'#0083fe'
  										       	  }
  										     },
  						            //data: [{value: acctChargeLiveRate, name: '连接活跃率'}]
  						          	data: [{value: acctChargeLiveRate, name: ''}]
  						        }
  						    ]
  						}; */
  						
						var option7 = {
  								
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
  				                        type: "gauge",
  				                        center: ["50%", "50%"], // 默认全局居中
  				                        radius: "94%",
  				                        axisLine: {
  				                            show: false,
  				                            lineStyle: { // 属性lineStyle控制线条样式
  				                                color: [
  				                                    [acctChargeLiveRate2, "#ffd71a"],
  				                                    [1, "#494c3b"]
  				                                ],
  				                                width: 5
  				                            }
  				                        },
  				                        splitLine: {
  				                            show: false
  				                        },
  				                        axisTick: {
  				                            show: false
  				                        },
  				                        axisLabel: {
  				                            show: false
  				                        },
  				                        pointer: {
  				                            show: true
  				                        },
  				                        detail: {
  				                            formatter : "{score|{value}%}\n{name|连接活跃率}",
  				                            offsetCenter: [0, "5%"],
  				                          	offsetCenter: [0, '40%'],  // x, y，单位px
  				                            rich : {
  				                                score : {
  				                                    color : "#ffd71a",
  				                                    fontFamily : "微软雅黑",
  				                                    fontSize :25
  				                                },
  				                                name : {
  				                                    height : 25,
  				                                    color : "#526680",
  				                                    fontFamily : "微软雅黑",
  				                                    fontSize : 14
  				                                }
  				                            }
  				                        },
  				                      data: [{value: acctChargeLiveRate, name: ''}]
  				                    },
  				                    {
  				                        type : "gauge",
  				                        center: ["50%", "50%"], // 默认全局居中
  				                        radius : "83%",
  				                        axisLine : {
  				                            show : true,
  				                            lineStyle : { // 属性lineStyle控制线条样式
  				                                color : [
  				                                    [ 0.1,  new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
  				                                        offset: 1,
  				                                        color: "rgba(59, 71, 82, 0)" // 0% 处的颜色
  				                                    }, {
  				                                        offset: 0,
  				                                        color: "rgba(59, 71, 82, 0.5)" // 100% 处的颜色
  				                                    }], false) ],
  				                                    [ 0.9, "rgba(59, 71, 82, 0.5)" ],
  				                                    [ 1,  new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
  				                                        offset: 1,
  				                                        color: "rgba(59, 71, 82, 0.5)" // 0% 处的颜色
  				                                    },
  				                                        {
  				                                            offset: 0.8,
  				                                            color: "rgba(59, 71, 82, 0.3)" // 0% 处的颜色
  				                                        },
  				                                        {
  				                                            offset: 0.5,
  				                                            color: "rgba(59, 71, 82, 0.2)" // 0% 处的颜色
  				                                        },
  				                                        {
  				                                            offset: 0,
  				                                            color: "rgba(59, 71, 82, 0)" // 100% 处的颜色
  				                                        }], false) ]
  				                                ],
  				                                width : 18
  				                            }
  				                        },
  				                        splitLine : {
  				                            show : false,
  				                            length : 2
  				                        },
  				                        axisTick : {
  				                            show : false
  				                        },
  				                        axisLabel : {
  				                            formatter : function ( e ) {
  				                                if ( e == 0 || e == 100 ) {
  				                                    return "";
  				                                }
  				                                return e;
  				                            },
  				                            color : "#c2b6b6",
  				                            fontFamily : "Arial",
  				                            distance : 0
  				                        },
  				                        pointer : {
  				                            show : false
  				                        },
  				                        detail : {
  				                            show : false
  				                        }
  				                    }
  				                ]
  				            };
  						//echart图表自适应
			            window.addEventListener("resize", function () {
			            myChart7.resize();
			            });

  						/*setInterval(function () {
  							echarts.dispose(document.getElementById("main5"));
			  	  	        var myChart5 = echarts.init(document.getElementById('main5'));
			  	  	        option5.series[0].data[0].value = (Math.random() * 100).toFixed(2) - 0;
  						    myChart5.setOption(option5, true);
  						    $("#nodata5").css("display","none"); 
	    					$("#main5").css("display","block"); 
  						},2000);*/
  					echarts.dispose(document.getElementById("main7"));
	  					var myChart7 = echarts.init(document.getElementById('main7'));
	  			        myChart7.setOption(option7);   
	  			    	$("#nodata7").css("display","none"); 
						$("#main7").css("display","block");	                    

				}else{ 
					$("#main7").html("<br/><br/><img src=\"img/codeerror.gif\" />");				
				}
				
			}else{
				$("#nodata7").css("display","block");
				$("#main7").css("display","none");
			}
		},
	error : function () {
		$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
		return false;
	}
	});		
					
}
	
function getActiNumRate() {//仪表盘 连接激活率
	$.ajax({
			type: "POST",
			url: "piechart/getHomePgFourTb.do",
			data: param,
			datatype: "json",
			success: function(data){

				var myChart7 = echarts.init(document.getElementById('main8'));
				$("#activityTrend").html(Number(data.datas[0].activityTrend).toFixed(2)+"%");
				var  actRate = Number(data.datas[0].activityTrend).toFixed(2)/100;
				/* var option = {
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
					            radius: '90%',
					            axisLine: {
       	                                lineStyle: {
       	                                    color: [[0.0, '#0083fe'], [0.2, '#0083fe'], [0.8, '#0070fd'], [1, '#0066fe']]
       	                                },
 						        },
					            detail : {
									formatter:'{value}%',
									borderColor: '#fff',	    	              
									offsetCenter: [0, '70%'],  // x, y，单位px
									textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
										       	 fontWeight: 'bolder',
										         fontSize: '20',
										         color:'#0083fe'
										       	  }
										     },
					            //data: [{value: 50, name: '连接数激活率'}]
					            data: [{value: 80, name: ''}]
					        }
					    ]
					}; */
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
				                        type: "gauge",
				                        center: ["50%", "50%"], // 默认全局居中
				                        radius: "94%",
				                        axisLine: {
				                            show: false,
				                            lineStyle: { // 属性lineStyle控制线条样式
				                                color: [
				                                    [actRate, "#ffd71a"],
				                                    [1, "#494c3b"]
				                                ],
				                                width: 5
				                            }
				                        },
				                        splitLine: {
				                            show: false
				                        },
				                        axisTick: {
				                            show: false
				                        },
				                        axisLabel: {
				                            show: false
				                        },
				                        pointer: {
				                            show: true
				                        },
				                        detail: {
				                            formatter : "{score|{value}%}\n{name|连接数激活率}",
				                            offsetCenter: [0, "5%"],
				                          	offsetCenter: [0, '40%'],  // x, y，单位px
				                            rich : {
				                                score : {
				                                    color : "#ffd71a",
				                                    fontFamily : "微软雅黑",
				                                    fontSize :25
				                                },
				                                name : {
				                                    height : 25,
				                                    color : "#526680",
				                                    fontFamily : "微软雅黑",
				                                    fontSize : 14
				                                }
				                            }
				                        },
				                        data: [{value: 80, name: ''}]
				                    },
				                    {
				                        type : "gauge",
				                        center: ["50%", "50%"], // 默认全局居中
				                        radius : "83%",
				                        axisLine : {
				                            show : true,
				                            lineStyle : { // 属性lineStyle控制线条样式
				                                color : [
				                                    [ 0.1,  new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
				                                        offset: 1,
				                                        color: "rgba(59, 71, 82, 0)" // 0% 处的颜色
				                                    }, {
				                                        offset: 0,
				                                        color: "rgba(59, 71, 82, 0.5)" // 100% 处的颜色
				                                    }], false) ],
				                                    [ 0.9, "rgba(59, 71, 82, 0.5)" ],
				                                    [ 1,  new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
				                                        offset: 1,
				                                        color: "rgba(59, 71, 82, 0.5)" // 0% 处的颜色
				                                    },
				                                        {
				                                            offset: 0.8,
				                                            color: "rgba(59, 71, 82, 0.3)" // 0% 处的颜色
				                                        },
				                                        {
				                                            offset: 0.5,
				                                            color: "rgba(59, 71, 82, 0.2)" // 0% 处的颜色
				                                        },
				                                        {
				                                            offset: 0,
				                                            color: "rgba(59, 71, 82, 0)" // 100% 处的颜色
				                                        }], false) ]
				                                ],
				                                width : 18
				                            }
				                        },
				                        splitLine : {
				                            show : false,
				                            length : 2
				                        },
				                        axisTick : {
				                            show : false
				                        },
				                        axisLabel : {
				                            formatter : function ( e ) {
				                                if ( e == 0 || e == 100 ) {
				                                    return "";
				                                }
				                                return e;
				                            },
				                            color : "#c2b6b6",
				                            fontFamily : "Arial",
				                            distance : 0
				                        },
				                        pointer : {
				                            show : false
				                        },
				                        detail : {
				                            show : false
				                        }
				                    }
				                ]
				            };
					//echart图表自适应
					window.addEventListener("resize", function () {
					myChart7.resize();
					});

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
function getPlatformIncome(){//各省上账期应收账款
	var getOrderTrend =[];
		$.ajax({
			type: "POST",
			url: "piechart/getPlatformIncome.do",//getPlatformIncome.do",
			data: param,
			datatype: "json",
			success: function(data){
				if (data.datas.length>0) {
					if(data.code==200){
						datas = data.datas; 
						//console.log(data);
						//console.log(datas);
	  					var float1 = 0;
	  					var forecast = 0;
	  					var allcount = 0;
	  					for(var d in datas){
	  						allcount= allcount+1;
	  						if (datas[d].isForecastFlag==1) forecast=forecast+1;  //20181018
	  						var fvalue = datas[d].value; 
	  						float1 = (parseFloat(fvalue)/10000).toFixed(2);
	  					    getOrderTrend.push([
	  	  				            datas[d].name.trim(),
	  	  				        	float1
	  	  				        ]);  						
	  					}     	  					
	  					//console.log(getOrderTrend);
	  				    //console.log(getOrderTrend.map(function (item) {return item[0];});
				            option6 = {
				            	    //backgroundColor:'#04315e',
				            	    title : {
				            	        //text: '各省上账期应收账款（万元）',
				            	        x:'center',
		  					            y:'top',
		  					            textStyle:{
		  					              color:'white'
		  					            } 		  					            
				            	    },
				            	    tooltip : {
				  	  			        trigger: 'axis',
				  	  			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				  	  			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				  	  			        }
				  	  			    },	  
				            	  grid: {
				  	  		        left: 50,
				  	  		        right: 20,
				  	  		        top: 10,
				  	  		        bottom: 55,
			  	  		    	}, 
/*   	  	  					        visualMap: {
	  	  					            show: false,
	  	  					            dimension: 0,
	  	  					            pieces: [ { 
	  	  					                lte: allcount-forecast-1,
	  	  					                color: '#cc0033'
	  	  					            }, { 
	  	  					                gt: allcount-forecast-1,
	  	  					                color: '#ff9933'
	  	  					            }]
	  	  					        }, */
				            	    calculable : true,
				            	    xAxis : [
				            	        {
				            	            type : 'category',  				            	     
				            	            data : getOrderTrend.map(function (item) {
				            	                return item[0];  				            	                
				            	            }),
		            	                axisLabel:{ 
			                            	show:true,
			                            	formatter:function(value)  
			                               {  
			                                   return value.split("").join("\n");  
			                               },
			                            	interval:0,            	            
	            	                	}, 
				            	        }
				            	    ],
				            	    yAxis : [
				            	        {
				            	            type : 'value',
				
				            	        }
				            	    ],
				            	    series : [
				            
				  	                       //柱一
				  	                         {
				            	        	name:'应收账款',
				  	                               type:'bar',
				  	                           data:getOrderTrend.map(function (item) {
	  				            	                return item[1];
	  				            	            }),
	  				            	          	barMaxWidth: 6,
				  	                             color:'#fff',
				  	                             label: {
				  	                              normal: {
				  	                                  show: false,
				  	                                  position: 'top',
				  	                                  color:'fff',  
				  	                              }
				  	                          },
				  	                             itemStyle: {
				  	                              emphasis: {
				  	                                        barBorderRadius:[5, 5, 0, 0],
				  	                                    },
				  	                               normal: {
				  	                                barBorderRadius:[5, 5, 0, 0],
				  	                                 color: new echarts.graphic.LinearGradient(
				  	                                   0, 0, 0, 1,
				  	                                 [
				  	                                	{offset: 0, color: '#63a5ff'}, 
				  				                    	{offset: 1, color: '#5e74fd'}, 
				  	                                  
				  	                                 ]
				  	                              )
				  	                         },
				  	                         emphasis: {
				  	                           color: new echarts.graphic.LinearGradient(
				  	                                 0, 0, 0, 1,
				  	                                [
				  	                                	{offset: 0, color: '#63a5ff'}, 
				  				                    	{offset: 1, color: '#5e74fd'},
				  	                                ]
				  	                           )
				  	                          }
				  	                      }
				  	                  },
				            	    ]
				            	}; 
				          	//echart图表自适应
				            window.addEventListener("resize", function () {
				            myChart6.resize();
				            });
				          	
				      		echarts.dispose(document.getElementById("main6"));
			  	  	        var myChart6 = echarts.init(document.getElementById('main6'));
	  			        	myChart6.setOption(option6);  
	  	  	  			    $("#nodata6").css("display","none"); 
	    					$("#main6").css("display","block"); 
					}else{ 
						$("#main6").html("<br/><br/><img src=\"img/codeerror.gif\" />");				
					}
					
				}else{
					$("#nodata6").css("display","block");
					$("#main6").css("display","none");
				}
			},
		error : function () {
			$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
			return false;
		}
		});
}
function getIncome(){//全国应收账款趋势（万元）
	var xName = [];
	var yValue = [];
		$.ajax({
			type: "POST",
			url: "piechart/getIncome.do",
			data: param,
			datatype: "json",
			success: function(data){
				 if (data.datas.length>0) {
					if(data.code==200){
						var lineChartByConnHisTrend1 =[];
	  					var lineChartByConnHisTrend2 =[];
	  					var startMonth;
						datas = data.datas;
						startMonth = datas[0].name;
	  					 for(var d in datas){  	  						 	  						 
	  						xName.push(datas[d].name);  	  						
	  						yValue.push((parseFloat(datas[d].value)/10000).toFixed(2));
	  						lineChartByConnHisTrend1.push( 	 
	  							parseInt((datas[d].name).split("-")[1])+"月"        //datas[d].name值为2018-03-13样式，取出月份显示
	  				        );  
	  						lineChartByConnHisTrend2.push(
	  							(parseFloat(datas[d].value)/10000).toFixed(2)
	  				        );
	  					} 
	  					/* option7 = {
  	  						tooltip: {
  	  				        trigger: 'axis',
  	  				        position: function (pt) {
  	  				            return [pt[0], '10%'];
  	  				        }
  	  				    },
  	  				    title: {
  	  				        left: 'center',
  	  				        text: '全国应收账款趋势',
  	  				    },
  	  				    toolbox: {
  	  				        // feature: {
  	  				         //   saveAsImage: {}
  	  				       // } 
  	  				    },
  	  				    xAxis: {
  	  				        type: 'category',
  	  				        boundaryGap: false,
  	  				        data: xName
  	  				    },
  	  				    yAxis: {
  	  				        type: 'value',
  	  				        boundaryGap: false
  	  				    },
  	  				    dataZoom: [{
  	  				        type: 'inside',
  	  				        start: 0,
  	  				        end: 10
  	  				    }, {
  	  				        start: 0,
  	  				        end: 10,
  	  				        handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
  	  				        handleSize: '100%',
  	  				        handleStyle: {
  	  				            color: '#fff',
  	  				            shadowBlur: 3,
  	  				            shadowColor: 'rgba(0, 0, 0, 0.6)',
  	  				            shadowOffsetX: 2,
  	  				            shadowOffsetY: 2
  	  				        }
  	  				    }],
  	  				    series: [
  	  				        {
  	  				            name:'收入(万元)',
  	  				            type:'line',
  	  				            smooth:true,
  	  				            symbol: 'none',
  	  				            sampling: 'average',
  	  				            itemStyle: {
  	  				                normal: {
  	  				                    color: 'rgb(255, 70, 131)'
  	  				                }
  	  				            },
  	  				            areaStyle: {
  	  				                normal: {
  	  				                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
  	  				                        offset: 0,
  	  				                        color: 'rgb(255, 158, 68)'
  	  				                    }, {
  	  				                        offset: 1,
  	  				                        color: 'rgb(255, 70, 131)'
  	  				                    }])
  	  				                }
  	  				            },
  	  				            data: yValue
  	  				        }
  	  				    ]
				            }; */ 
                       var str = lineChartByConnHisTrend1[0];
				           //var mon = alert(str.substring(6,9));
				           //console.log(str);
				           
				           var option9 = {
				        		  //backgroundColor:'#04315e',
	  	  							title: {
		  	  					            //text: '全国应收账款趋势（万元）',
		  	  					            x:'center',
			  					            y:'top',
	  		  					            textStyle:{
	  		  					              color:'white'
	  		  					            }
		  	  					        },
		  	  					    grid: {
		  	  					    	top:10,
		  	  					    	left: 60,
		  	  					    	right: 20,
		  	  					    	bottom: 20,
		  	  					    //containLabel: true,
		  	  					    //y2: 10
		  	  					    },
				  	  					tooltip : {
				  	  			        trigger: 'axis',
				  	  			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				  	  			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				  	  			        }
				  	  			    },	  	  					      
		  	  					        xAxis:[ { 
		  	  					            data:lineChartByConnHisTrend1, 
		  	  					        	splitLine: {
		  	  					        		show: false
		  	  					        	},
		  	  					        }] ,
		  	  					        yAxis: {
		  	  					            splitLine: {
		  	  					                show: true
		  	  					            },
		  	  					        /* ,
		  	  					            min:Math.min.apply(Math, lineChartByConnHisTrend2) */ 
		  	  					        },   
/*  		  	  					        dataZoom: [{
	  	  	  					            startValue: startMonth
	  	  	  					        }, {
	  	  	  					            type: 'inside'
	  	  	  					        }], */
		  	  					        series: [{
		  	  					            name: "收入(万元)",
		  	  					            type: 'line',
		  	  					            symbol:'circle',
		  	  					            symbolSize:7,
		  	  					            data: lineChartByConnHisTrend2,		  	  					       
		  	  					     		//折线修改
					  	  		            itemStyle : {
												normal : {
													color:'#ffcf10',//点
													lineStyle:{
														color:'#ffcf10'//线
													}
												}
											},
		  	  					        }]
	  	  	  				        };
				        	 //echart图表自适应
				            window.addEventListener("resize", function () {
				            myChart9.resize();
				            });
				        	 
	  						echarts.dispose(document.getElementById("main9"));
			  	  	        var myChart9 = echarts.init(document.getElementById('main9'));
	  			        	myChart9.setOption(option9);  
	  	  			    	$("#nodata9").css("display","none"); 
	  						$("#main9").css("display","block"); 
					}else{  
						$("#main9").html("<br/><br/><img src=\"img/codeerror.gif\" />");							
					}
					
				}else{
					$("#nodata9").css("display","block");
					$("#main9").css("display","none"); 
				}
			},
		error : function () {
			$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
			return false;
		}
		});
}

function getAreaTop(){//地图
	$.ajax({
		type: "POST",
		url: "piechart/getAreaTop.do",
		data: param,
		datatype: "json",
		success: function(data){
			if (null!=data.datas&&data.datas.length>0) {
				if(data.code==200){  
					datas = data.datas; 
	  				    //迁徙图开始
  	  				var dom = document.getElementById('mapContainer');
  	  	  			var myChart = echarts.init(dom);
  	  	  			var app = {};
  	  	  			var option = null;
	  	  	  		var mapData =[]; 
	  	  	  		var NJData =[]; 
	  	  	  	    var tempData = [{name:'江苏'}];
	  	  	  	    //alert(tempData[0].name);
	  	  			var geoCoordMap = {
	  	  				    '上海': [121.4648,31.2891],
	  	  				    '重庆': [107.7539,30.1904],
	  	  				    '北京': [116.4551,40.2539],
	  	  				    '天津': [117.4219,39.4189],
	  	  				    '辽宁': [123.1238,42.1216],
	  	  				    '吉林': [125.8154,44.2584],
	  	  				    '黑龙江': [127.9688,45.368], 
	  	  				    '西藏': [91.1865,30.1465],
	  	  				    '新疆': [87.9236,43.5883],
	  	  				    '甘肃': [103.5901,36.3043],
	  	  				    '内蒙古': [111.4124,40.4901],
	  	  				    '宁夏': [106.3586,38.1775],
	  	  				    '青海': [101.4038,36.8207],
	  	  				    '四川': [103.9526,30.7617],
	  	  				    '云南': [102.9199,25.4663],
	  	  				    '陕西': [109.1162,34.2004],
	  	  				    '山西': [112.3352,37.9413],
	  	  				    '山东': [117.1582,36.8701],
	  	  				    '河北': [114.4995,38.1006],
	  	  				    '河南': [113.4668,34.6234], 
	  	  				    '江西': [116.0046,28.6633],
	  	  				    '江苏': [118.8062,31.9208],
	  	  				    '浙江': [119.5313,29.8773],
	  	  				    '湖北': [114.3896,30.6628],
	  	  				    '湖南': [113.0823,28.2568],
	  	  				    '贵州': [106.6992,26.7682],
	  	  				    '安徽': [117.29,32.0581],
	  	  				    '广西': [108.479,23.1152],
	  	  				    '福建': [119.4543,25.9222],
	  	  				    '广东': [113.5107,23.2196],
	  	  				    '海南': [110.3893,19.8516],
	  	  				    '澳门': [113.5515, 22.1094],
	  	  				    '香港': [114.0667, 22.5886],
	  	  				    '台湾': [121.4992, 25.1265]
	  	  				};
	  	  			//top10省份
	  	  			for(var d in datas){
  						mapData.push({
  				            name: datas[d].name,
  				            value: datas[d].value
  				        }); 												
  					} 
	  	  			//组装迁移map数组
		  	  		for(var c in datas){
		  	  			var temp = [];
		  	  			temp.push(tempData[0],mapData[c]); 	
		  	  		    NJData.push(temp);
  					} 
	  	  			
	  	  		    //var NJData = [
	  	  			//    [{name:'南京'},{name:'呼和浩特',value:95}],
	  	  			//    [{name:'南京'},{name:'昆明',value:90}],
	  	  			//    [{name:'南京'},{name:'广州',value:80}],
	  	  			//    [{name:'南京'},{name:'郑州',value:70}],
	  	  			//    [{name:'南京'},{name:'长春',value:60}],
	  	  			//    [{name:'南京'},{name:'成都',value:50}],
	  	  			//     [{name:'南京'},{name:'乌鲁木齐',value:40}],
	  	  			//     [{name:'南京'},{name:'北京',value:30}],
	  	  			//     [{name:'南京'},{name:'兰州',value:20}],
	  	  			//     [{name:'南京'},{name:'拉萨',value:37}]
	  	  			// ];
	  	  			
	  	  			//自定义图标路径
	  	  		    var iconPath = 'img/switch_icon.png';
	  	  			//var dataItem = [];
	  	  		    var convertData = function(datas) {
	  	  		        var res = [];
	  	  		        for (var i = 0; i < datas.length; i++) {
	  	  		        var dataItem = datas[i];
	  	  		            var fromCoord = geoCoordMap[dataItem[0].name];
	  	  		            var toCoord = geoCoordMap[dataItem[1].name];
	  	  		            if (fromCoord && toCoord) {
	  	  		                res.push({
	  	  		                    fromName: dataItem[0].name,
	  	  		                    toName: dataItem[1].name,
	  	  		                    coords: [fromCoord, toCoord]
	  	  		                });
	  	  		            }
	  	  		        }
	  	  		        return res;
	  	  		    };
	  	  		    
	  	  		    
	  	  		    var color = ['#ffcc00','#F10900','#00A0E9'];
	  	  		    var series = [];
	  	  		    [['', NJData]].forEach(function(item, i) {
	  	  		        series.push({
	  	  		            name: item[0] + ' Top10',
	  	  		            type: 'effectScatter',
	  	  		            coordinateSystem: 'geo',
	  	  		            zlevel: 2,
	  	  		            rippleEffect: {
	  	  		                brushType: 'stroke'
	  	  		            },
	  	  		            label: {
	  	  		                normal: {
	  	  		                    show: true,
	  	  		                    position: 'right',
	  	  		                    formatter: '{b}'
	  	  		                }
	  	  		            },
	  	  		        symbolSize: function (val) {
				            	if(val[2] <0){
				            		return 2;
				            	}else if(val[2] * 500<2){
						           return val[2] * 500+1;
				                }else if(val[2] * 500>7&&val[2] * 500<10){
				                	return val[2] * 500-3
				                }else if(val[2] * 500>10){
				                	return 8
				                }else{
				                	return val[2] * 500
				                }
				            },
	  	  		            itemStyle: {
	  	  		                normal: {
	  	  		                    color: color[i]
	  	  		                }
	  	  		            },
	  	  		            data: item[1].map(function (dataItem) {
	  	  		                return {
	  	  		                    name: dataItem[0].name,
	  	  		                    value: geoCoordMap[dataItem[0].name]
	  	  		                };
	  	  		            }) 
	  	  		        }, {
	  	  		            name: item[0] + ' Top10',
	  	  		            type: 'lines',
	  	  		            zlevel: 1,
	  	  		            //是否显示图标尾部效果
	  	  		            effect: {
	  	  		                show: true,
	  	  		                period: 6,
	  	  		                trailLength: 0.6,
	  	  		                color: '#fff',
	  	  		                symbolSize: 2
	  	  		            },
	  	  		            lineStyle: {
	  	  		                normal: {
	  	  		                    color: color[i+3],
	  	  		                    width: 0,
	  	  		                    curveness: 0.2
	  	  		                }
	  	  		            },
	  	  		            data: convertData(item[1])
	  	  		        }, {
	  	  		            name: item[0] + ' Top10',
	  	  		            type: 'lines',
	  	  		            zlevel: 2,
	  	  		            effect: {
	  	  		                show: true,
	  	  		                period: 6,
	  	  		                trailLength:0,
	  	  		                symbol: 'arrow',
	  	  		                symbolSize: 6,
	  	  		                color:'#ffcc00'
	  	  		            },
	  	  		            lineStyle: {
	  	  		                normal: {
	  	  		                    color: color[i+1],
	  	  		                    width: 1,
	  	  		                    opacity: 0.4,
	  	  		                    curveness: 0.2
	  	  		                }
	  	  		            },
	  	  		            data: convertData(item[1])
	  	  		        }, {
	  	  		            name: item[0] + ' Top10',
	  	  		            type: 'effectScatter',
	  	  		            coordinateSystem: 'geo',
	  	  		            zlevel: 2,
	  	  		            rippleEffect: {
	  	  		                brushType: 'stroke'
	  	  		            },
	  	  		            label: {
	  	  		                normal: {
	  	  		                    show: true,
	  	  		                    position: 'right',
	  	  		                    formatter: '{b}'
	  	  		                }
	  	  		            },
	  	  		        symbolSize: function (val) {
				            	if(val[2] <0){
				            		return 2;
				            	}else if(val[2] * 500<2){
						           return val[2] * 500+1;
				                }else if(val[2] * 500>7&&val[2] * 500<10){
				                	return val[2] * 500-3
				                }else if(val[2] * 500>10){
				                	return 8
				                }else{
				                	return val[2] * 500
				                }
				            },
	  	  		            itemStyle: {
	  	  		                normal: {
	  	  		                    color: color[i]
	  	  		                }
	  	  		            },
	  	  		            data: item[1].map(function(dataItem) {
	  	  		                return {
	  	  		                    name: dataItem[1].name,
	  	  		                    value: geoCoordMap[dataItem[1].name].concat([dataItem[1].value])
	  	  		                };
	  	  		            })
	  	  		        });
	  	  		    });
	
	  	  		    option = {
	  	  		        //网页背景部分
	  	  		        //backgroundColor: '#404a59',
	  	  		        title: {
	  	  		            //text: '南京物联网连接数图',
	  	  		            //subtext: '数据',
	  	  		            left: 'center',
	  	  		            textStyle: {
	  	  		                color: '#fff'
	  	  		            }
	  	  		        },
	  	  		        tooltip: {
	  	  		            trigger: 'item'
	  	  		        },

	  	  		        layoutCenter: ['50%', '50%'],
	  	  		        // 如果宽高比大于 1 则宽度为 100，如果小于 1 则高度为 100，保证了不超过 100x100 的区域
	  	  		        layoutSize: '130%',
	  	  		        legend: {
	  	  		            orient: 'vertical',
	  	  		            top: 'bottom',
	  	  		            left: 'right',
	  	  		            //data: ['南京 Top10'],
	  	  		            textStyle: {
	  	  		                color: '#fff'
	  	  		            },
	  	  		            selectedMode: 'single'
	  	  		        },
	  	  		        geo: {
	  	  		            map: 'china',
	  	  		            label: {
	  	  		                emphasis: {
	  	  		                    show: true
	  	  		                }
	  	  		            },
	  	  		           //zoom: 0.7,
	  	  		            roam: true,
	  	  		            itemStyle: {
	  	  		                normal: {
	  	  		                	//地图颜色
	  	  		                	areaColor: '#42489a',
	  	  		                	//省份分割线颜色
	  	  		                    borderColor: '#2e337d'
	  	  		                },
	  	  		                emphasis: {
	  	  		                	//鼠标经过颜色
	  	  		                	 areaColor: '#2e337d'
	  	  		                }
	  	  		            }
	  	  		        },
	  	  		        series: series
	  	  		    };
	  	  			//echart图表自适应
		            window.addEventListener("resize", function () {
		            myChart.resize();
		            });
	  	  		    
	  	  		    if (option && typeof option === "object") {
	  	  		        myChart.setOption(option, true);
	  	  		    }
				}
				
			}else{
				$("#nodata2").css("display","block");
				$("#main2").css("display","none");
			}
		}
  	});
}


function getCustomNewAndCurrent(){//各省已激活及新增激活连接数（万个）
	var xDate = [];
	var yDate = [];
	var yDate2 = [];
		$.ajax({
			type: "POST",
			url: "piechart/getCustomNewAndCurrent.do",
			data: param,
			datatype: "json",
			success: function(data){
				if (data.length>0) {  
	  					for(var d in data){  
	  						xDate.push(data[d].provinceName); 
	  						yDate.push(data[d].newConnectNum*10);   
	  						yDate2.push(data[d].cha);   
	  					}    
	    				option15 = {
	    					    tooltip : {
	    					        trigger: 'axis',
	    					        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	    					            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	    					        },
	    					        formatter: function (params) {
	    					            var tar = params[1];
	    					            var tar0 = params[0];
	    					            var v = tar.value +tar0.value/10;
	    					            var v2 = tar0.value/10;
	    					            return tar.name + '<br/>' + tar.seriesName + ' : ' +v+
	    					            '<br/>'+ tar0.seriesName + ' : ' +v2;
	    					        }
	    					    }, 
	    					    grid: {
		  					    	top:80,
		  					    	left: 70,
		  					    	right: 20,
		  					    	bottom:55,
		  					    },
		  					  legend: {
		    			        	left:'right',
		    			        	itemWidth: 10,
		    			            itemHeight: 10,
		    			            itemGap: 10,
		    			          	padding:[18, 0, 15, 20] ,
		    				        data:['各省已激活数','新增'],
		    			            textStyle: {
		    			            	fontSize:12,
		    			            	//color:'#777'
		    			         }
		    			        },
	    					    yAxis:  {
	    					        type: 'value'
	    					    },
	    					    xAxis: {
	    					        type: 'category',
	    					        data: xDate,
	    					        axisLabel:{ 
		                            	show:true,
		                            	formatter:function(value)  
		                               {  
		                                   return value.split("").join("\n");  
		                               },
		                            	interval:0,
            	                	textStyle:{ 
            	                		color:'#617685',
            	                	}	            	            
            	                }, 
	    					    },
	    					    series: [
	    					        {
	    					            name: '新增',
	    					            type: 'bar',
	    					            stack: '总量', 
	    					            data: yDate,
	    					            barMaxWidth: 6,
	    					            label: {
			  	                              normal: {
			  	                                  show: false,
			  	                                  position: 'top',
			  	                                  color:'fff',  
			  	                              }
			  	                          },
			  	                             itemStyle: {
			  	                              emphasis: {
			  	                                        barBorderRadius:[0, 0, 0, 0],
			  	                                    },
			  	                               normal: {
			  	                                barBorderRadius:[0, 0, 0, 0],
			  	                                 color: new echarts.graphic.LinearGradient(
			  	                                   0, 0, 0, 1,
			  	                                 [
			  	                                	{offset: 0, color: '#63a5ff'}, 
			  				                    	{offset: 1, color: '#5e74fd'}, 
			  	                                  
			  	                                 ]
			  	                              )
			  	                         },
			  	                         emphasis: {
			  	                           color: new echarts.graphic.LinearGradient(
			  	                                 0, 0, 0, 1,
			  	                                [
			  	                                	{offset: 0, color: '#63a5ff'}, 
			  				                    	{offset: 1, color: '#5e74fd'},
			  	                                ]
			  	                           )
			  	                          }
			  	                      }
	    					        },
	    					        {
	    					            name: '各省已激活数',
	    					            type: 'bar',
	    					            stack: '总量',
	    					            data: yDate2,
	    					            barWidth: 10,
	    					            label: {
			  	                              normal: {
			  	                                  show: false,
			  	                                  position: 'top',
			  	                                  color:'fff',  
			  	                              }
			  	                          },
			  	                             itemStyle: {
			  	                              emphasis: {
			  	                                        barBorderRadius:[5, 5, 0, 0],
			  	                                    },
			  	                               normal: {
			  	                                barBorderRadius:[5, 5, 0, 0],
			  	                                 color: new echarts.graphic.LinearGradient(
			  	                                   0, 0, 0, 1,
			  	                                 [
			  	                                	{offset: 1, color: '#ffd66c'}, 
			  				                    	{offset: 0, color: '#feb127'},  
			  	                                  
			  	                                 ]
			  	                              )
			  	                         },
			  	                         emphasis: {
			  	                           color: new echarts.graphic.LinearGradient(
			  	                                 0, 0, 0, 1,
			  	                                [
			  	                                	{offset: 1, color: '#ffd66c'}, 
			  				                    	{offset: 0, color: '#feb127'}, 
			  	                                ]
			  	                           )
			  	                          }
			  	                      }
	    					        }
	    					    ] 
	    					};
	    				//echart图表自适应
			            window.addEventListener("resize", function () {
			            myChart15.resize();
			            });
	    				
				      		echarts.dispose(document.getElementById("main15")); 
			  	  	        var myChart15 = echarts.init(document.getElementById('main15'));
	  			        	myChart15.setOption(option15);   
	  	  			    	$("#nodata15").css("display","none"); 
	  						$("#main15").css("display","block"); 
	  						xDate.splice(0,xDate.length); 
	  						yDate.splice(0,yDate.length);
					/* }else{ 
						$("#main5").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
					} */
					
				}else{
					$("#nodata15").css("display","block");
					$("#main15").css("display","none");
				}
			},
		error : function () {  
			$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
			return false;
		}
		});
}

//全国激活连接数趋势（万个）
function getActiveByTrend(){
	var activeByTrend =[];
		$.ajax({
			type: "POST",
			url: "busAccSnap/getActiveByTrend.do",
			data: param,
			datatype: "json",
			success: function(data){
				if (data.datas.length>0) {
					if(data.code==200){
						datas = data.datas; 
	  					var float1 = 0;
	  					var forecast = 0;
	  					var allcount = 0;
	  					for(var d in datas){
	  						allcount= allcount+1;
	  						if (datas[d].isForecastFlag==1) forecast=forecast+1;
	  						var fvalue = datas[d].value.substring(0,datas[d].value.length-1); 
	  						float1 = parseFloat(fvalue).toFixed(2);
	  							activeByTrend.push([
	  	  				            datas[d].name.trim(),
	  	  				        	float1
	  	  				        ]);  						
	  					}  
				            option4 = { 
				            		tooltip : {
				  	  			        trigger: 'axis',
				  	  			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				  	  			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				  	  			        }
				  	  			    },	  
				            	    grid: {
			  					    	top:80,
			  					    	left: 70,
			  					    	right: 20,
			  					    	bottom:20,
			  					    },
	  	  					        visualMap: {
	  	  					            show: false,
	  	  					            dimension: 0,
	  	  					            pieces: [ { 
	  	  					                lte: allcount-forecast-1,
	  	  					                color: '#cc0033'
	  	  					            }, { 
	  	  					                gt: allcount-forecast-1,
	  	  					                color: '#ff9933'
	  	  					            }]
	  	  					        },
				            	    calculable : true,
				            	    xAxis : [
				            	        {
				            	            type : 'category',
				            	            data : activeByTrend.map(function (item) {
				            	                return item[0];
				            	            })
				            	        }
				            	    ],
				            	    yAxis : [
				            	        {
				            	            type : 'value'
				            	        }
				            	    ],
				            	    series : [
				            	        /* {
				            	            name:'激活连接数',
				            	            type:'bar',
				            	            barMaxWidth : 6,//柱图宽度
				            	            data:activeByTrend.map(function (item) {
				            	                return item[1];
				            	            }),
				            	            
				            	            markPoint : {
				            	                data : [
				            	                    {type : 'max', name: '最大值'},
				            	                    {type : 'min', name: '最小值'}
				            	                ]
				            	            },
				            	            markLine : {
				            	                data : [
				            	                    {type : 'average', name: '平均值'}
				            	                ]
				            	            }
				            	        } */
				            	        {
				            	        	name:'激活连接数',
				            	            type:'bar',
				            	            barMaxWidth : 6,//柱图宽度
				            	            data:activeByTrend.map(function (item) {
				            	                return item[1];
				            	            }),
								            label: {
				  	                              normal: {
				  	                                  show: false,
				  	                                  position: 'top',
				  	                                  color:'fff',  
				  	                              }
				  	                          },
				  	                             itemStyle: {
				  	                              emphasis: {
				  	                                        barBorderRadius:[5, 5, 0, 0],
				  	                                    },
				  	                               normal: {
				  	                                barBorderRadius:[5, 5, 0, 0],
				  	                         },
	
				  	                      },
				  	                    markPoint : {
			            	                data : [
			            	                    {type : 'max', name: '最大值'},
			            	                    {type : 'min', name: '最小值'}
			            	                ]
			            	            },
			            	            markLine : {
			            	                data : [
			            	                    {type : 'average', name: '平均值'}
			            	                ]
			            	            }
								        },
				            	    ]
				            	};
				          	//echart图表自适应
				            window.addEventListener("resize", function () {
				            myChart4.resize();
				            });
				          	
				      		echarts.dispose(document.getElementById("main4"));
			  	  	        var myChart4 = echarts.init(document.getElementById('main4')); 
	  			        	myChart4.setOption(option4);  
	    	  			    $("#nodata4").css("display","none"); 
	    					$("#main4").css("display","block"); 
					}else{ 
						$("#main4").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
					}
					
				}else{
				//	$("#main4").html("<br/><br/>激活率,无数据");  
					$("#nodata4").css("display","block");
					$("#main4").css("display","none");
				}
			},
		error : function () {
			$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
			return false;
		}
		});
}
function getCustomListCompare() {  //图表1 应收
	$.ajax({
			type: "POST",
			url: "piechart/getCustomListCompare.do",
			data: param,
			datatype: "json",
			success: function(data){ 
				var listString = "";
				for(var d in data){
					listString += "<tr>";
					var incomeqoqImgUrl=data[d].incomeQoqFlag>0?"%<span class='up'>⇡</span>":"%<span class='down'>⇣</span>"; 
					var incomedutyImgUrl=data[d].incomeDutyFlag>0?"%<span class='up'>⇡</span>":"%<span class='down'>⇣</span>"; 
					listString += "<td>"+data[d].provinceName+"</td>"; 
					listString += "<td>"+(Number(data[d].incomeQoq)*100).toFixed(2) +incomeqoqImgUrl+ "</td>"; 
					listString += "<td>"+(Number(data[d].incomeDuty)*100).toFixed(2) +incomedutyImgUrl+ "</td>"; 
					listString += "</tr>";	
				}     
				$("#customListCompare1").html(listString); 				
			},
		error : function () {
			$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
			return false;
		}
		});
}
function getCustomActiCompare() {  //图表2 连接趋势
	$.ajax({
			type: "POST",
			url: "piechart/getCustomActiCompare.do",
			data: param,
			datatype: "json",
			success: function(data){ 
				var listString = "";
				for(var d in data){
					listString += "<tr>";
					var actiNumQoqImgUrl=data[d].actiNumQoqFlag>0?"%<span class='up'>⇡</span>":"%<span class='down'>⇣</span>"; 
					var actiActualDutyImgUrl=data[d].actiActualDutyFlag>0?"%<span class='up'>⇡</span>":"%<span class='down'>⇣</span>"; 
					var actiNumDutyImgUrl=data[d].actiNumDutyFlag>0?"%<span class='up'>⇡</span>":"%<span class='down'>⇣</span>"; 
					var newActiDutyImgUrl=data[d].newActiDutyFlag>0?"%<span class='up'>⇡</span>":"%<span class='down'>⇣</span>"; 
					listString += "<td>"+data[d].provinceName+"</td>"; 
					listString += "<td>"+(Number(data[d].actiNumQoq)*100).toFixed(2)+ actiNumQoqImgUrl +"</td>"; 
					listString += "<td>"+(Number(data[d].actiActualDuty)*100).toFixed(2)+ actiActualDutyImgUrl +"</td>"; 
					listString += "<td>"+(Number(data[d].actiNumDuty)*100).toFixed(2)+ actiNumDutyImgUrl +"</td>"; 
					listString += "<td>"+(Number(data[d].newActiDuty)*100).toFixed(2)+ newActiDutyImgUrl +"</td>"; 
					listString += "</tr>";	
				}     
				$("#customListCompare2").html(listString); 				
			},
		error : function () {
			$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
			return false;
		}
		});
}
</script>
<body>
<input type="hidden" id="roleId" />
<div class="unicom"> 
	<div class="header">
		<span>首页<!-- 管理驾驶舱首页 --></span>
		<input type="text" class="time" id="monthDay" name="monthDay" placeholder="yyyy-mm-dd" readonly>
	</div>
	<style>
	.swiper-container {
		margin:-100px 0 0 20px;
		 width:calc(100% - 40px);
		width:-webkit-calc(100% - 40px);
		width:-moz-calc(100% - 40px);
		 height:240px;
	}
	.swiper-wrapper{
		margin:20px 0 0 0;
	}
	.swiper-slide {
		 margin:0 0 0 0;
		 text-align: center;
		 height:180px;
		 font-size: 18px;
		 background: #4b5cc5;
		 border-radius:4px;
		 cursor:pointer;
		 
		 -moz-box-shadow:0px 15px 25px rgba(0,0,0,0.1);
		-webkit-box-shadow:0px 15px 25px rgba(0,0,0,0.1);
		box-shadow:0px 15px 25px rgba(0,0,0,0.1);
	
		/* Center slide text vertically */
		display: -webkit-box;
		display: -ms-flexbox;
		display: -webkit-flex;
		display: flex;
		-webkit-box-pack: center;
		-ms-flex-pack: center;
		-webkit-justify-content: center;
		justify-content: center;
		-webkit-box-align: center;
		-ms-flex-align: center;
		-webkit-align-items: center;
		align-items: center;
	}
	.swiper-slide:hover {
		height:180px;
		margin:-2px 0 0 0;
		-webkit-transition: all 0.2s ease;
		-o-transition: all 0.2s ease;
		transition: all 0.2s ease;
	}
	@media screen and (max-width: 768px) {.swiper-slide{width:100% ! important}}
	</style>    
	
	<!-- 轮播卡片 -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide slide-1"  style="background:#ff5c00 url(./webapp2.0/img/card-bg-01.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国上账期应收账款（万元）</div>
				<div id="incomeTrend" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="incomeTrendRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#8f83ff url(./webapp2.0/img/card-bg-02.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国实际到达连接数（万个）</div>
				<div id="connectNum" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="connectNumRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#31d9a4 url(./webapp2.0/img/card-bg-03.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国出账客户数（个）</div>
				<div id="accountNum" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="accountNumRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#22a8ee url(./webapp2.0/img/card-bg-04.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国商用计费账户数（个）</div>
				<div id="customerNumber" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="customerNumRate"></span>
				</div>
			</div>
		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
	</div> 
	<!-- Swiper JS -->
	   <script>
	    var mySwiper = new Swiper('.swiper-container',{
	    	slidesPerView: 4,
		    spaceBetween: 15,
		    paginationClickable: true,
		    //loop : true,//无限循环
		    autoplay: {
				delay: 3000,
				disableOnInteraction: false,
			},
			pagination: {
			      el: '.swiper-pagination',
			      clickable: true,//卡片下面的定时器
			    },
		    observer:true,//修改swiper自己或子元素时，自动初始化swiper
		    observeParents:true,//修改swiper的父元素时，自动初始化swiper
        });
	</script>    
	
	<!-- 图表卡片 -->
	<div class="card">
		<ul>
			<li class="small-card cockpitHome-one">
				<div class="card-box">
					<p class="card-title">连接激活率</p>	
					<div id="main8" class="card-data" style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
						<span id ="nodata8" style="display:none">连接出账率,无数据</span>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-two">
				<div class="card-box">
					<p class="card-title">连接出账率</p>	
					<div id="main5" class="card-data"  style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>					
					  	<span id ="nodata5" style="display:none">连接出账率,无数据</span>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-three">
				<div class="card-box">
					<p class="card-title">连接活跃率</p>
					<div id="main7" class="card-data"  style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
				  	  	<span id ="nodata7" style="display:none">连接活跃率,无数据</span>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-four">
				<div class="card-box">
					<p class="card-title">各省上账期应收账款（万元）</p>
					<div id="main6" class="card-data" style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
				  	  	<span id ="nodata6" style="display:none">各省上账期应收账款（万元）,无数据</span>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-five">
				<div class="card-box">
					<p class="card-title">全国应收账款趋势（万元）</p>
					<div id="main9" class="card-data" style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					  	<span id ="nodata9" style="display:none">全国应收账款趋势（万元）,无数据</span>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-six">
				<div class="card-box">
					<p class="card-title">南京物联网连接数图</p>	
					<div class="card-data" style="top:80px">
						<iframe src="/iot-operation/piechart/toHomeMap.do"  style="width:100%;height:100%;border:none"></iframe>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-seven">
				<div class="card-box" >
					<p class="card-title">各省已激活及新增激活连接数（万个）</p>	
					<div id="main15" class="card-data">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					  	<span id ="nodata15" style="display:none">各省已激活及新增激活连接数（万个）,无数据</span>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-eight">
				<div class="card-box">
					<p class="card-title">应收（元）</p>	
					<div class="card-data" style="border: 0.0625em solid #334350  ! important;top:80px">
						<table class="table table-bordered" style="margin:0;padding:0;">
							<thead>
							<tr>
								<th>省分</th>
								<th>应收环比</th> 
								<th>应收占比</th>
							</tr>
							</thead>
							<tbody id="customListCompare1">
	
							</tbody>
						</table>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-nine">
				<div class="card-box">
					<p class="card-title">全国激活连接数趋势（万个）</p>	
					<div id="main4" class="card-data">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
						<span id ="nodata4" style="display:none;height:250px">全国激活连接数趋势,无数据</span>
					</div>
				</div>
			</li>
			<li class="small-card cockpitHome-ten">
				<div class="card-box">
					<p class="card-title">激活连接趋势（个）</p>	
					<div class="card-data" style="border: 0.0625em solid #334350  ! important;top:80px">
						<table class="table table-bordered" style="margin:0;padding:0;min-width:450px">
							<thead>
							<tr>
								<th>省分</th>
								<th>环比</th> 
								<th>占比</th>
								<th>本月占比</th> 
								<th>本月新增占比</th>
							</tr>
							</thead>
							<tbody id="customListCompare2">
	
							</tbody>
						</table>
					</div>
				</div>
			</li>
		
		</ul>
	</div>
</div> 
<div class="footer">
	<p>Copyright&nbsp;©&nbsp;1999-2018 ChinaUnicom&nbsp;中国联通&nbsp;版权所有&nbsp;&nbsp;&nbsp;&nbsp;技术支持：中国联通研究院-大数据研究中心</p>
</div> 
</body>
</html>
