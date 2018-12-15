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
          	                                          
          		getIncomeByDetailIndustry();
          		getHomeAcctChargeLiveRateRate();
          		getHomeChargeConnectRate();
          		getPlatformBusiness();
          		getActiveByTrend();
          		getCustomAccountByType();
        	}
             
        }  
	});    

	
}); 

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
  	                                
  		getIncomeByDetailIndustry();
  		getHomeAcctChargeLiveRateRate();
  		getHomeChargeConnectRate();
  		getPlatformBusiness();
  		getActiveByTrend();
  		getCustomAccountByType();
	}
	
	//全国应收按细分行业
function getIncomeByDetailIndustry(){
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
	  	  			        //text: "词云图",
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
  			

  			/*function createRandomItemStyle() {
  			    return {
  			        normal: {
  			            color: 'rgb(' + [
  			                Math.round(Math.random() * 160),
  			                Math.round(Math.random() * 160),
  			                Math.round(Math.random() * 160)
  			            ].join(',') + ')'
  			        }
  			    };
  			}*/

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
	  	  	        autoSize: {
	  	            enable: true,
	  	            minSize: 14
	  	             },
	  	  	        //shape: 'smooth',
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
	  	  	                shadowColor: '#fff'
	  	  	            }
	  	  	        },
	  	  	    /* textStyle: {
                    normal: {
                        fontFamily: '微软雅黑',
                        color: function () {
                            var colors = ['#fda67e', '#81cacc', '#cca8ba', "#88cc81", "#82a0c5", '#fddb7e', '#735ba1', '#bda29a', '#6e7074', '#546570', '#c4ccd3'];
                            return colors[parseInt(Math.random() * 10)];
                        }
                    }
                },*/

	  	  	    data: [
	  	            {
	  	                name: '后装-汽车车载电子设备',
	  	                value: 34212328,
	  	                //itemStyle: createRandomItemStyle()
	  	            }, {
	  	                name: '车厂及车厂推动的后装产品',
	  	                value: 20754416,
	  	                //itemStyle: createRandomItemStyle()
	  	            }, {
	  	                name: '自动售货机、自动售票机等',
	  	                value: 11386012,
	  	                //itemStyle: createRandomItemStyle()
	  	            }, {
	  	                name: '智能热表',
	  	                value: 9270083,
	  	                //itemStyle: createRandomItemStyle()
	  	            }, {
	  	                name: 'PAD类',
	  	                value: 7941959,
	  	                //itemStyle: createRandomItemStyle()
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
  			
	

	function getHomeChargeConnectRate() {                           		
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
	  					//var acctChargeLiveRate = datas[0].acctChargeLiveRate*100;
	  	
	  					option5 = {
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
	  						            data: [{value: chargeConnectRate, name: '连接出账率'}]
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
	
	function getHomeAcctChargeLiveRateRate() {                           		
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
	  					var acctChargeLiveRate = datas[0].acctChargeLiveRate*100;
	  	
	  					option7 = {
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
	  						            data: [{value: acctChargeLiveRate, name: '连接活跃率'}]
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
		
	//平台商机和客户情况
	function getPlatformBusiness(){
		var xName=[];
		var customerNum=[];//客户数 value
		var platformNum=[];//商机数 value1
		var conversionRate=[];//转化率
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
	  	  				    conversionRate[d]=(customerNum[d]/platformNum[d])*100;
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
	  				        data:['客户数','商机数','转化率'],
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
	  					        },
	  					      {
	  					            type : 'value',
	  					            min: 0,
	  				                max: 200,
	  				                interval: 10,
	  					            axisLabel: {
	  					                   formatter: '{value} %'
	  					           }
	  					        }
	  					        
	  					    ],
	  					    series : [
	  					        {
	  					            name:'客户数',
	  					            type:'bar',
	  					            data:customerNum,
	  					           /* markPoint : {
	  					                data : [
	  					                    {type : 'max', name: '最大值'}
	  					                    
	  					                ]
	  					            },*/
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
	  					          /*  markPoint : {
	  					                data : [
	  					                    {type : 'max', name: '最大值'}
	  					                    
	  					                ]
	  					            },*/
	  					            markLine : {
	  					                data : [
	  					                   /*  {type : 'average', name : '平均值'} */
	  					                ]
	  					            }
	  					        },
	  					      {
	  				            name:'转化率',
	  				            type:'line',
	  				            yAxisIndex: 1,
	  				            data:conversionRate,
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
  				            	    title : {
  				            	        text: '激活连接数趋势'
  				            	    },
  				            	    tooltip : {
  				            	        trigger: 'axis',
  				        		        formatter: "{a} <br/>{b} : {c}%"
  				            	    },  
  		  	  					    grid: {
  			  	  					    left: '6%',
  			  	  					    right: '4%',
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
  				            	        {
  				            	            name:'激活连接数',
  				            	            type:'bar',
  				            	          	barWidth : 10,//柱图宽度
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
	

	function getCustomAccountByType(){
	    var xName=[];
		var customerNum1=[];//测试账户数 
		var customerNum2=[];//商用不计费
		var customerNum3=[];//商用计费
  		$.ajax({
  			type: "POST",
  			//url: "busAccSnap/getActiveByTrend.do",
  			url: "piechart/getCustomAccountByType.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (data.datas.length>0) {
  					if(data.code==200){
  						datas = data.datas; 	
  	  					for(var d in datas){
  	  					xName.push(datas[d].name);
  	  					customerNum1.push(datas[d].value);
  	  				    customerNum2.push(datas[d].value1);
  	  				    customerNum3.push(datas[d].value2);				
  	  					}  
  	  				option1 = {
  	  				    tooltip : {
  	  				        trigger: 'axis',
  	  				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
  	  				            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
  	  				        }
  	  				    },
  	  				    legend: {
  	  				        data: ['测试账户数', '商用不计费账户数','商用计费账户数']
  	  				    },
  	  				    grid: {
  	  				        left: '3%',
  	  				        right: '4%',
  	  				        bottom: '3%',
  	  				        containLabel: true
  	  				    },
  	  				    xAxis:  { 	  				       
  	  				        type: 'category',
  	  				        data: xName
  	  				    },
  	  				    yAxis: {
  	  				        type: 'value'
  	  				    },
  	  				    series: [
  	  				        {
  	  				            name: '测试账户数',
  	  				            type: 'bar',
  	  				            stack: '总量',
  	  				            label: {
  	  				                normal: {
  	  				                    show: true,
  	  				                    position: 'insideRight'
  	  				                }
  	  				            },
  	  				            data: customerNum1
  	  				        },
  	  				       
  	  				        {
  	  				            name: '商用不计费账户数',
  	  				            type: 'bar',
  	  				            stack: '总量',
  	  				            label: {
  	  				                normal: {
  	  				                    show: true,
  	  				                    position: 'insideRight'
  	  				                }
  	  				            },
  	  				            data: customerNum2
  	  				        },
  	  				        {
  	  				            name: '商用计费账户数',
  	  				            type: 'bar',
  	  				            stack: '总量',
  	  				            label: {
  	  				                normal: {
  	  				                    show: true,
  	  				                    position: 'insideRight'
  	  				                }
  	  				            },
  	  				            data: customerNum3
  	  				        }
  	  				    ]
  	  				};
  				      		echarts.dispose(document.getElementById("main1"));
  			  	  	        var myChart1 = echarts.init(document.getElementById('main1')); 
  	  			        	myChart1.setOption(option1);  
  	    	  			    $("#nodata1").css("display","none"); 
  	    					$("#main1").css("display","block"); 
  					}else{ 
  						$("#main1").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
  					}
  					
  				}else{
  				//	$("#main4").html("<br/><br/>激活率,无数据");  
  					$("#nodata1").css("display","block");
  					$("#main1").css("display","none");
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

				  
			<div class="row cl col-box-4" >
			<ul>
			      <li class="lt"><div class="data">
				      <span id ="nodata1" style="display:none">全国各省商用计费、商用不计费、测试账户数（个）,无数据</span>	
				  	  <div id="main1" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  </li>
				  <li class="cr"><div class="data">  
					  <span id ="nodata4" style="display:none;height:350px">激活连接数,无数据</span>
					  <div id="main4" style="width:350px;height:350px;"><br/><br/><img src="img/codeerror.gif" /></div>
				  </li>
				  <li class="rt"><div class="data">
				      <span id ="nodata3" style="display:none">全国各省商用客户数和出账客户（个）,无数据</span>	
				  	  <div id="main3" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  </li>
			  
				  <li class="lt second"><div class="data">
				  	  <div id="main7" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  	  <span id ="nodata7" style="display:none">连接活跃率</span>
				  </li>
				  <li class="cr second"><div class="data">
					  <div id="main5" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata5" style="display:none">连接出账率,无数据</span>
				  </li>
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
