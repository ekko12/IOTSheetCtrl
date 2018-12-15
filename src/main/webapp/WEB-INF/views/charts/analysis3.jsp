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
<%--<script src="/js/hplus/plugins/echarts/echarts-all.js"  th:src="@{/js/hplus/plugins/echarts/echarts-all.js}"></script>--%>
<script type="text/javascript" src="js/echarts-worldCloud.js"></script>
</head>
<body style="min-height: 1200px;">
<script type="text/javascript">
var flag =3;
var pieDate =[]; 
var proCode = 0;
var cityCode = 0;
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
        		//searchList();
        		pieDate.splice(0,pieDate.length);//清空数组 
        		page = 1; 
          		param["monthDay"] = data.date;
          		$("#monthDay").val(data.date);
          		getHomePgFourChart();                                            
          		//getConNumActivityTrend();//连接数-激活率-活跃率 getPieChart();
          		getPlatformBusiness();//平台商机和客户情况 getLineChartByConnHisTrend();
          		getPlatformIncome();//平台收入分省情况 getActiveRateByTrend();
          		//getConNum();//全国连接数趋势 getTotalChargeRend();
          		//getCustomerNum();//全国客户数趋势 getOrderTrend();
          		//getIncome();//全国收入趋势
          		getIncomeByDetailIndustry();
          		getHomeRate();
        	}
             
        }  
	});    

	
}); 
function setDisplayContent(type){
	
	displayContent = type;
	if(type==1){
		displayName = "账户数";
	}else if(type==2){
		displayName = "连接数";
	}else if(type==3){
		displayName = "激活率";
	}else if(type==4){
		displayName = "订购数";
	}else if(type==5){
		displayName = "平台应收";
	}else{
		displayName = "客户数";
	}
	var monthDay = $("#monthDay").val();
	var accountNum = $("#accountNum").html().trim();
	var accountNumRate =$("#accountNumRate").html()==undefined?"":$("#accountNumRate").html().trim();// add 20180929
	var connectNum = $("#connectNum").html().trim();
	var activityTrend = $("#activityTrend").html().trim();
	var orderTrend = $("#orderTrend").html().trim();
	var incomeTrend = $("#incomeTrend").html().trim();                 
	var incomeTrendRate = $("#incomeTrendRate").html()==undefined?"":$("#incomeTrendRate").html().trim();    //add 20180921
	var customerNum = $("#customerNum").html().trim();
	var customerNumRate =$("#customerNumRate").html()==undefined?"":$("#customerNumRate").html().trim();// add 20180929
	
	var connectNumRate = $("#connectNumRate").html()==undefined?"":$("#connectNumRate").html().trim();        //add 20180921
	//var six_data =accountNum+"a"+connectNum+"a"+activityTrend.substr(0,activityTrend.length-1)+"a"+orderTrend+"a"+incomeTrend+"a"+customerNum;
	var six_data =accountNum+"a"+connectNum+"a"+activityTrend.substr(0,activityTrend.length-1)+"a"+orderTrend+"a"+incomeTrend+"a"+customerNum +"a"+incomeTrendRate+"a"+connectNumRate+"a"+accountNumRate+"a"+customerNumRate;
	//$("#number-"+displayContent).css("background-color","#db1316");
	window.location.href= "piechart/toPage.do?displayContent="+type+"&type=1&monthDay="+monthDay+"&six_data="+six_data; 
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
  		getPlatformBusiness();//平台商机和客户情况 getLineChartByConnHisTrend();
  		getPlatformIncome();//平台收入分省情况 getActiveRateByTrend();
  		//getConNum();//全国连接数趋势 getTotalChargeRend();
  		//getCustomerNum();//全国客户数趋势 getOrderTrend();
  		//getIncome();//全国收入趋势
  		getIncomeByDetailIndustry();
  		getHomeRate();
	}
	
	function getIncomeByDetailIndustry(){//连接数-激活率-活跃率
		var industryName=[];
		var industryValue=[];
		
		$.ajax({
  			type: "POST",
  			url: "piechart/getIncomeByDetailIndustry.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  	  				console.log(data);
  	  				var echartData=new Array();
  	  			if (data.datas.length>0) {	
  	  			   if(data.code==200){  
					datas = data.datas;
   	  			for(var d in datas){
	  			    	industryName.push(datas[d].name);
	  			        industryValue.push(datas[d].value);	}
  	  			for(var i=0;i<industryName.length;i++){
	  					var obj=new Object();
	  					obj.value=industryValue[i];
	  					obj.name=industryName[i];
	  					//obj.label=content[i].labelCode;
	  					//obj.itemStyle=wordCloudColor();
	  					echartData[i]=obj;
	  				}
  				showWordCloud(echartData);
  	  				
  	  		/*	option = {
  	  	  				  title: {
  	  	  			        text: "词云图",
  	  	  			       // link: 'https://github.com/ecomfe/echarts-wordcloud',
  	  	  			       // subtext: 'data-visual.cn',
  	  	  			       // sublink: 'http://data-visual.cn',
  	  	  			      },
  	  	  			    tooltip: {},
  	  	  			series: [{
  	  	  	        type: 'wordCloud',
  	  	  	        gridSize: 20,
  	  	  	        sizeRange: [12, 50],
  	  	  	        rotationRange: [0, 0],
  	  	  	        shape: 'circle',
  	  	  	        textStyle: {
  	  	  	            normal: {
  	  	  	                color: function() {
  	  	  	                    return 'rgb(' + [
  	  	  	                        Math.round(Math.random() * 160),
  	  	  	                        Math.round(Math.random() * 160),
  	  	  	                        Math.round(Math.random() * 160)
  	  	  	                    ].join(',') + ')';
  	  	  	                }
  	  	  	            },
  	  	  	            emphasis: {
  	  	  	                shadowBlur: 10,
  	  	  	                shadowColor: '#333'
  	  	  	            }
  	  	  	        },
  	  	  	      data:echartData
  	  	  	       }]
  	  				}
  	  		    debugger;
  	  			alert(data);
  				echarts.dispose(document.getElementById("main8"));
					var myChart8 = echarts.init(document.getElementById('main8'));
			        myChart8.setOption(option);   
			    	$("#nodata8").css("display","none"); 
					$("#main8").css("display","block");	*/
					
  	  		  }else{ 
					$("#main8").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
				}
				
			}else{
				//$("#nodata8").css("display","block");
				//$("#main8").css("display","none");
				showFixWordCloud();
			}		
  	  			
  	 
			},	
					
  			error : function () {
  					$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
  					return false;
  				}
		});
	}

  			function showWordCloud(echartData){
  				//var myChart=echarts.init(document.getElementById("wordCloud"));	
  		
	  	  			option = {
	  	  				  title: {
	  	  			        text: "词云图",
	  	  			       // link: 'https://github.com/ecomfe/echarts-wordcloud',
	  	  			       // subtext: 'data-visual.cn',
	  	  			       // sublink: 'http://data-visual.cn',
	  	  			      },
	  	  			    tooltip: {},
	  	  			series: [{
	  	  	        type: 'wordCloud',
	  	  	        gridSize: 20,
	  	  	        sizeRange: [12, 50],
	  	  	        rotationRange: [0, 0],
	  	  	        shape: 'circle',
	  	  	        textStyle: {
	  	  	            normal: {
	  	  	                color: function() {
	  	  	                    return 'rgb(' + [
	  	  	                        Math.round(Math.random() * 160),
	  	  	                        Math.round(Math.random() * 160),
	  	  	                        Math.round(Math.random() * 160)
	  	  	                    ].join(',') + ')';
	  	  	                }
	  	  	            },
	  	  	            emphasis: {
	  	  	                shadowBlur: 10,
	  	  	                shadowColor: '#333'
	  	  	            }
	  	  	        },
	  	  	        data:echartData
	  	  	  
	  	  	    }]	};
	  	  			echarts.dispose(document.getElementById("main8"));
  	  					var myChart8 = echarts.init(document.getElementById('main8'));
  	  			        myChart8.setOption(option);   
  	  			    	$("#nodata8").css("display","none"); 
  						$("#main8").css("display","block");
  			}
  			
  

  			function showFixWordCloud(){
	  	  			option = {
	  	  				  title: {
	  	  			        //text: "词云图",

	  	  			      },
	  	  			    tooltip: {},
	  	  			series: [{
	  	  	        type: 'wordCloud',
	  	  	        gridSize: 20,
	  	  	        sizeRange: [12, 50],
	  	  	        rotationRange: [0, 0],
	  	  	        shape: 'circle',
	  	  	        textStyle: {
	  	  	            normal: {
	  	  	                color: function() {
	  	  	                    return 'rgb(' + [
	  	  	                        Math.round(Math.random() * 160),
	  	  	                        Math.round(Math.random() * 160),
	  	  	                        Math.round(Math.random() * 160)
	  	  	                    ].join(',') + ')';
	  	  	                }
	  	  	            },
	  	  	            emphasis: {
	  	  	                shadowBlur: 10,
	  	  	                shadowColor: '#333'
	  	  	            }
	  	  	        },
	  	  	    data: [
	  	            {
	  	                name: '后装-汽车车载电子设备',
	  	                value: 34212328
	  	            }, {
	  	                name: '车厂及车厂推动的后装产品',
	  	                value: 20754416
	  	            }, {
	  	                name: '自动售货机、自动售票机等',
	  	                value: 11386012
	  	            }, {
	  	                name: '智能热表',
	  	                value: 9270083
	  	            }, {
	  	                name: 'PAD类',
	  	                value: 7941959
	  	            }, {
	  	                name: '视频监控',
	  	                value: 6603574
	  	            }, {
	  	                name: '各类传感器',
	  	                value: 3762761
	  	            }, {
	  	                name: '手环、项圈等',
	  	                value: 3505946
	  	            }, {
	  	                name: '智能电梯',
	  	                value: 1453679
	  	            }, {
	  	                name: '家电类',
	  	                value: 1389293
	  	            }, {
	  	                name: '电动自行车',
	  	                value: 1123774
	  	            }, {
	  	                name: '其他',
	  	                value: 778180
	  	            }, {
	  	                name: '医疗类设备',
	  	                value: 681778
	  	            }, {
	  	                name: '数字对讲机',
	  	                value: 637845
	  	            }, {
	  	                name: '物流巴枪',
	  	                value: 316826.9549
	  	            }, {
	  	                name: '智慧环保',
	  	                value: 100021.9029
	  	            }, {
	  	                name: '农机监控',
	  	                value: 81308.64379999999
	  	            }, {
	  	                name: '消防单兵',
	  	                value: 23475.7285
	  	            }]
	
	  	  	    }]	};
	  	  			echarts.dispose(document.getElementById("main8"));
  	  					var myChart8 = echarts.init(document.getElementById('main8'));
  	  			        myChart8.setOption(option);   
  	  			    	$("#nodata8").css("display","none"); 
  						$("#main8").css("display","block");
  			}
  			
	
	
	
	function getHomePgFourChart() {                           		
		$.ajax({
  			type: "POST",
  			url: "piechart/getHomePgFourTb.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				console.log(data);
  				var accountNumValue=(Number(data.datas[0].accountNumRate)).toFixed(2);//add in 2018-09-26
  				var accountNumImgUrl=accountNumValue>0?"img/arr-up.png":"img/arr-down.png";
  				var incomeTrendValue=(Number(data.datas[0].incomeTrendRate)).toFixed(2);
  				var incomeTrendImgUrl=incomeTrendValue>0?"img/arr-up.png":"img/arr-down.png";  	
  				var connectNumValue=(Number(data.datas[0].connectNumRate)).toFixed(2);
  				var connectNumImgUrl=connectNumValue>0?"img/arr-up.png":"img/arr-down.png"; 
  				var customerNumValue=(Number(data.datas[0].customerNumRate)).toFixed(2);//add in 2018-09-26
  				var customerNumImgUrl=customerNumValue>0?"img/arr-up.png":"img/arr-down.png";  				
  			
  				/*debugger;*/ //选择ID为accountNum的标签，把html括号里面的内容放到accountNum的标签里面	/*html(Number(Number(data.datas[0].accountNum)/10000).toFixed(2) */		
  				$("#accountNum").html((data.datas[0].accountNum)+ "  环比：" + (data.datas[0].accountNumRate)+"%"); 	
  				//var incomeTrendImgVis=incomeTrendValue=null?"none":"inline-block";
  				/*debugger;*/
  							
  				$("#connectNum").html(Number(Number(data.datas[0].connectNum)/10000).toFixed(2) + "  环比：" + (Number(data.datas[0].connectNumRate)).toFixed(2)+"%");
  				$("#activityTrend").html(Number(data.datas[0].activityTrend).toFixed(2)+"%");//全国连接激活率
  				$("#orderTrend").html(data.datas[0].orderTrend);
  				$("#incomeTrend").html(Number(Number(data.datas[0].incomeTrend)/10000).toFixed(2) + "  环比：" + (Number(data.datas[0].incomeTrendRate)).toFixed(2)+"%");  
  				$("#customerNum").html((data.datas[0].customerNumber)+ "  环比：" + (Number(data.datas[0].customerNumRate)).toFixed(2)+"%");
  				$("#accountNumImg").attr("src",accountNumImgUrl);
  				$("#accountNumImg").css("display","inline-block");
  				$("#customerNumImg").attr("src",customerNumImgUrl);
  				$("#customerNumImg").css("display","inline-block");
  				
  				$("#incomeTrendImg").attr("src",incomeTrendImgUrl);
  				$("#incomeTrendImg").css("display","inline-block");
  				$("#connectNumImg").attr("src",connectNumImgUrl);
  				$("#connectNumImg").css("display","inline-block"); 				
  			},
			error : function () {
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
			}
  		});
	}
	
	
	function getHomeRate() {                           		
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
	  					var chargeConnectRate = datas[0].chargeConnectRate*100;
	  					var acctChargeLiveRate = datas[0].acctChargeLiveRate*100;
	  	
	  					option = {
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
	  						            data: [{value: 50, name: '连接出账率'}]
	  						        }
	  						    ]
	  						};

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
  	  			        myChart5.setOption(option);   
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
	
	/*function getConNumActivityTrend(){//连接数-激活率-活跃率
		var xName=[];
		var activity=[];//激活率
		var activation=[];//活跃率-去掉
		var conNum=[];
		$.ajax({
  			type: "POST",
  			url: "piechart/getConNumActivityTrend.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (data.datas.length>0) {
  					if(data.code==200){  
  						datas = data.datas; 
  	  					for(var d in datas){
	  	  					xName.push(datas[d].name);
	  	  					activity.push(datas[d].value);
	  	  					activation.push(datas[d].value1);
	  	  					conNum.push(datas[d].value2);
  	  					}  
	  	  		       
	  	  			option = {
		  	  		        	title:{
			  	  		        	text: '各省发卡连接数（万个）',
		  					        x:'left',
		  					        y:'top'
		  	  		        	},
		  	  		        	grid: {
		  	  					    left: '50',
		  	  					    right: '50',
		  	  					    bottom:'20',

		  	  					    },
	  	  						tooltip: {
		  	  		            trigger: 'axis',
		  	  		            axisPointer: {
		  	  		                type: 'cross',
		  	  		                crossStyle: {
		  	  		                    color: '#999'
		  	  		                }
		  	  		            }
			  	  		        },
			  	  		        toolbox: {
			  	  		            /* feature: {
			  	  		                dataView: {show: true, readOnly: false},
			  	  		                magicType: {show: true, type: ['line', 'bar']},
			  	  		                restore: {show: true},
			  	  		                saveAsImage: {show: true}
			  	  		            } */
			  	  		        /*  },
			  	  		        
				  	  		    legend: {
			  			        	orient: 'vertical',
			  			        	left:'right',
			  			        	itemWidth: 20,
			  			            itemHeight: 10,
			  			            itemGap: 3,
			  			          	data:['连接数(万)','激活率'],
			  			            textStyle: {
			  			            	fontSize:12,
			  			            	color:'#777'
			  			         	}
			  	  		        },
			  	  		        xAxis: [
			  	  		            {
			  	  		                type: 'category',
			  	  		                data: xName,
			  	  		                axisPointer: {
			  	  		                    type: 'shadow'
			  	  		                }
			  	  		            }
			  	  		        ],
			  	  		        yAxis: [
			  	  		            {
			  	  		                type: 'value',
			  	  		                name: '连接数（万个）',
			  	  		                
			  	  		                axisLabel: {
			  	  		                    formatter: '{value} '
			  	  		                }
			  	  		            },
			  	  		            {
			  	  		                type: 'value',
			  	  		                name: '激活率',
			  	  		                min: -40,
			  	  		                max: 100,
			  	  		                interval: 20,
			  	  		                axisLabel: {
			  	  		                    formatter: '{value} %'
			  	  		                }
			  	  		            }
			  	  		        ],
			  	  		        series: [
			  	  		            {
			  	  		                name:'连接数(万)',
			  	  		                type:'bar',
			  	  		                data:conNum
			  	  		            },
			  	  		            {
			  	  		                name:'激活率',
			  	  		                type:'line',
			  	  		                yAxisIndex: 1,
			  	  		                data:activity
			  	  		            }
			  	  		        ]
		  	  				};
  	  					echarts.dispose(document.getElementById("main2"));
  	  					var myChart2 = echarts.init(document.getElementById('main2'));
  	  			        myChart2.setOption(option);   
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
	}*/
	function getPlatformBusiness(){//平台商机和客户情况
		var xName=[];
		var customerNum=[];//客户数 value
		var platformNum=[];//商机数 value1
  		$.ajax({
  			type: "POST",
  			url: "piechart/getPlatformBusiness.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (data.datas.length>0) {
  					if(data.code==200){
  						datas = data.datas; 
  	  					for(var d in datas){
	  	  					xName.push(datas[d].name);
	  	  					customerNum.push(datas[d].value);
	  	  					platformNum.push(datas[d].value1);
  	  					}   
			            option3 = {
			            		grid: {
			  	  					    left: '50',
			  	  					    right: '50',
			  	  					    bottom:'20',

			  	  					    },
	  						 title : {
	  					        text: '各省商用客户数及商机数（个）',
	  					        x:'left',
	  					        y:'top'
	  					    },
	  					    tooltip : {
	  					        trigger: 'axis'
	  					    },

	  					  legend: {
	  			        	orient: 'vertical',
	  			        	left:'right',
	  			        	itemWidth: 20,
	  			            itemHeight: 10,
	  			            itemGap: 3,
	  				        data:['客户数','商机数'],
	  			            textStyle: {
	  			            	fontSize:12,
	  			            	color:'#777'
	  			         }
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
	  					            name:'客户数',
	  					            type:'bar',
	  					            data:customerNum,
	  					            markPoint : {
	  					                data : [
	  					                    {type : 'max', name: '最大值'}
	  					                    /* ,
	  					                    {type : 'min', name: '最小值'} */
	  					                ]
	  					            },
	  					            markLine : {
	  					                data : [
	  					                    /* {type : 'average', name: '平均值'} */
	  					                ]
	  					            }
	  					        },
	  					        {
	  					            name:'商机数',
	  					            type:'bar',
	  					            data:platformNum,
	  					            markPoint : {
	  					                data : [
	  					                    {type : 'max', name: '最大值'}
	  					                    /* ,
	  					                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3} */
	  					                ]
	  					            },
	  					            markLine : {
	  					                data : [
	  					                   /*  {type : 'average', name : '平均值'} */
	  					                ]
	  					            }
	  					        }
	  					    ]
			            };
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
	function getPlatformIncome(){//平台收入分省情况
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
  				            option4 = {
  				            	    title : {
  				            	        text: '各省上账期应收账款（万元）',
  				            	        x:'center',
  		  					            y:'top'
  				            	    },
  				            	    tooltip : {
  				            	        trigger: 'axis',
  				        		        formatter: "{a} <br/>{b} : {c}"
  				            	    },  
  		  	  					    grid: {
  			  	  					    left: '0%',
  			  	  					    right: '0%',
  			  	  					    containLabel: true,
  			  	  					    y2: 10
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
  				            	            data : getOrderTrend.map(function (item) {
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
  				            	        {
  				            	            name:'应收账款',
  				            	            type:'bar',
  				            	          	barWidth : 8,//柱图宽度
  				            	            data:getOrderTrend.map(function (item) {
  				            	                return item[1];
  				            	            }),
  				            	            
  				            	            markPoint : {
  				            	                data : [
  				            	                    {type : 'max', name: '最大值'}
  				            	                    /* ,
  				            	                    {type : 'min', name: '最小值'} */
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
	function getConNum(){//全国连接数趋势
		var xDate = [];
		var yData = [];
  		$.ajax({
  			type: "POST",
  			url: "piechart/getConNum.do",
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
  	  						xDate.push(datas[d].name.trim());
  	  						yData.push((parseFloat(datas[d].value)/10000).toFixed(2));
  	  						lineChartByConnHisTrend1.push(
  	  							datas[d].name
  	  				        );  
  	  						lineChartByConnHisTrend2.push(
  	  							(parseFloat(datas[d].value)/10000).toFixed(2)
  	  				        );
  	  					}  
 				        
 				           var option5 = {
 	  	  							title: {
 		  	  					            text: '全国发卡连接数趋势（万个）',
 		  	  					        x:'center',
 			  					        y:'top'
 		  	  					        },
 		  	  					    grid: {
 		  	  					    left: '10',
 		  	  					    right: '10',
 		  	  					    bottom:'0',
 		  	  					    containLabel: true,
 		  	  					    y2: 10
 		  	  					    },
 		  	  					        tooltip: {
 		  	  					            trigger: 'axis'
 		  	  					        },
 		  	  					        xAxis:[ { 
 		  	  					            data:  lineChartByConnHisTrend1
 		  	  					        }]  ,
 		  	  					        yAxis: {
 		  	  					            splitLine: {
 		  	  					                show: false
 		  	  					            }
 		  	  					        /* ,
 		  	  					            min:Math.min.apply(Math, lineChartByConnHisTrend2)  */
 		  	  					        },   
 		  	  					        dataZoom: [{
 	  	  	  					            startValue: startMonth
 	  	  	  					        }, {
 	  	  	  					            type: 'inside'
 	  	  	  					        }],
 		  	  					        series: [{
 		  	  					            name: "连接数（万个）",
 		  	  					            type: 'line',
 		  	  					            data: lineChartByConnHisTrend2,
 		  	  					        
 		  	  					        }]
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

	function getCustomerNum(){//全国客户数趋势
		var xName = [];
		var yValue = [];
  		$.ajax({
  			type: "POST",
  			url: "piechart/getCustomerNum.do",
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
  	  						
  	  						lineChartByConnHisTrend1.push(
  	  							datas[d].name
  	  				        );  
  	  						lineChartByConnHisTrend2.push(
  	  							(parseFloat(datas[d].value)/10000).toFixed(2)
  	  				        );
  	  					}      
  	  					 
 				           var option6 = {
 	  	  							title: {
 		  	  					            text: '全国商用客户数趋势（万个）',
 		  	  					        x:'center',
 			  					        y:'top'
 		  	  					        },
 		  	  					    grid: {
 		  	  					    left: '10',
 		  	  					    right: '10',
 		  	  					    bottom:'0',
 		  	  					    containLabel: true,
 		  	  					    y2: 10
 		  	  					    },
 		  	  					        tooltip: {
 		  	  					            trigger: 'axis'
 		  	  					        },
 		  	  					        xAxis:[ { 
 		  	  					            data:  lineChartByConnHisTrend1
 		  	  					        }]  ,
 		  	  					        yAxis: {
 		  	  					            splitLine: {
 		  	  					                show: false
 		  	  					            }
 		  	  					        /* ,
 		  	  					            min:Math.min.apply(Math, lineChartByConnHisTrend2) */
 		  	  					        },   
 		  	  					        dataZoom: [{
 	  	  	  					            startValue: startMonth
 	  	  	  					        }, {
 	  	  	  					            type: 'inside'
 	  	  	  					        }],
 		  	  					        series: [{
 		  	  					            name: "客户数（万个）",
 		  	  					            type: 'line',
 		  	  					            data: lineChartByConnHisTrend2,
	 		  	  					       /* itemStyle:{
		  	  					        		normal:{
		  	  					        			lineStyle:{
		  	  					        				width:2
		  	  					        			}
		  	  					        		}
		  	  					        	} */
 		  	  					        }]
 	  	  	  				        };
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
	function getIncome(){//全国收入趋势
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
  	  							datas[d].name
  	  				        );  
  	  						lineChartByConnHisTrend2.push(
  	  							(parseFloat(datas[d].value)/10000).toFixed(2)
  	  				        );
  	  					}  	  
  	  					
         
 				           var option7 = {
 	  	  							title: {
 		  	  					            text: '全国应收账款趋势',
 		  	  					        x:'center',
 			  					        y:'top'
 		  	  					        },
 		  	  					    grid: {
 		  	  					    left: '10',
 		  	  					    right: '10',
 		  	  					    bottom:'0',
 		  	  					    containLabel: true,
 		  	  					    y2: 10
 		  	  					    },
 		  	  					        tooltip: {
 		  	  					            trigger: 'axis'
 		  	  					        },
 		  	  					        xAxis:[ { 
 		  	  					            data:  lineChartByConnHisTrend1
 		  	  					        }]  ,
 		  	  					        yAxis: {
 		  	  					            splitLine: {
 		  	  					                show: false
 		  	  					            }
 		  	  					        /* ,
 		  	  					            min:Math.min.apply(Math, lineChartByConnHisTrend2) */ 
 		  	  					        },   
 		  	  					        dataZoom: [{
 	  	  	  					            startValue: startMonth
 	  	  	  					        }, {
 	  	  	  					            type: 'inside'
 	  	  	  					        }],
 		  	  					        series: [{
 		  	  					            name: "收入(万元)",
 		  	  					            type: 'line',
 		  	  					            data: lineChartByConnHisTrend2,
 		  	  					        	/* itemStyle:{
 		  	  					        		normal:{
 		  	  					        			lineStyle:{
 		  	  					        				width:2
 		  	  					        			}
 		  	  					        		}
 		  	  					        	} */
 		  	  					        }]
 	  	  	  				        };
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
	
</script> 
 
<!-------------------------CONT---------------------------->  
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
           <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
           <div class="row cl">
           
					<div class="col-sm-12 col-box">
						<div class="number-box number-1" onclick="setDisplayContent(5);" style="position:relative;">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-05.svg">
				            </div>
				            <div class="right">
								<span class="name">全国上账期应收账款（万元）</span>
							  <p id="incomeTrend" class="number">loading...</p>
							  <img id="incomeTrendImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none">           
				            </div>
				        </div>
				        
				        <div class="number-box number-2" onclick="setDisplayContent(2);" style="position:relative;">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-02.svg">
				            </div>
				            <div class="right">
							    <span class="name">全国发卡连接数（万个）</span>    <!-- 全国实际到达连接数 -->
							  <p id="connectNum" class="number">loading...</p>
							  <img id="connectNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none">
							</div> 
				        </div>
				        <div class="number-box number-3" onclick="setDisplayContent(3);" >
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-03.svg">
				            </div>
				            <div class="right">
							  <span class="name">全国连接数激活率（%）</span>
							  <p id="activityTrend" class="number">loading...</p>
				            </div>
				        </div>
						<div class="number-box number-4" onclick="setDisplayContent(1);"style="position:relative;">
				            <div class="ico">
				              <img src="img/number-ico/number-ico-01.svg">
				            </div>
				            <div class="right">
							  <span class="name">全国总账户数（个）</span>
							  <p id="accountNum" class="number">loading...</p>
				            <img id="accountNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none;">
				            
				            </div>
				        </div>						
						<div class="number-box number-5" onclick="setDisplayContent(6);"style="position:relative;">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-06.svg">
				            </div>
				            <div class="right">
				              <span class="name">全国商用客户数（个）</span>
							  <p id="customerNum" class="number">loading...</p>
							<img id="customerNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none;"> 
							
							
							</div> 
				        </div>
				        <div class="number-box number-6" onclick="setDisplayContent(4);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-04.svg">
				            </div>
				            <div class="right">
								<span class="name">全国本账期累计发货订单数（个）</span>
							  <p id="orderTrend" class="number">loading...</p>
				            </div>
				        </div>
 					</div>
 					
				  </div>
				  
			<div class="row cl col-box-4" >
			<ul>
				  <!--<li class="lt"><div class="data">
				      <span id ="nodata4" style="display:none">各省上账期应收账款（万元）,无数据</span>	
				  	  <div id="main4" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  </li>
				  <li class="cr"><div class="data">
				      <span id ="nodata2" style="display:none">各省发卡连接数（万个）,无数据</span>
					  <div id="main2" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  </li>
				  <li class="rt"><div class="data">
				      <span id ="nodata3" style="display:none">各省商用客户数及商机数（个）,无数据</span>	
				  	  <div id="main3" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  </li>   -->
				  <li class="lt second"><div class="data">
				  	  <div id="main7" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  	  <span id ="nodata7" style="display:none">全国应收账款趋势,无数据</span>
				  </li>
				  <li class="cr second"><div class="data">
					  <div id="main5" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata5" style="display:none">连接出账率,无数据</span>
				  </li>
				 <!-- <li class="rt second"><div class="data">
					  <div id="main6" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata6" style="display:none">全国商用客户数趋势（个）,无数据</span>
				  </li>  -->
				  
				   <li class="rt second"><div class="data">
					  <div id="main8" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata8" style="display:none">细分行业,无数据</span>
				  </li>
				  
			</ul>
			</div>

  <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例 
        
    </script> 
	       </div> 
	  	 </div>                                      
        </div>       
 

 

</body>
</html>
