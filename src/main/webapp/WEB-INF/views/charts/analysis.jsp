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
<body>
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
          		getConNumActivityTrend();//连接数-激活率-活跃率 getPieChart();
          		getPlatformBusiness();//平台商机和客户情况 getLineChartByConnHisTrend();
          		getPlatformIncome();//平台收入分省情况 getActiveRateByTrend();
          		getConNum();//全国连接数趋势 getTotalChargeRend();
          		getCustomerNum();//全国客户数趋势 getOrderTrend();
          		getIncome();//全国收入趋势
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
  		getConNumActivityTrend();//连接数-激活率-活跃率 getPieChart();
  		getPlatformBusiness();//平台商机和客户情况 getLineChartByConnHisTrend();
  		getPlatformIncome();//平台收入分省情况 getActiveRateByTrend();
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
  				console.log(data);
  				var accountNumValue=(Number(data.datas[0].accountNumRate)).toFixed(2);//add in 2018-09-26
  				var accountNumImgUrl=accountNumValue>0?"img/arr-up.png":"img/arr-down.png";
  				var incomeTrendValue=(Number(data.datas[0].incomeTrendRate)).toFixed(2);
  				var incomeTrendImgUrl=incomeTrendValue>0?"img/arr-up.png":"img/arr-down.png";  	
  				var connectNumValue=(Number(data.datas[0].connectNumRate)).toFixed(2);
  				var connectNumImgUrl=connectNumValue>0?"img/arr-up.png":"img/arr-down.png"; 
  				var customerNumValue=(Number(data.datas[0].customerNumRate)).toFixed(2);//add in 2018-09-26
  				var customerNumImgUrl=customerNumValue>0?"img/arr-up.png":"img/arr-down.png";  				
  				var myChart7 = echarts.init(document.getElementById('main8'));
  				
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
  					    ],
  					    
  					  //渐变柱效果//////////////////////////////////////////////////////////////
  					  
  					  /* series : [
  				          //柱一
  				            {
  				                name:'业务指标',
  				                type:'gauger', 
  				                barWidth: 10,
  				              	detail: {formatter:'{value}%'},
  				              	data: [{value: 50, name: '连接数激活率'}],
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
  				     },
  					] */
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
			  	  		        	//text: '各省发卡连接数（万个）',
		  					        x:'left',
		  					        y:'top'
		  	  		        	},
			  	  		        grid: {
				  	  		        left: 70,
				  	  		        right: 70,
				  	  		        top: 100,
				  	  		        bottom: 80,
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
			  			        	left:'right',
			  			        	itemWidth: 10,
			  			            itemHeight: 10,
			  			            itemGap: 10,
			  			          	padding:[18, 27, 15, 20] ,
			  			          	data:['连接数(万)','激活率'],
			  			            textStyle: {
			  			            	fontSize:12,
			  			            	color:'#b2bddb'
			  			         	}
			  	  		        },
			  	  		        xAxis: [
			  	  		            {
			  	  		                type: 'category',
			  	  		                data: xName,
			  	  		                axisPointer: {
			  	  		                    type: 'shadow'
			  	  		                },
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
			  	  		            }
			  	  		        ],
			  	  		        yAxis: [
			  	  		            {
			  	  		                type: 'value',
			  	  		                name: '连接数（万个）',
			  	  		                
			  	  		                axisLabel: {
			  	  		                    formatter: '{value} '
			  	  		                },
			  	  		            axisLine:{
			  	                        lineStyle:{
			  	                            color:'#617685',
			  	                            width:1,//这里是为了突出显示加上的
			  	                        }
			  	                    },
			  	  		            },
			  	  		            
			  	  		            {
			  	  		                type: 'value',
			  	  		                name: '激活率',
			  	  		                min: -40,
			  	  		                max: 100,
			  	  		                interval: 20,
			  	  		                axisLabel: {
			  	  		                    formatter: '{value} %'
			  	  		                },
			  	  		            axisLine:{
			  	                        lineStyle:{
			  	                            color:'#617685',
			  	                            width:1,//这里是为了突出显示加上的
			  	                        }
			  	                    },
			  	  		            }
			  	  		        ],
			  	  		        /* series: [
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
			  	  		        ] */
			  	  		    series : [
		  				          //柱一
		  				            {
		  				            	name:'连接数(万)',
			  	  		                type:'bar',
			  	  		                data:conNum,
		  				                barWidth: 5,
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
		  				                	 {offset: 1, color: '#63a5ff'}, 
		  				                    	{offset: 0, color: '#5e74fd'}, 
		  				                   ]
		  				              )
		  				             }
		  				         }
		  				     },
		  				   {
		  	  		                name:'激活率',
		  	  		                type:'line',
		  	  		                yAxisIndex: 1,
		  	  		                data:activity,
		  	  		                //折线修改
			  	  		            itemStyle : {
										normal : {
											lineBorderRadius: '10',
											color:'#ffd146',//点
											lineStyle:{
												color:'#ffd146',//线
												width:2// 0.1的线条是非常细的了
											}
										}
									},

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
				  	  		        left: 80,
				  	  		        right: 50,
				  	  		        top: 100,
				  	  		        bottom: 80,
			  	  		    	},
	  						 title : {
	  					        //text: '各省商用客户数及商机数（个）',
	  					        x:'left',
	  					        y:'top'
	  					    },
	  					    tooltip : {
	  					        trigger: 'axis'
	  					    },

	  					  legend: {
	  			        	//orient: 'vertical',
	  			        	left:'right',
	  			        	itemWidth: 10,
	  			            itemHeight: 10,
	  			            itemGap: 3,
	  			          	padding:[18, 27, 15, 20] ,
	  				        data:['客户数','商机数'],
	  				      textStyle: {
	  			            	fontSize:12,
	  			            	color:'#b2bddb'
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
	  					  xAxis: [
		  	  		            {
		  	  		                type: 'category',
		  	  		                data: xName,
		  	  		                axisPointer: {
		  	  		                    type: 'shadow'
		  	  		                },
		  	  		            /* axisLine:{
		  	                        lineStyle:{
		  	                            color:'#617685',
		  	                            width:1,//这里是为了突出显示加上的
		  	                        }
		  	                    }, */
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
		  	  		            }
		  	  		        ],
	  					  yAxis: [
		  	  		            {
		  	  		                type: 'value',
		  	  		                name: '客户数、商机数',
		  	  		                
		  	  		                axisLabel: {
		  	  		                    formatter: '{value} '
		  	  		                },
		  	  		            axisLine:{
		  	                        lineStyle:{
		  	                            color:'#617685',
		  	                            width:1,//这里是为了突出显示加上的
		  	                        }
		  	                    },
		  	  		            },
		  	  		        ],
	  					  series : [
	  	                       //柱一
	  	                         {
	  	                          name:'客户数',
	  	                               type:'bar',
	  	                             data:customerNum,
	  	                             barWidth: 5,
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
	  	                //柱二
	  	                {
	  	                   name:'商机数',
	  	                              type:'bar',
	  	                            data:platformNum,
	  	                            barWidth: 5,
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
	  	                                	{offset: 1, color: '#ffd66c'}, 
	  				                    	{offset: 0, color: '#feb127'}, 
	  	                                 
	  	                                ]
	  	                             )
	  	                        },
	  	                        emphasis: {
	  	                          color: new echarts.graphic.LinearGradient(
	  	                                0, 0, 0, 1,
	  	                               [
	  	                            	 {offset: 0, color: '#ffd66c'}, 
	  				                    	{offset: 1, color: '#feb127'},
	  	                               ]
	  	                          )
	  	                         }
	  	                     }
	  	                 },
	  	              ]
	  					    
	  				/* 	    series : [
	  					        {
	  					            name:'客户数',
	  					            type:'bar',
	  					            data:customerNum,
	  					            markPoint : {
	  					                data : [
	  					                    {type : 'max', name: '最大值'}
	  					                    ,
	  					                    {type : 'min', name: '最小值'} 
	  					                ]
	  					            },
	  					            markLine : {
	  					                data : [
	  					                     {type : 'average', name: '平均值'} 
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
	  					                    
	  					                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3} 
	  					                ]
	  					            },
	  					            markLine : {
	  					                data : [
	  					                    {type : 'average', name : '平均值'} 
	  					                ]
	  					            }
	  					        }
	  					    ] */
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
  				            option4 = {
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
  				        		        formatter: "{a} <br/>{b} : {c}"
  				            	    },  
  				            	  grid: {
  				  	  		        left: 80,
  				  	  		        right: 50,
  				  	  		        top: 100,
  				  	  		        bottom: 80,
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
			            	                axisLine:{
			            	                	lineStyle:{
			            	                		color:"#A3A3A3"
			            	                	}
			            	                },
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
  				            	        }
  				            	    ],
  				            	    yAxis : [
  				            	        {
  				            	            type : 'value',
  				            	            axisLabel:{
  			            	                	textStyle:{
  			            	                		//fontWeight:"bolder",
  			            	                		 //fontSize:4,
  			            	                		 color:"#A3A3A3"
  			            	                	}
  				            	            },
  				            	          axisLine:{
  				  	                        lineStyle:{
  				  	                            color:'#617685',
  				  	                            width:1,//这里是为了突出显示加上的
  				  	                        }
  				  	                    },
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
  				  	                             barWidth: 5,
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
 				        /* option5 = {
	  	  						tooltip: {
	  	  				        trigger: 'axis',
	  	  				        position: function (pt) {
	  	  				            return [pt[0], '10%'];
	  	  				        }
	  	  				    },
	  	  				    title: {
	  	  				        left: 'center',
	  	  				        text: '全国发卡连接数趋势（万个）',
	  	  				    },
	  	  				    toolbox: {
	  	  				        
	  	  				    },
	  	  				    xAxis: {
	  	  				        type: 'category',
	  	  				        boundaryGap: false,
	  	  				        data: xDate
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
	  	  				            name:'连接数(万个)',
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
	  	  				            data: yData
	  	  				        }
	  	  				    ]
 				            };  */
 				           var option5 = {
 	  	  							title: {
 		  	  					            //text: '全国发卡连接数趋势（万个）',
 		  	  					        x:'center',
 			  					        y:'top'
 		  	  					        },
 		  	  					   grid: {
  		  	  					    	top:80,
		  	  					    	left: 75,
		  	  					    	right: 35,
		  	  					    	bottom: 40,
		  	  					    //containLabel: true,
		  	  					    //y2: 10
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
 		  	  					        /* dataZoom: [{
 	  	  	  					            startValue: startMonth
 	  	  	  					        }, {
 	  	  	  					            type: 'inside'
 	  	  	  					        }], */
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
 		  	  					            //text: '全国商用客户数趋势（万个）',
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
 		  	  					            data:  lineChartByConnHisTrend1,
 		  	  					        }],
 		  	  					        yAxis: {
 		  	  					            splitLine: {
 		  	  					                show: false,
 		  	  					            },
 		  	  					       axisLine:{
		            	                	lineStyle:{
		            	                		color:"#04315e"
		            	                	}
		            	                },
 		  	  					        /* ,
 		  	  					            min:Math.min.apply(Math, lineChartByConnHisTrend2) */
 		  	  					        },   
 		  	  					        /* dataZoom: [{
 	  	  	  					            startValue: startMonth
 	  	  	  					        }, {
 	  	  	  					            type: 'inside'
 	  	  	  					        }], */
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
 				           
 				           var option7 = {
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
   		  	  					    	top:80,
 		  	  					    	left: 75,
 		  	  					    	right: 35,
 		  	  					    	bottom: 40,
 		  	  					    //containLabel: true,
 		  	  					    //y2: 10
 		  	  					    },
 		  	  					        tooltip: {
 		  	  					            trigger: 'axis'
 		  	  					        },		  	  					      
 		  	  					        xAxis:[ { 
 		  	  					            data:lineChartByConnHisTrend1, 
 		  	  					        	splitLine: {
 		  	  					        		show: false
 		  	  					        	},
 		  	  					            axisLabel:{
			            	                	//interval:0,
			            	                	//rotate:45,
			            	                	//margin:6,
			            	                	textStyle:{
			            	                		//fontWeight:"bolder",
			            	                		 //fontSize:4,
			            	                		 color:"#A3A3A3"
			            	                	}	            	            
			            	                }, 
			            	                axisLine:{
			                                    lineStyle:{
			                                        color:'#b2bddb',
			                                        width:1,//这里是为了突出显示加上的
			                                    }
			                                },
 		  	  					        }] ,
 		  	  					        yAxis: {
 		  	  					            splitLine: {
 		  	  					                show: true
 		  	  					            },
 				                            axisLabel:{
			            	                	//interval:0,
			            	                	//rotate:45,
			            	                	//margin:6,
			            	                	textStyle:{
			            	                		//fontWeight:"bolder",
			            	                		 //fontSize:4,
			            	                		 color:"#A3A3A3"
			            	                	}	            	            
			            	                }, 
			            	                axisLine:{
			                                    lineStyle:{
			                                        color:'#b2bddb',
			                                        width:1,//这里是为了突出显示加上的
			                                    }
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
</script>
<div class="unicom"> 
	<div class="header">
		<span>首页</span>
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
	</style>    
	
	<!-- 轮播卡片 -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide slide-1"  style="background:#22a8ee">
				<div id="incomeTrend" class="shuzi">345678</div>
				<div class="title">全国上账期应收账款（万元）</div>
				<a onclick="setDisplayContent(5);" class="more">查看详情</a>
				<!-- <img id="incomeTrendImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none">  -->
			</div>
			<div class="swiper-slide slide-2"  style="background:#22a8ee">
				<div id="connectNum" class="shuzi">345678</div>
				<div class="title">全国发卡连接数（万个）</div>
				<a onclick="setDisplayContent(2);" class="more">查看详情</a>
				<!-- <img id="connectNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none">  -->
			</div>
			<div class="swiper-slide slide-3"  style="background:#22a8ee">
				<div id="activityTrend" class="shuzi">130%</div>
				<div class="title">全国连接数激活率（%）</div>
				<a onclick="setDisplayContent(3);" class="more">查看详情</a>
			</div>
			<div class="swiper-slide slide-4" style="background:#22a8ee">
				<div id="accountNum" class="shuzi">345678</div>
				<div class="title">全国总账户数（个)</div>
				<a onclick="setDisplayContent(1);" class="more">查看详情</a>
				<!-- <img id="accountNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none">  -->
			</div>
			<div class="swiper-slide slide-5" style="background:#22a8ee">
				<div id="customerNum" class="shuzi">345678</div>
				<div class="title">全国商用客户数（个）</div>
				<a onclick="setDisplayContent(6);" class="more">查看详情</a>
				<!-- <img id="customerNumImg" src="" style="height:60px;width:20px;position:absolute;right:2px;top:20px;display:none">  -->
			</div>
			<div class="swiper-slide slide-6" style="background:#22a8ee">
				<div id="orderTrend" class="shuzi">345678</div>
				<div class="title">全国本账期累计发货订单数（个）</div>
				<a onclick="setDisplayContent(4);" class="more">查看详情</a>
			</div>
		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
	</div> 
	<!-- Swiper JS -->
	<script>
	  var swiper = new Swiper('.swiper-container', {
	    loop : true,//无限循环
	    slidesPerView: 4,
	    spaceBetween: 15,
	    autoplay: {
	       delay: 3000,
	       disableOnInteraction: false,
	     },
	    pagination: {
	      el: '.swiper-pagination',
	      clickable: true,
	    },
	  });
	</script>
	
	<!-- 图表卡片 -->
	<div class="card">
		<ul>
			<li class="small-card card-one">
				<div class="card-box">
					<p class="card-title">各省上账期应收账款（万元）</p>	
					<div id="main4" class="card-data"></div>
				</div>
			</li>
			<li class="small-card card-two">
				<div class="card-box">
					<p class="card-title">各省发卡连接数（万个）</p>	
					<div id="main2" class="card-data"></div>
				</div>
			</li>
			<li class="small-card card-three">
				<div class="card-box">
					<p class="card-title">各省商用客户数及商机数（万个）</p>	
					<div id="main3" class="card-data"></div>
				</div>
			</li>
			<li class="small-card card-four">
				<div class="card-box">
					<p class="card-title">全国应收账款趋势（万元）</p>	
					<div id="main7" class="card-data"></div>
				</div>
			</li>
			<li class="small-card card-five">
				<div class="card-box">
					<p class="card-title">全国发卡连接数趋势（万个）</p>	
					<div id="main5" class="card-data"></div>
				</div>
			</li>
			<li class="small-card card-six">
				<div class="card-box">
					<p class="card-title">全国商用客户数趋势（万个）</p>	
					<div id="main6" class="card-data"></div>
				</div>
			</li>
		</ul>
	</div>
</div> 
<div class="footer">
	<p>Copyright&nbsp;©&nbsp;1999-2018 ChinaUnicom&nbsp;中国联通&nbsp;版权所有&nbsp;&nbsp;&nbsp;&nbsp;技术支持：中国联通研究院-大数据研究中心</p>
</div> 
<!-------------------------CONT---------------------------->  
<!-- <div class="List-cont box-cont">
	<div class="panel panel-default">
	    <div class="panel-header">
	      <h4>首页</h4>
	    </div>
		<div id="panel-body" class="panel-body">
        	搜索模块
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
            
           为 ECharts 准备一个具备大小（宽高）的 DOM
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
							    <span class="name">全国发卡连接数（万个）</span>    全国实际到达连接数
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
				  <li class="lt"><div class="data">
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
				  </li>
				  <li class="lt second"><div class="data">
				  	  <div id="main7" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
				  	  <span id ="nodata7" style="display:none">全国应收账款趋势,无数据</span>
				  </li>
				  <li class="cr second"><div class="data">
					  <div id="main5" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata5" style="display:none">全国发卡连接数趋势（万个）,无数据</span>
				  </li>
				  <li class="rt second"><div class="data">
					  <div id="main6" style="width:100%;height:260px;"><br/><br/><img src="img/codeerror.gif" /></div></div>
					  <span id ="nodata6" style="display:none">全国商用客户数趋势（个）,无数据</span>
				  </li>
				  
			</ul>
			</div>

	       </div> 
	  	 </div>                                      
        </div>       
 

 
 -->
</body>
</html>
