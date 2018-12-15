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
          		getCustomListCompare();
          		getCustomActiCompare();
          		getCustomARPU();
          		getCustomAvagData();
          		getCustomNewAndCurrent();
          		getCustomIndustryProvince();
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
	var connectNum = $("#connectNum").html().trim();
	var activityTrend = $("#activityTrend").html().trim();
	var orderTrend = $("#orderTrend").html().trim();
	var incomeTrend = $("#incomeTrend").html().trim();                 
	var incomeTrendRate = $("#incomeTrendRate").html()==undefined?"":$("#incomeTrendRate").html().trim();    //add 20180921
	var customerNum = $("#customerNum").html().trim();
	var connectNumRate = $("#connectNumRate").html()==undefined?"":$("#connectNumRate").html().trim();        //add 20180921
	//var six_data =accountNum+"a"+connectNum+"a"+activityTrend.substr(0,activityTrend.length-1)+"a"+orderTrend+"a"+incomeTrend+"a"+customerNum;
	var six_data =accountNum+"a"+connectNum+"a"+activityTrend.substr(0,activityTrend.length-1)+"a"+orderTrend+"a"+incomeTrend+"a"+customerNum +"a"+incomeTrendRate+"a"+connectNumRate;
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
  		getCustomListCompare();
  		getCustomActiCompare();
  		getCustomARPU();
  		getCustomAvagData();
  		getCustomNewAndCurrent();
  		getCustomIndustryProvince();
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
  				var incomeTrendValue=(Number(data.datas[0].incomeTrendRate)).toFixed(2);
  				var incomeTrendImgUrl=incomeTrendValue>0?"img/arr-up.png":"img/arr-down.png";  	
  				var connectNumValue=(Number(data.datas[0].connectNumRate)).toFixed(2);
  				var connectNumImgUrl=connectNumValue>0?"img/arr-up.png":"img/arr-down.png"; 	
  				//var incomeTrendImgVis=incomeTrendValue=null?"none":"inline-block";
  				/*debugger;*/
  				$("#accountNum").html(data.datas[0].accountNum); 				
  				$("#connectNum").html(Number(Number(data.datas[0].connectNum)/10000).toFixed(2) + "  环比：" + (Number(data.datas[0].connectNumRate)).toFixed(2)+"%");
  				$("#activityTrend").html(Number(data.datas[0].activityTrend).toFixed(2)+"%");
  				$("#orderTrend").html(data.datas[0].orderTrend);
  				$("#incomeTrend").html(Number(Number(data.datas[0].incomeTrend)/10000).toFixed(2) + "  环比：" + (Number(data.datas[0].incomeTrendRate)).toFixed(2)+"%");  
  				$("#customerNum").html(data.datas[0].customerNumber); 
  				
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
	function getConNumActivityTrend(){//连接数-激活率-活跃率
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
	  	  		        // 指定图表的配置项和数据
	  	  		        /* option = {
	  	  		        	title:{
		  	  		        	text: '各省发卡连接数（万个）',
	  					        x:'center',
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
		  	  		             feature: {
		  	  		                dataView: {show: true, readOnly: false},
		  	  		                magicType: {show: true, type: ['line', 'bar']},
		  	  		                restore: {show: true},
		  	  		                saveAsImage: {show: true}
		  	  		            } 
		  	  		        },
		  	  		        legend: {
		  	  		            data:['激活率','活跃率','连接数(十万)']
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
		  	  		                name: '激活率',
		  	  		                min: 0,
		  	  		                max: 160,
		  	  		                interval: 20,
		  	  		                axisLabel: {
		  	  		                    formatter: '{value} %'
		  	  		                }
		  	  		            },
		  	  		            {
		  	  		                type: 'value',
		  	  		                name: '活跃率',
		  	  		                min: 0,
		  	  		                max: 160,
		  	  		                interval: 20,
		  	  		                axisLabel: {
		  	  		                    formatter: '{value} %'
		  	  		                }
		  	  		            }
		  	  		        ],
		  	  		        series: [
		  	  		            {
		  	  		                name:'激活率',
		  	  		                type:'bar',
		  	  		                data:activity
		  	  		            },
		  	  		            {
		  	  		                name:'活跃率',
		  	  		                type:'bar',
		  	  		                data:activation
		  	  		            },
		  	  		            {
		  	  		                name:'连接数(十万)',
		  	  		                type:'line',
		  	  		                yAxisIndex: 1,
		  	  		                data:conNum
		  	  		            }
		  	  		        ]
	  	  				}; */
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
			  	  		        },
			  	  		        
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
	}
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
  	  						if (datas[d].isForecastFlag==1) forecast=forecast+1;
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
  	  					 /* option6 = {
	  	  						tooltip: {
	  	  				        trigger: 'axis',
	  	  				        position: function (pt) {
	  	  				            return [pt[0], '10%'];
	  	  				        }
	  	  				    },
	  	  				    grid:{
	  	  				    	right:35,
	  	  				    },
	  	  				    title: {
	  	  				        left: 'center',
	  	  				        text: '全国商用客户数趋势（万个）',
	  	  				    },
	  	  				    toolbox: {
	  	  				        
	  	  				    },
	  	  				    xAxis: {
	  	  				        type: 'category',
	  	  				        boundaryGap: false,
	  	  				        data: xName
	  	  				    },
	  	  				    yAxis: {
	  	  				        type: 'value'
	  	  				    },
	  	  				    dataZoom: [{
	  	  				        type: 'inside',
	  	  				        start: 0,
	  	  				        end: 10
	  	  				    }, {
	  	  				        start: 0,
	  	  				        end: 10,
	  	  				        handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
	  	  				        handleSize: '80%',
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
	  	  				            name:'客户数（万个）',
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
 				            };  */
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
	
	function getCustomActiCompare() {  
		$.ajax({
  			type: "POST",
  			url: "piechart/getCustomActiCompare.do",
  			data: param,
  			datatype: "json",
  			success: function(data){ 
  				var listString = "";
  				for(var d in data){
  					listString += "<tr>";
  					var actiNumQoqImgUrl=data[d].actiNumQoqFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					var actiActualDutyImgUrl=data[d].actiActualDutyFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					var actiNumDutyImgUrl=data[d].actiNumDutyFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					var newActiDutyImgUrl=data[d].newActiDutyFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					listString += "<td>"+data[d].provinceName+"</td>"; 
  					listString += "<td>"+(Number(data[d].actiNumQoq)*100).toFixed(2)+"%<img src='"+actiNumQoqImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
  					listString += "<td>"+(Number(data[d].actiActualDuty)*100).toFixed(2)+"%<img src='"+actiActualDutyImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
  					listString += "<td>"+(Number(data[d].actiNumDuty)*100).toFixed(2)+"%<img src='"+actiNumDutyImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
  					listString += "<td>"+(Number(data[d].newActiDuty)*100).toFixed(2)+"%<img src='"+newActiDutyImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
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
	function getCustomListCompare() {  
		$.ajax({
  			type: "POST",
  			url: "piechart/getCustomListCompare.do",
  			data: param,
  			datatype: "json",
  			success: function(data){ 
  				var listString = "";
  				for(var d in data){
  					listString += "<tr>";
  					var incomeqoqImgUrl=data[d].incomeQoqFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					var incomedutyImgUrl=data[d].incomeDutyFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					listString += "<td>"+data[d].provinceName+"</td>"; 
  					listString += "<td>"+(Number(data[d].incomeQoq)*100).toFixed(2)+"%<img src='"+incomeqoqImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
  					listString += "<td>"+(Number(data[d].incomeDuty)*100).toFixed(2)+"%<img src='"+incomedutyImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
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
	
	function getCustom2Compare() {  
		$.ajax({
  			type: "POST",
  			url: "piechart/getCustom2Compare.do",
  			data: param,
  			datatype: "json",
  			success: function(data){ 
  				var listString = "";
  				for(var d in data){
  					listString += "<tr style=\"line-height:24px;\">";
  					var incomeqoqImgUrl=data[d].incomeQoqFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					var incomedutyImgUrl=data[d].incomeDutyFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					listString += "<td style=\"width:150px\">"+data[d].provinceName+"</td>"; 
  					listString += "<td style=\"width:150px\">"+(Number(data[d].incomeQoq)*100).toFixed(2)+"%<img src='"+incomeqoqImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
  					listString += "<td style=\"width:150px\">"+(Number(data[d].incomeDuty)*100).toFixed(2)+"%<img src='"+incomedutyImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
  					var actiNumQoqImgUrl=data[d].actiNumQoqFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					var actiActualDutyImgUrl=data[d].actiActualDutyFlag>0?"img/arr-up.png":"img/arr-down.png"; 
  					listString += "<td style=\"width:150px\">"+(Number(data[d].actiNumQoq)*100).toFixed(2)+"%<img src='"+actiNumQoqImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
  					listString += "<td style=\"width:150px\">"+(Number(data[d].actiActualDuty)*100).toFixed(2)+"%<img src='"+actiActualDutyImgUrl+"' style=\"height:60px;width:20px;\"/>"+"</td>"; 
  					listString += "</tr>";	
					}     
  				$("#customListCompare3").html(listString); 				
  			},
			error : function () {
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
			}
  		});
	}
	function getCustomIndustryProvince() {  
		$.ajax({
  			type: "POST",
  			url: "piechart/getCustomIndustryProvince.do",
  			data: param,
  			datatype: "json",
  			success: function(data){ 
  				var listString = ""; 
  			  	for(var key in data){
  					listString += "<tr >"; 
  					listString += "<td >"+key+"</td>";  
  					var pros = data[key];
  					for(var d in pros){
  						listString += "<td>"+pros[d].currentActiNum+"</td>"; 
  						listString += "<td>"+(Number(pros[d].currentActiCuty)*100).toFixed(2)+"%"+"</td>"; 
  						listString += "<td>"+(Number(pros[d].currentActiYoy)*100).toFixed(2)+"%"+"</td>"; 
  	  					
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
	
	function getCustomARPU(){//全国连接数趋势
		var xDate = [];
		var yData = [];
  		$.ajax({
  			type: "POST",
  			url: "piechart/getCustomARPU.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (data.length>0) {
  				//	if(data.code==200){
  	  					for(var d in data){
  	  						xDate.push(data[d].arpu); 
  	  						yData.push(data[d].chargConnectNum/10000);   
  	  					}    
 
 				           var option5 = {
 				        		    title: {
 				        		        text: '全国每连接收入分布(万)',
 				        		       	subtext: '横坐标是ARPU，纵坐标是相同ARPU值的个数'
 				        		    },
 				        		    tooltip: {},
 				        		    xAxis: {
 				        		        data: xDate,
 				        		        silent: false,
 				        		        splitLine: {
 				        		            show: false
 				        		        }
 				        		    },
 				        		    yAxis: {
 				        		    //	name:'ARPU',
 				        		    	axisLabel: {
		  	  		                    	formatter: '{value} '
		  	  		                	}
 				        		    },
 				        		    series: [{
 				        		    //    name: 'arpu',
 				        		        type: 'bar',
 				        		        data: yData 
 				        		    }] 
 	  	  	  				 };
 				      		echarts.dispose(document.getElementById("main5")); 
 			  	  	        var myChart5 = echarts.init(document.getElementById('main5'));
 	  			        	myChart5.setOption(option5);   
 	  	  			    	$("#nodata5").css("display","none"); 
 	  						$("#main5").css("display","block"); 
 	  						xDate.splice(0,xDate.length); 
 	  						yData.splice(0,yData.length);
  					/* }else{ 
  						$("#main5").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
  					} */
  					
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
	
	
	function getCustomAvagData(){//全国连接数趋势
		var xDate = [];
		var yData = [];
  		$.ajax({
  			type: "POST",
  			url: "piechart/getCustomAvagData.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (data.datas.length>0) {
  				//	if(data.code==200){
  					 
  	    				var a = data.datas
  	  					for(var d in a){  
  	  						xDate.push(a[d].industryMainProductName); 
  	  						yData.push((parseFloat(a[d].avgData)).toFixed(2));   
  	  					}    
  	    				var secondName ='10';
  	    				var secondValue ='10' ;
  	    				var thirdName  ='10';
  	    				var thirdValue  ='10';
  	    				if(data.secondName != "" && data.secondName != null || data.secondName!= undefined){  
  	    					secondName = data.secondName;
  	  	    				secondValue = data.secondValue;
  	  	    				thirdName = data.thirdName;
  	  	    				thirdValue = data.thirdValue;
  	    			    }
  	    				  
  	    				option10 = {

  	    					    tooltip: {
  	    					        trigger: 'axis'
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
		            	                		 color:"#b6bcff"
		            	                	}	            	            
		            	                }
  	    					    },
  	    					    yAxis: {
  	    					        type: 'value',
  	    					      boundaryGap:[0.5, 1]
  	    					    },
  	    					    series: [{
  	    					        data: yData,
  	    					        type: 'line',
  	    					        symbol: 'circle',
  	    					        symbolSize: 10,
  	    					        lineStyle: {
  	    					            normal: {
  	    					                color: 'yellow',
  	    					                width: 4
  	    					            }
  	    					        },
  	    					        label: {
  	    					                normal: {
  	    					                    show: true,
  	    					                    position: 'bottom',
  	    					                    color:'blue'
  	    					                }
  	    					            },
  	    					        markPoint: { 
  	    					        	label: {
  	    					                normal: {
  	    					                    show: true,
  	    					                    position: 'inside',
  	    					                    color:'yellow',
  	    					                    formatter:'{b}'
  	    					                }
  	    					            },
  	    					        	                itemStyle: {
  	    					        	                    normal: {
  	    					        	                        borderColor: 'green',
  	    					        	                        color:'green',
  	    					        	                        borderWidth: 1,            // 标注边线线宽，单位px，默认为1
  	    					        	                        label: {
  	    					        	                            show: false
  	    					        	                        }
  	    					        	                    }  
  	    					        	                    },
  	    					                data: [
  	    					                   {
  	    					        name: '1',
  	    					        type: 'max'
  	    					    }, 
  	    					    {
  	    					        name: '2',
  	    					        coord: [secondName,secondValue]
  	    					    },  
  	    					    {
  	    					        name: '3',
  	    					        coord: [thirdName,thirdValue]
  	    					    } 
  	    					                ]
  	    					        },
  	    					        itemStyle: {
  	    					            normal: {
  	    					                borderWidth: 3,
  	    					                borderColor: 'yellow',
  	    					                color: 'yellow'
  	    					            }
  	    					        }
  	    					    }]
  	    					};
 				      		echarts.dispose(document.getElementById("main10")); 
 			  	  	        var myChart10 = echarts.init(document.getElementById('main10'));
 	  			        	myChart10.setOption(option10);   
 	  	  			    	$("#nodata10").css("display","none"); 
 	  						$("#main10").css("display","block"); 
 	  						xDate.splice(0,xDate.length); 
 	  						yData.splice(0,yData.length);
  					/* }else{ 
  						$("#main5").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
  					} */
  					
  				}else{
  					$("#nodata10").css("display","block");
  					$("#main10").css("display","none");
  				}
  			},
			error : function () {  
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
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
  	    					    yAxis:  {
  	    					        type: 'value'
  	    					    },
  	    					    xAxis: {
  	    					        type: 'category',
  	    					        data: xDate
  	    					    },
  	    					    series: [
  	    					        {
  	    					            name: '新增',
  	    					            type: 'bar',
  	    					            stack: '总量', 
  	    					            data: yDate
  	    					        },
  	    					        {
  	    					            name: '各省已激活数',
  	    					            type: 'bar',
  	    					            stack: '总量',
  	    					            data: yDate2
  	    					        }
  	    					    ]
  	    					};
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
						<div class="number-box number-4" onclick="setDisplayContent(1);">
				            <div class="ico">
				              <img src="img/number-ico/number-ico-01.svg">
				            </div>
				            <div class="right">
							  <span class="name">全国总账户数（个）</span>
							  <p id="accountNum" class="number">loading...</p>
				            </div>
				        </div>						
						<div class="number-box number-5" onclick="setDisplayContent(6);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-06.svg">
				            </div>
				            <div class="right">
				              <span class="name">全国商用客户数（个）</span>
							  <p id="customerNum" class="number">loading...</p>
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
<script type="text/javascript"> 
   //先在table的最后增加一行，然后再把第一行中的数据填充到新增加的行中，最后再删除table的第一行
   function change(table){
      var row = table.insertRow(table.rows.length);//在table的最后增加一行,table.rows.length是表格的总行数
      for(j=0;j<table.rows[0].cells.length;j++){//循环第一行的所有单元格的数据，让其加到最后新加的一行数据中（注意下标是从0开始的）
         var cell = row.insertCell(j);//给新插入的行中添加单元格
         cell.height = "24px";//一个单元格的高度，跟css样式中的line-height高度一样
         cell.innerHTML = table.rows[0].cells[j].innerHTML;//设置新单元格的内容，这个根据需要，自己设置
      }
      table.deleteRow(0);//删除table的第一行
   };
   function tableInterval(){
      var table = document.getElementById("customListCompare3");//获得表格
      change(table);//执行表格change函数，删除第一行，最后增加一行，类似行滚动
   };
   setInterval("tableInterval()",2400);//每隔2秒执行一次change函数，相当于table在向上滚动一样
</script>  
			<div class="row cl col-box-4" >
			<ul>
				  <li class="lt" style="width:700px; "> 
				      <div class="data">
					  <div id="main10" style="width:1600px;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata10" style="display:none">全国各行业平均每连接流量（M）,无数据</span>
				  </li> 
				  <!-- 
				  <li class="rt"><div class="data">
				      <span id ="nodata3" style="display:none">各省商用客户数及商机数（个）,无数据</span>	
				  	  <div id="main3" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  </li>
				   -->
				  <li class="rt">
				  <div class="data" style="width:90%; height:260px; overflow:scroll;"> 
				       <table class="table table-primary mt-10" style="width:100%; height:250px;">
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
				  </li> 
				  <li class="cr second"><div class="data">
					  <div id="main5" style="width:300px;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata5" style="display:none">全国每连接收入分布,无数据</span>
				  </li>
				  <li class="rt second"> 
				  <div class="data" style="width:90%; height:260px; overflow:scroll;"> 
				       <table class="table table-primary mt-10" style="width:500px; height:250px;">
						<thead>
							<tr>
								<th>省分</th>
								<th style="width:100px; ">激活连接数环比</th> 
								<th style="width:100px; ">激活连接数占发卡连接数占比</th>
								<th style="width:100px; ">本月激活连接数各省占比</th> 
								<th style="width:100px; ">本月新增激活连接数各省占比</th>
							</tr>
						</thead>
						<tbody id="customListCompare2">

						</tbody>
						</table>
					</div>
				  </li>
				  
				   <li class="cr second"><div class="data">
					  <div id="main15" style="width:1000px;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata15" style="display:none">各省已激活及新增激活连接数（万个）,无数据</span>
				  </li>
				    <li class="rt second"> 
				  <div class="data" style="width:90%; height:260px; overflow:scroll;"> 
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
