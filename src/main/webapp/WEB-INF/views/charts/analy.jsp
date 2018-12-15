<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path1 = request.getContextPath();
String basePath1 = request.getScheme() + "://"
          + request.getServerName() + ":" + request.getServerPort() + path1 + "/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<script type="text/javascript" src="js/china.js"></script>
</head>
<body style="min-height: 900px;">
<script type="text/javascript">
var flag =3;
var displayContent = "${displayContent}";
var displayName = "${displayName}";
var monthDay = "${monthDay}";
var six_data = "${six_data}";
$(document).ready(function() {
	var date= new Date;
	var yearNow=date.getFullYear();
	var params = {};
	//console.log(six_data);
	loadJeDate("monthDay");
	$("#monthDay").val(monthDay);
	param["monthDay"] = monthDay;	
	param["displayContent"] = displayContent;
	$("#number-"+displayContent).css("background-color","#db1316");
	$("#accountNum").html(six_data.split("a")[0]);
	//console.log(six_data.split("a")[0]);
	$("#connectNum").html(six_data.split("a")[1]);
	$("#activityTrend").html(six_data.split("a")[2]+"%");
	$("#orderTrend").html(six_data.split("a")[3]);
	$("#incomeTrend").html(six_data.split("a")[4]);
	$("#customerNum").html(six_data.split("a")[5]);
	//getHomePgFourChart();
	getAreaTop();
	getIndustryTop();
	getYearOnYear();
	getMonthOnMonth();
	getChinaMap();
}); 
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
<input type="hidden" id="roleId" />
<!-- 获取列表 -->
<script type="text/javascript">
	var totalPage;
	var totalRecords;
	var page = 1;
	var param = {};
	function setDisplayContent(type){
		
		displayContent = type;
		if(type==1){
			displayName = "账户数";
			$("#number-1").css("background-color","#999");//#4682B4  #db1316
			$("#number-2").css("background-color","#4682B4");
			$("#number-3").css("background-color","#4682B4");
			$("#number-4").css("background-color","#4682B4");
			$("#number-5").css("background-color","#4682B4");
			$("#number-6").css("background-color","#4682B4");
			
		}else if(type==2){
			displayName = "连接数";
			$("#number-2").css("background-color","#999");
			$("#number-1").css("background-color","#4682B4");
			$("#number-3").css("background-color","#4682B4");
			$("#number-4").css("background-color","#4682B4");
			$("#number-5").css("background-color","#4682B4");
			$("#number-6").css("background-color","#4682B4");
		}else if(type==3){
			displayName = "激活率";
			$("#number-3").css("background-color","#999");
			$("#number-2").css("background-color","#4682B4");
			$("#number-1").css("background-color","#4682B4");
			$("#number-4").css("background-color","#4682B4");
			$("#number-5").css("background-color","#4682B4");
			$("#number-6").css("background-color","#4682B4");
		}else if(type==4){
			displayName = "订购数";
			$("#number-4").css("background-color","#999");
			$("#number-2").css("background-color","#4682B4");
			$("#number-3").css("background-color","#4682B4");
			$("#number-1").css("background-color","#4682B4");
			$("#number-5").css("background-color","#4682B4");
			$("#number-6").css("background-color","#4682B4");
		}else if(type==5){
			displayName = "平台应收";
			$("#number-5").css("background-color","#999");
			$("#number-2").css("background-color","#4682B4");
			$("#number-3").css("background-color","#4682B4");
			$("#number-4").css("background-color","#4682B4");
			$("#number-1").css("background-color","#4682B4");
			$("#number-6").css("background-color","#4682B4");
		}else{
			displayName = "客户数";
			$("#number-6").css("background-color","#999");
			$("#number-2").css("background-color","#4682B4");
			$("#number-3").css("background-color","#4682B4");
			$("#number-4").css("background-color","#4682B4");
			$("#number-5").css("background-color","#4682B4");
			$("#number-1").css("background-color","#4682B4");
		}
		searchList();
	}
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
		var date=new Date;
		var yearNow=date.getFullYear();
		page = 1; 
  		var monthDay = $("#monthDay").val();
  		param["monthDay"] = monthDay.trim();
  		
  		param["displayContent"]=displayContent;
  		getHomePgFourChart();
  		getAreaTop();
		getIndustryTop();
		getYearOnYear();
		getMonthOnMonth();
		getChinaMap();
	}
	function getHomePgFourChart() {
		$.ajax({
  			type: "POST",
  			url: "piechart/getHomePgFourTb.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				var incomeTrendValue=(Number(data.datas[0].incomeTrendRate)).toFixed(2);
  				var incomeTrendImgUrl=incomeTrendValue>0?"img/arr-up.png":"img/arr-down.png";
  				var connectNumValue=(Number(data.datas[0].connectNumRate)).toFixed(2);
  				var connectNumImgUrl=connectNumValue>0?"img/arr-up.png":"img/arr-down.png"; 
  				var accountNumValue=(Number(data.datas[0].accountNumRate)).toFixed(2);//add in 2018-9-26
  				var accountNumImgUrl=accountNumValue>0?"img/arr-up.png":"img/arr-down.png";
  				var customerNumValue=(Number(data.datas[0].customerNumRate)).toFixed(2);
  				var customerNumImgUrl=customerNumValue>0?"img/arr-up.png":"img/arr-down.png";
  				var myChart7 = echarts.init(document.getElementById('main8'));
  				
  				
  				$("#accountNum").html((data.datas[0].accountNum)+ "  环比：" + Number(data.datas[0].accountNumRate).toFixed(2)+"%");
  				$("#connectNum").html(Number(Number(data.datas[0].connectNum)/10000).toFixed(2) + "  环比：" + (Number(data.datas[0].connectNumRate)).toFixed(2)+"%");
  				$("#activityTrend").html(Number(data.datas[0].activityTrend).toFixed(2)+"%");
  				$("#orderTrend").html(data.datas[0].orderTrend);
  				$("#incomeTrend").html(Number(Number(data.datas[0].incomeTrend)/10000).toFixed(2) + "  环比：" + (Number(data.datas[0].incomeTrendRate)).toFixed(2)+"%");
  				$("#customerNum").html((data.datas[0].customerNumber)+ "  环比：" + Number(data.datas[0].customerNumRate).toFixed(2)+"%");
  				
  				$("#incomeTrendImg").attr("src",incomeTrendImgUrl);
  				$("#connectNumImg").attr("src",connectNumImgUrl);
  				$("#connectNumImg").css("display","inline-block");
  				$("#incomeTrendImg").css("display","inline-block");
  				$("#accountNumImg").attr("src",accountNumImgUrl);
  				$("#accountNumImg").css("display","inline-block");
  				$("#customerNumImg").attr("src",customerNumImgUrl);
  				$("#customerNumImg").css("display","inline-block");
  				
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
	function getAreaTop(){
		var yName=[];
		var xValue=[];
  		$.ajax({
  			type: "POST",
  			url: "piechart/getAreaTop.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (null!=data.datas&&data.datas.length>0) {
  					if(data.code==200){  
  						datas = data.datas; 
  	  					for(var d in datas){
  	  						if(datas[d]!=null){
	  	  						if(displayName == "激活率"){
	  	  							var fvalue = Number(datas[d].value).toFixed(2);
	  	  							float1 = fvalue;
		  						}else{
		  							float1 = datas[d].value;
		  						}
		  						if(displayName == "平台应收"){
	  	  							var fvalue = Number(Number(datas[d].value)/10000).toFixed(2); 
	  	  							float1 = fvalue;
		  						}else{
		  							float1 = datas[d].value;
		  						}
		  						
		  						yName.push(datas[d].name);
		  						xValue.push(float1);
  	  						}
  	  						  	  												
  	  					} 
	  	  		        // 指定图表的配置项和数据
	  	  		        var option2 = {
  				            		    title: {
  				            		        text: 'TOP10省分',
  				            		        	x:'center',
  					  					        y:'top'
  				            		    },
  				            		    tooltip: {
  				            		        trigger: 'axis',
  				            		        axisPointer: {
  				            		            type: 'shadow'
  				            		        }
  				            		    },
  				            		    legend: {
  				            		        data: ['数额']
  				            		    },
  				            		    grid: {
  				            		        left: '10',
  				            		        right: '10',
  				            		        bottom: '0',
  				            		        containLabel: true
  				            		    },
  				            		    xAxis: {
  				            		        type: 'value',
  				            		        boundaryGap: [0, 0.01]
  				            		    },
  				            		    yAxis: {
  				            		        type: 'category',
  				            		        data: yName
  				            		    },
  				            		    series: [
  				            		        {
  				            		            name: displayName,
  				            		            type: 'bar',
  				            		            data: xValue
  				            		        }
  				            		    ]
  				            		};
  	  					echarts.dispose(document.getElementById("main2"));
  	  					var myChart2 = echarts.init(document.getElementById('main2'));
  	  			        myChart2.setOption(option2);   
  	  			    	$("#nodata2").css("display","none"); 
  						$("#main2").css("display","block");
  					}else{  
  						$("#main2").html("<br/><br/><img src=\"img/codeerror.gif\" />");  						
  					}
  					
  				}else{
  					$("#nodata2").css("display","block");
  					$("#main2").css("display","none");
  				}
  			},
			error : function () {
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
			}
  		});
	}
	function getIndustryTop(){
		var pieDate =[]; 
		var xName=[];
  		$.ajax({
  			type: "POST",
  			url: "piechart/getIndustryTop.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (null!=data&&data.datas.length>0) {
  					if(data.code==200){
  						var valueElse = 0;
  						datas = data.datas; 
  						console.log(data);
  						var countElse =0;
  						var nullCount=0;
  	  					for(var d in datas){
  	  						if(datas[d]!=null){
	  	  						if(displayName == "激活率"){
	  	  							var fvalue = Number(datas[d].value).toFixed(2);
	  	  							float1 = fvalue;
		  						}else{
		  							float1 = datas[d].value;
		  						}
		  						if(displayName == "平台应收"){
	  	  							var fvalue = Number(Number(datas[d].value)/10000).toFixed(2); 
	  	  							float1 = fvalue;
		  						}else{
		  							float1 = datas[d].value;
		  						}
	  	  						countElse++;
	  	  						if(d<10){
		  	  						pieDate.push({
		  	  				            name: datas[d].name,
		  	  				            value: float1
		  	  				        }); 
		  	  						xName.push(datas[d].name);
	  	  						}else{
	  	  							valueElse += parseFloat(float1);
	  	  						}
  	  						}else{
  	    						nullCount++;
  	  						}
  	  						  	  												
  	  					} 
  	  					if(nullCount==datas.length){
	  	  					$("#nodata3").css("display","block");
	  						$("#main3").css("display","none");
	  						return;
  	  					}
  	  					if(countElse>=10){
  	  	  					pieDate.push({
  					            name: '其他',
  					            value: valueElse
  					        });
  	  	  					xName.push('其他');
  	  					}
  	  				option3 = {
	  	  				    title : {
	  	  				        text: 'TOP10行业',
	  	  				        x:'center',
		  					    y:'top'
	  	  				    },
	  	  				grid: {
            		        left: '60',
            		        right: '60',
            		        bottom: '0',
            		        containLabel: true
            		    },
	  	  				    tooltip : {
	  	  				        trigger: 'item',
	  	  				        formatter: "{a} <br/>{b} : {c} ({d}%)"
	  	  				    },  
	  	  				    series : [
	  	  				        {
	  	  				            name: displayName,
	  	  				            type: 'pie',
	  	  				            //radius : ['45%', '60%'], 
	  	  				            radius : '60%', 
	  	  				            center: ['50%', '60%'], 
	  	  				            data: pieDate,
	  	  				            itemStyle: {
	  	  				            	emphasis: {
	  	  				                    shadowBlur: 10,
	  	  				                    shadowOffsetX: 0,
	  	  				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	  	  				                }
	  	  				            }
	  	  				        }
	  	  				    ], 
	  	  				    color: ['rgb(239,75,75)','rgb(55,109,204)','rgb(243,160,120)','rgb(239,193,172)','rgb(43,50,127)','rgb(94,70,116)','rgb(153,135,158)']
	  	  				}; 
	  	  				/* option3 = {
	  	  					title: {
		            		        text: '行业TOP'
		            		    },
	  	  				    tooltip: {
	  	  				        trigger: 'item',
	  	  				        formatter: "{a} <br/>{b}: {c} ({d}%)"
	  	  				    },
	  	  				    legend: {
	  	  				        orient: 'vertical',
	  	  				        x: 'left',
	  	  				        data:xName
	  	  				    },
	  	  				    series: [
	  	  				        {
	  	  				            name:displayName,
	  	  				            type:'pie',
	  	  				            radius: ['50%', '70%'],
	  	  				            avoidLabelOverlap: false,
	  	  				            label: {
	  	  				                normal: {
	  	  				                    show: false,
	  	  				                    position: 'center'
	  	  				                },
	  	  				                // emphasis: {
	  	  				                //    show: true,
	  	  				                //    textStyle: {
	  	  				                 //       fontSize: '30',
	  	  				                 //       fontWeight: 'bold'
	  	  				                 //   }
	  	  				              //  }
	  	  				            },
	  	  				            labelLine: {
	  	  				                normal: {
	  	  				                    show: false
	  	  				                }
	  	  				            },
	  	  				            data:pieDate
	  	  				        }
	  	  				    ]
	  	  				}; */
 				      	echarts.dispose(document.getElementById("main3"));
 			  	  	    var myChart3 = echarts.init(document.getElementById('main3')); 
 	  			        myChart3.setOption(option3);  
 	    	  			$("#nodata3").css("display","none"); 
 	    				$("#main3").css("display","block"); 
  					}else{ 
  						$("#main3").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
  					}
  					
  				}else{
  					$("#nodata3").css("display","block");
  					$("#main3").css("display","none");
  				}
  			},
			error : function () {
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
			}
  		});
	}
	
	function getYearOnYear(){
		var xName=[];
		var customerNum=[];//客户数 value
  		$.ajax({
  			type: "POST",
  			url: "piechart/getYearOnYear.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (null!=data&&data.datas.length>0) {
  					if(data.code==200){
  						datas = data.datas; 
  	  					var float1 = 0;
  	  					var forecast = 0;
  	  					var allcount = 0;
  	  					for(var d in datas){
  	  						allcount= allcount+1;
  	  						var value;
							var name;
							if(datas[d]==null){
								value=0;
								name="";
							}else if(datas[d].value==null){
								value=0;
								name=datas[d].name;
							}else{
								value=datas[d].value;
								name=datas[d].name;
							}
  	  						if(displayName == "激活率"){
  	  							var fvalue = Number(value).toFixed(2);
  	  							float1 = fvalue;
	  						}else{
	  							float1 = value;
	  						}
	  	  					if(displayName == "平台应收"){
		  							var fvalue = Number(Number(value)/10000).toFixed(2); 
		  							float1 = fvalue;
	  						}else{
	  							float1 = value;
	  						}
	  	  					xName.push(name);
	  	  					customerNum.push(float1);
  	  					}
  	  				option4 = {
	  						 title : {
	  					        text: '各省同比增幅',
	  					        x:'center',
	  					        y:'top'
	  					    },
	  					    tooltip : {
	  					        trigger: 'axis'
	  					    },
	  					  grid: {
	            		        left: '10',
	            		        right: '30',
	            		        bottom: '0',
	            		        containLabel: true
	            		    },
	  					    
	  					    toolbox: {
	  					        /* show : true,
	  					        feature : {
	  					            dataView : {show: true, readOnly: false},
	  					            magicType : {show: true, type: ['line', 'bar']},
	  					            restore : {show: true},
	  					            saveAsImage : {show: true}
	  					        } */
	  					    },
	  					    calculable : true,
	  					    xAxis : [
	  					        {
	  					            type : 'category',
	  					            data : xName
	  					        }
	  					    ],
	  					    yAxis : [
	  					        {
	  					            type : 'value'
	  					        }
	  					    ],
	  					    series : [
	  					        {
	  					            name:displayName+"同比",
	  					            type:'bar',
	  					            data:customerNum,
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
	  					        }
	  					    ]
			            };
  				      	echarts.dispose(document.getElementById("main4"));
  			  	  	    var myChart4 = echarts.init(document.getElementById('main4'));
  	  			        myChart4.setOption(option4);   
  	  	  			    $("#nodata4").css("display","none"); 
  	  					$("#main4").css("display","block"); 
  					}else{ 
  						$("#main4").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
  					}
  					
  				}else{
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
	//环比
	function getMonthOnMonth(){
		var xName=[];
		var customerNum=[];//客户数 value
		
  		$.ajax({
  			type: "POST",
  			url: "piechart/getMonthOnMonth.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (null!=data.datas&&data.datas.length>0) {
  					if(data.code==200){
  	  					var startMonth;
  	  					var forecastMonth1;
  	  					var forecastMonth2; 
  	  					var forecast = 0;
  	  					var allcount = 0;
  	  					var forecastMark=0;
  	  					datas = data.datas; 
  	  					startMonth = datas[0].name;
  	  					for(var d in datas){
  	  						allcount= allcount+1;
  	  						//if (datas[d].isForecastFlag==1) forecast=forecast+1;//isForecastFlag去掉
  	  						var value;
							var name;
							if(datas[d]==null){
								value=0;
								name="";
							}else if(datas[d].value==null){
								value=0;
								name=datas[d].name;
							}else{
								value=datas[d].value;
								name=datas[d].name;
							}
	  	  					if(displayName == "激活率"){
		  						var fvalue = Number(value).toFixed(2);
		  						float1 = fvalue;
	  						}else{
	  							float1 = value;
	  						}
		  	  				if(displayName == "平台应收"){
		  							var fvalue = Number(Number(value)/10000).toFixed(2); 
		  							float1 = fvalue;
	  						}else{
	  							float1 = value;
	  						}
  	  					xName.push(name);
  	  					customerNum.push(float1);
 
  	  					}     	  					
  	  				option5 = {
	  						 title : {
	  					        text: '各省环比增幅',
	  					        x:'center',
	  					        y:'top'
	  					    },
	  					    tooltip : {
	  					        trigger: 'axis'
	  					    },
	  					  grid: {
	            		        left: '10',
	            		        right: '30',
	            		        bottom: '0',
	            		        containLabel: true
	            		    },
	  					    toolbox: {
	  					        /* show : true,
	  					        feature : {
	  					            dataView : {show: true, readOnly: false},
	  					            magicType : {show: true, type: ['line', 'bar']},
	  					            restore : {show: true},
	  					            saveAsImage : {show: true}
	  					        } */
	  					    },
	  					    calculable : true,
	  					    xAxis : [
	  					        {
	  					            type : 'category',
	  					            data : xName
	  					        }
	  					    ],
	  					    yAxis : [
	  					        {
	  					            type : 'value'
	  					        }
	  					    ],
	  					    series : [
	  					        {
	  					            name:displayName+"环比",
	  					            type:'bar',
	  					            data:customerNum,
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
	  					        }
	  					    ]
			            };
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
	function getChinaMap(){
		var mapData =[]; 
  		$.ajax({
  			type: "POST",
  			url: "piechart/getMapData.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (null!=data&&data.datas.length>0) {
  					if(data.code==200){
  						datas = data.datas; 
  	  					for(var d in datas){
  	  						mapData.push({
		  				            name: datas[d].name,
		  				            value: datas[d].value,
		  				            code:datas[d].code
		  				        }); 												
  	  					} 
		  	  			// 指定图表的配置项和数据
		  	  		    var option6 = {
		  	  		    	backgroundColor: '#002B2D',
		  	  					tooltip : {//提示框组件。
		  	  		            trigger: 'item'//数据项图形触发，主要在散点图，饼图等无类目轴的图表中使用。
		  	  		        },
		  	  		        legend: {
		  	  		            orient: 'horizontal',//图例的排列方向
		  	  		            x:'left',//图例的位置
		  	  		            data:[mapData]
		  	  		        },
		
		  	  		        visualMap: {//颜色的设置  dataRange
		  	  		            x: 'left',
		  	  		            y: 'center',
		  	  		            show:false,//不显示左下角标题组件
		  	  		            splitList: [
		  	  		                {start: 1500},
		  	  		                {start: 900, end: 1500},
		  	  		                {start: 310, end: 1000},
		  	  		                {start: 200, end: 300},
		  	  		                {start: 10, end: 200, label: '10 到 200（自定义label）'},
		  	  		                {start: 5, end: 5, label: '5（自定义特殊颜色）', color: 'black'},
		  	  		                {end: 10}
		  	  		            ],
								//min: 0,
								//max: 2500,
								//calculable : true,//颜色呈条状
		  	  		            text:['高','低'],// 文本，默认为数值文本
		  	  		            color: ['#E0022B', '#E09107', '#A3E00B']
		  	  		        },
		  	  		        toolbox: {//工具栏
		  	  		            //show: true,
		  	  		            //orient : 'vertical',//工具栏 icon 的布局朝向
		  	  		            //x: 'right',
		  	  		            //y: 'center',
		  	  		            //feature : {//各工具配置项。
		  	  		               // mark : {show: true},
		  	  		               // dataView : {show: true, readOnly: false},//数据视图工具，可以展现当前图表所用的数据，编辑后可以动态更新。
		  	  		                //restore : {show: true},//配置项还原。
		  	  		                //saveAsImage : {show: true}//保存为图片。
		  	  		            //}
		  	  		        },
		  	  		        roamController: {//控制地图的上下左右放大缩小 图上没有显示
		  	  		            show: true,
		  	  		            x: 'right',
		  	  		            mapTypeControl: {
		  	  		                'china': true
		  	  		            }
		  	  		        },
		  	  		        series : [
		  	  		            {
		  	  		                name: displayName,
		  	  		                type: 'map',
		  	  		                showLegendSymbol: false,
		  	  		                mapType: 'china',
		  	  		                roam: false,//是否开启鼠标缩放和平移漫游
		  	  		                itemStyle:{//地图区域的多边形 图形样式
		  	  		                    normal:{//是图形在默认状态下的样式
		  	  		                        label:{
		  	  		                            show:false,//是否显示标签
		  	  		                            textStyle: {
		  	  		                                color: "rgb(249, 249, 249)"
		  	  		                            }
		  	  		                        }
		  	  		                    },
		  	  		                    emphasis:{//是图形在高亮状态下的样式,比如在鼠标悬浮或者图例联动高亮时
		  	  		                        label:{show:true}
		  	  		                    }
		  	  		                },
		  	  		                top:"3%",//组件距离容器的距离
		  	  		                data:mapData
		  	  		            }
		  	  		        ]
		  	  		    }; 
		  	  		
		  	  		    echarts.dispose(document.getElementById("main6"));
		  	  	  	    var myChart6 = echarts.init(document.getElementById('main6'));
		  		        myChart6.setOption(option6);  
		  				$("#nodata6").css("display","none"); 
		  				$("#main6").css("display","block");
		  				myChart6.on('click', function (params) {
		  			      	showMapDataInfo(params.data.code);
		  			    });
	  		       
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
	
	function showMapDataInfo(zoneLocal){
		var monthDay = $("#monthDay").val();
		//省份传值
		window.location.href= "piechart/toPage.do?displayContent="+displayContent+"&type=2&monthDay="+monthDay+"&pro="+zoneLocal; 
	}
</script> 
 
<!-------------------------CONT---------------------------->  
<div class="List-cont box-cont">
	<div class="panel panel-default">
	    <div class="panel-header">
	      <h4>趋势图分析</h4>
	    </div>
		<div id="panel-body" class="panel-body">
        	<!--搜索模块-->
        	<div class="col-sm-13" id="pro2C" style="display:none;margin-top:10px;">
                       <label class="form-label" for="">省份：</label><div class="formControls">
                           <select class="input-text" name="province" id="province">
                               <option value="1">请选择</option>  
                           </select>
                       </div>
                     </div>
                 <div class="col-sm-1 text-r" style="display:none;margin-top:10px;">
                    <a onClick="searchList();" class="btn btn-primary ">查询</a>  
                 </div><br/><br/>
            <div class="search-form">
            	<form id="searchForm">
                 <div class="row cl clclclcl">
                     <!-- <div class="form-group cl" style="width:10%;margin-top:-10px;">
						<label class="fl">日期：</label>
				        <input type="text" class="input-text" id="monthDay" name="monthDay" placeholder="yyyy-mm-dd" readonly style="margin-top:-25px;margin-left:60px;">
					</div> -->
					<ul style="margin-top:-40px;">
						 <li class="before" onclick="setBeforeDay();">
							 <a><img src="img/before.svg" alt="before"></a>
					     </li>
						 <li class="time" >
							 <input type="text" class="input-text time-box" id="monthDay" name="monthDay" placeholder="yyyy-mm-dd" readonly >
				         </li>
						 <li class="next" onclick="setNextDay();">
							 <a><img src="img/next.svg" alt="next"></a>
				         </li>
					 </ul>
                    
                 </div>
                </form> 
              </div>
                 <div id="main8" style="width: 450px;height:300px;"></div><!-- add in 2018-10-22 -->
           <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
           <div class="row cl">
           
					<div class="col-sm-12 col-box">
						<div class="number-box number-1" id = "number-5" onclick="setDisplayContent(5);"style="position:relative;">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-05.svg">
				            </div>
				            <div class="right">
								<span class="name">全国上账期应收账款（万元）</span>
							  <p id="incomeTrend" class="number">loading</p>
							  <img id="incomeTrendImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none;"> 
				            </div>
				        </div>
				        <div class="number-box number-2" id = "number-2" onclick="setDisplayContent(2);"style="position:relative;">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-02.svg">
				            </div>
				            <div class="right">
							  <span class="name">全国发卡连接数（万个）</span>
							  <p id="connectNum" class="number">loading</p>
							  <img id="connectNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none;">
							</div> 
				        </div>
				        <div class="number-box number-3" id = "number-3" onclick="setDisplayContent(3);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-03.svg">
				            </div>
				            <div class="right">
							  <span class="name">全国连接数激活率（%）</span>
							  <p id="activityTrend" class="number">loading</p>
				            </div>
				        </div>
						<div class="number-box number-4" id = "number-1" onclick="setDisplayContent(1);"style="position:relative;">
				            <div class="ico">
				              <img src="img/number-ico/number-ico-01.svg">
				            </div>
				            <div class="right">
							  <span class="name">全国总账户数（个）</span>
							  <p id="accountNum" class="number">loading</p>
							  <img id="accountNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none">
				            </div>
				        </div>						
						<div class="number-box number-5" id = "number-6" onclick="setDisplayContent(6);"style="position:relative;">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-06.svg">
				            </div>
				            <div class="right">
				              <span class="name">全国商用客户数（个）</span>
							  <p id="customerNum" class="number">loading</p>
							  <img id="customerNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none">  
							</div> 
				        </div>
				        <div class="number-box number-6" id = "number-4" onclick="setDisplayContent(4);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-04.svg">
				            </div>
				            <div class="right">
								<span class="name">全国本账期累计发货订单数（个）</span>
							  <p id="orderTrend" class="number">loading</p>
				            </div>
				        </div>
   				        
				        
 					</div>
 					
				  </div>
			<div class="col-sm-12 col-box-3"> 
				 <ul>
				      <li class="lt-top"><div class="data-box">
							<span id ="nodata2" style="display:none">TOP10省分,无数据</span>
					  		<div id="main2" class="data"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  </li>
				      <li class="rt-top"><div class="data-box">
							<span id ="nodata3" style="display:none">TOP10行业,无数据</span>	
				  	  		<div id="main3" class="data"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  </li>
				      <li class="cr"><div class="data-box">
							<span id ="nodata6" style="display:none">地图,无数据</span>
					  		<div id="main6" class="data"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  </li>
					  <li class="lt-bottom"><div class="data-box">
							<div id="main4" class="data"><br/><br/><img src="img/codeerror.gif" /></div></div>
						  	<span id ="nodata4" style="display:none;">各省同比增幅,无数据</span>
					  </li>
					  <li class="rt-bottom"><div class="data-box">
					  		<span id ="nodata5" style="display:none;">各省环比增幅,无数据</span>
							<div id="main5" class="data"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  </li>
			      </ul>
			</div>
	       </div> 
	  	 </div>                                      
        </div>       
</body>
</html>
