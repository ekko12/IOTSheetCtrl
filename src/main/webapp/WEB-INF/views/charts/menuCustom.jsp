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
	<script type="text/javascript" src="js/echarts.min.js"></script>
    <script type="text/javascript" src="js/echarts-worldCloud.js"></script>
    <script type="text/javascript" src="js/china.js"></script>
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
				param["displayContent"] = displayContent;
				param["daPingFlag"] = daPingFlag; 
        		getHomePgFourChart();
        		getChinaMap();
        		getPlatformBusiness();
        		getPlatformBusiCust();
        		getCustomAccountByType();
        		getCustomARPU();
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
var displayContent = "2";
var daPingFlag = "1";
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
		getChinaMap();
		getPlatformBusiness();
		getPlatformBusiCust();
		getCustomAccountByType();
		getCustomARPU();
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
//全国各省商机数和出账客户数
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
	  					    	top:80,
	  					    	left: 50,
	  					    	right: 50,
	  					    	bottom:55,
	  					    },
  						 title : {
  					        //text: '各省商用客户数及商机数（个）',
  					        x:'left',
  					        y:'top'
  					    },
  					  tooltip : {
	  	  			        trigger: 'axis',
	  	  			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	  	  			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	  	  			        }
	  	  			    },

  					  legend: {
  			        	left:'right',
  			        	itemWidth: 10,
  			            itemHeight: 10,
  			            itemGap: 10,
  			          	padding:[18, 0, 15, 20] ,
  				        data:['客户数','商机数','转化率'],
  			            textStyle: {
  			            	fontSize:12,
  			            	//color:'#777'
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
  					            data : xName,
  					          axisLabel:{ 
  	                          	show:true,
  	                          	formatter:function(value)  
  	                             {  
  	                                 return value.split("").join("\n");  
  	                             },
  	                          	interval:0,            	            
  	  	                	},
  					        }, 
  					    ],
  					    yAxis : [
  					        {
  					            type : 'value',
  					        },
  					      {
  					            type : 'value',
  					            min: 0,
  				                max: 200,
  				                interval: 100,
  					            axisLabel: {
  					                   formatter: '{value} %'
  					           }
  					        }
  					        
  					    ],
  					    series : [
  					        /* {
  					            name:'客户数',
  					            type:'bar',
  					            data:customerNum,
  					           /* markPoint : {
  					                data : [
  					                    {type : 'max', name: '最大值'}
  					                    
  					                ]
  					            },*/
  					            /* markLine : {
  					                data : [
  					                    /* {type : 'average', name: '平均值'} 
  					                ]
  					            }
  					        }, */ 
  					      {
  					        	name:'客户数',
	  	                               type:'bar',
	  	                             data:customerNum,
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
  					        /* {
  					            name:'商机数',
  					            type:'bar',
  					            data:platformNum,
  					          /*  markPoint : {
  					                data : [
  					                    {type : 'max', name: '最大值'}
  					                    
  					                ]
  					            },
  					            markLine : {
  					                data : [
  					                   /*  {type : 'average', name : '平均值'} 
  					                ]
  					            }
  					        }, */
  					      {
  					        	name:'商机数',
					            type: 'bar',
					            stack: '总量',
					            data:platformNum,
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
	  	                                        barBorderRadius:[5, 5, 0, 0],
	  	                                    },
	  	                               normal: {
	  	                                barBorderRadius:[5, 5, 0, 0],
	  	                                 color: new echarts.graphic.LinearGradient(
	  	                                   0, 0, 0, 1,
	  	                                 [
	  	                                	{offset: 1, color: '#ff7927'},   
	  	  		                        	{offset: 0, color: '#ffbb28'} 
	  	                                  
	  	                                 ]
	  	                              )
	  	                         },
	  	                         emphasis: {
	  	                           color: new echarts.graphic.LinearGradient(
	  	                                 0, 0, 0, 1,
	  	                                [
	  	                                	{offset: 1, color: '#ff7927'},   
	  	  		                        	{offset: 0, color: '#ffbb28'} 
	  	                                ]
	  	                           )
	  	                          }
	  	                      }
					        },
  					      {
  				            name:'转化率',
  				            type:'line',
  				            yAxisIndex: 1,
  				            data:conversionRate,
  				          itemStyle: {
	                               normal: {
	                            	   color: '#39df18'
	                         	},
	                      }
  				        }
  					    ]
		            };
		      		echarts.dispose(document.getElementById("main3"));
	  	  	        var myChart3 = echarts.init(document.getElementById('main3')); 
			        	myChart3.setOption(option3); 
			        	window.addEventListener("resize", function () {
			        		myChart3.resize();
			        		});
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
//  地图

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
		  	  		                name: '地图', 
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
		  		      window.addEventListener("resize", function () {
			        		myChart6.resize();
			        		});
		  				//$("#nodata6").css("display","none"); 
		  				$("#main6").css("display","block");
		  				myChart6.on('click', function (params) {
		  			      	showMapDataInfo(params.data.code,params.data.name); 
		  			      	
		  			    }); 
					}else{ 
						$("#main6").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
					}
					
				}else{
					//$("#nodata6").css("display","block");
					$("#main6").css("display","none");
				}
			},
			error : function () {
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
			}
		});
	}
	  			
	  			function showMapDataInfo(zoneLocal,zoneName){
	  				var monthDay = $("#monthDay").val();
	  				//省份传值
	  				window.location.href= "piechart/toProPage.do?monthDay="+monthDay+"&pro="+zoneLocal+"&provinceName="+zoneName;
	  			}
	  			function getPlatformBusiCust(){//平台商机和客户情况
	  				var xName=[];
	  				var customerNum=[];//客户数 value
	  				var platformNum=[];//商机数 value1
	  					$.ajax({
	  						type: "POST",
	  						url: "piechart/getPlatformBusiCust.do",
	  						data: param,
	  						datatype: "json",
	  						success: function(data){
	  							if (data.datas.length>0) {
	  								if(data.code==200){
	  									datas = data.datas; 
	  				  					for(var d in datas){
	  				  						var temp = datas[d].name;
	  				  						temp = (temp.substring(4,6)).replace('0','');
	  				  	  					xName.push(temp+"月");
	  				  	  					customerNum.push(datas[d].value);
	  				  	  					platformNum.push(datas[d].value1);
	  				  					}   
	  					            option3 = {
	  					            		grid: {
	  					            				top:'80',
	  					  	  					    left: '50',
	  					  	  					    right: '50',
	  					  	  					    bottom:'20',

	  					  	  					    },
	  			  						 title : {
	  			  					        //text: '平台商机和客户数情况（个）',
	  			  					        x:'left',
	  			  					        y:'top'
	  			  					    },
		  			  					tooltip : {
					  	  			        trigger: 'axis',
					  	  			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					  	  			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
					  	  			        }
					  	  			    },

	  			  					  legend: {
	  			  			        	left:'right',
	  			  			        	itemWidth: 10,
	  			  			            itemHeight: 10,
	  			  			            itemGap: 10,
	  			  			        	padding:[18, 0, 15, 20] ,
	  			  				        data:['客户数','商机数'],
	  			  			            textStyle: {
	  			  			            	fontSize:12,
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
	  			  					            data : xName,
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
	  			  					            type : 'value'
	  			  					        }
	  			  					    ],
	  			  					    series : [
	  			  					    /* {
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
	  			  					        }, */
	  			  					    {
	  			  					        name:'客户数',
  			  					            type:'bar',
  			  					            data:customerNum,
  			  					        	barMaxWidth: 6,
											color:'#fff',
											markPoint : {
  			  					                data : [
  			  					                   /*  {type : 'max', name: '最大值'} */
  			  					                    /* ,
  			  					                    {type : 'min', name: '最小值'} */
  			  					                ]
  			  					            },
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
	  				  	              /*  {
	  			  					            name:'商机数',
	  			  					            type:'bar',
	  			  					            data:platformNum,
	  			  					            markPoint : {
	  			  					                data : [
	  			  					                    {type : 'max', name: '最大值'}
	  			  					                    ,
	  			  					                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3} 
	  			  					                ]
	  			  					            },
	  			  					            markLine : {
	  			  					                data : [
	  			  					                    {type : 'average', name : '平均值'} 
	  			  					                ]
	  			  					            }
	  			  					        }*/
	  				  	              {
	  				  	            	name:'商机数',
	  						            type: 'bar',
	  						            stack: '总量',
	  						            data:platformNum,
	  						          	barMaxWidth: 6,
	  						          	markPoint : {
		  					                data : [
		  					                    /* {type : 'max', name: '最大值'} */
		  					                    /* ,
		  					                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3} */
		  					                ]
		  					            },
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
	  		  	                                	{offset: 1, color: '#ff7927'},   
	  		  	                                	{offset: 0, color: '#ffbb28'}
	  		  	                                  
	  		  	                                 ]
	  		  	                              )
	  		  	                         },
	  		  	                         emphasis: {
	  		  	                           color: new echarts.graphic.LinearGradient(
	  		  	                                 0, 0, 0, 1,
	  		  	                                [
	  		  	                                	{offset: 1, color: '#ff7927'},   
	  		  	                            		{offset: 0, color: '#ffbb28'}
	  		  	                                ]
	  		  	                           )
	  		  	                          }
	  		  	                      }
	  						        },
	  			  					    ]
	  					            };
	  					      		echarts.dispose(document.getElementById("busiContainer"));
	  				  	  	        var myChart3 = echarts.init(document.getElementById('busiContainer')); 
	  						        	myChart3.setOption(option3);  
	  						        	window.addEventListener("resize", function () {
	  		  				        		myChart3.resize();
	  		  				        		});
	  				  			    $("#nodata3").css("display","none"); 
	  								$("#busiContainer").css("display","block"); 
	  								}else{ 
	  									$("#busiContainer").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
	  								}
	  								
	  							}else{
	  								$("#nodata3").css("display","block");
	  								$("#busiContainer").css("display","none");
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
  			  			        	left:'right',
  			  			        	itemWidth: 10,
  			  			            itemHeight: 10,
  			  			            itemGap: 10,
  			  			        	padding:[18, 0, 15, 20] ,
  			  			        	data: ['测试账户数', '商用不计费账户数','商用计费账户数'],
  			  			            textStyle: {
  			  			            	fontSize:12,
  			  			         }
  			  			        },
	  		  	  				grid: {
			            				top:'80',
			  	  					    left: '50',
			  	  					    right: '40',
			  	  					    bottom:'55',

			  	  					    },
	  		  	  				    xAxis:  { 	
	  		  	  				    	name:'省份',
	  		  	  				        type: 'category',
	  		  	  				        data: xName,
			  		  	  				  axisLabel:{ 
			    	                          	show:true,
			    	                          	formatter:function(value)  
			    	                             {  
			    	                                 return value.split("").join("\n");  
			    	                             },
			    	                          	interval:0,            	            
			    	  	                	},
	  		  	  				    },
	  		  	  				    yAxis: {
	  		  	  				  		name:'账户数',
	  		  	  				        type: 'value',
	  		  	  				      	min: 0,
	  		  	  				    },
	  		  	  				    series: [
	  		  	  				  		{
	  		  	  				      	name: '测试账户数',
		  	  				            type: 'bar',
		  	  				            stack: '总量',
		  	  				            data: customerNum1,
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
	  			  	                                	{offset: 1, color: '#ff7927'},   
	  			  	  		                        	{offset: 0, color: '#ffbb28'} 
	  			  	                                  
	  			  	                                 ]
	  			  	                              )
	  			  	                         },
	  			  	                         emphasis: {
	  			  	                           color: new echarts.graphic.LinearGradient(
	  			  	                                 0, 0, 0, 1,
	  			  	                                [
	  			  	                                	{offset: 1, color: '#ff7927'},   
	  			  	  		                        	{offset: 0, color: '#ffbb28'} 
	  			  	                                ]
	  			  	                           )
	  			  	                          }
	  			  	                      }
	  							        },
	  		  	  				       
	  		  	  				  			{
	  		  	  				      		name: '商用不计费账户数',
		  	  				            	type: 'bar',
		  	  				            	stack: '总量',
			  	  				            data: customerNum2,
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
	  		  	  				            name: '商用计费账户数',
	  		  	  				            type: 'bar',
	  		  	  				            stack: '总量',
	  		  	  				      		barMaxWidth: 6,
	  		  	  				            label: {
	  		  	  				                normal: {
	  		  	  				                    show: false,
	  		  	  				                    position: 'insideRight'
	  		  	  				                }
	  		  	  				            },
	  		  	  				            data: customerNum3,
	  		  	  				      		itemStyle: {
			  	                              	emphasis: {
			  	                                        barBorderRadius:[1, 0, 0, 0],
			  	                                    },
			  	                               normal: {
			  	                                barBorderRadius:[0, 0, 0, 0],
			  	                                 color: new echarts.graphic.LinearGradient(
			  	                                   0, 0, 0, 1,
			  	                                 [
			  	                                	{offset: 0, color: '#93ff7e'}, 
			  	                                	{offset: 1, color: '#39df18'},
			  	                                  
			  	                                 ]
			  	                              )
			  	                         },
			  	                         emphasis: {
			  	                           color: new echarts.graphic.LinearGradient(
			  	                                 0, 0, 0, 1,
			  	                                [
			  	                                	{offset: 0, color: '#93ff7e'}, 
			  	                                	{offset: 1, color: '#39df18'},
			  	                                ]
			  	                           )
			  	                          }
			  	                      }
	  		  	  				        }
	  		  	  				    ]
	  		  	  				};
	  		  				      		echarts.dispose(document.getElementById("main1"));
	  		  			  	  	        var myChart1 = echarts.init(document.getElementById('main1')); 
	  		  	  			        	myChart1.setOption(option1);  
	  		  	  			      window.addEventListener("resize", function () {
		  				        		myChart1.resize();
		  				        		});
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
	  		 				        		        //text: '全国每连接收入分布(万)',
	  		 				        		       	//subtext: '横坐标是ARPU，纵坐标是相同ARPU值的个数'
	  		 				        		    },
	  		 				        		 legend: {
	  		  			  			        	left:'right',
	  		  			  			        	itemWidth: 10,
	  		  			  			            itemHeight: 10,
	  		  			  			            itemGap: 10,
	  		  			  			        	padding:[18, 0, 15, 20] ,
	  		  			  				        data:['个数','ARPU'],
	  		  			  			            textStyle: {
	  		  			  			            	fontSize:12,
	  		  			  			         }
	  		  			  			        },
	  		 				        		 grid: {
	  					            				top:'80',
	  					  	  					    left: '50',
	  					  	  					    right: '40',
	  					  	  					    bottom:'20',

	  					  	  					    },
	  					  	  					tooltip : {
	  						  	  			        trigger: 'axis',
	  						  	  			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	  						  	  			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	  						  	  			        }
	  						  	  			    },
	  		 				        		    xAxis: {
	  		 				        		    	name:'个数',
	  		 				        		        data: xDate,
	  		 				        		        silent: false,
	  		 				        		        splitLine: {
	  		 				        		            show: false
	  		 				        		        }
	  		 				        		    },
	  		 				        		    yAxis: {
	  		 				        		    	name:'ARPU',
	  		 				        		    	axisLabel: {
	  				  	  		                    	formatter: '{value} '
	  				  	  		                	}
	  		 				        		    },
	  		 				        		    series: [
	  		 				        		 {
	  		  				  	            	name:'商机数',
	  		  						            type: 'bar',
	  		  						            stack: '总量',
	  		  						        	data: yData,
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
	  		 				      		echarts.dispose(document.getElementById("main5")); 
	  		 			  	  	        var myChart5 = echarts.init(document.getElementById('main5'));
	  		 	  			        	myChart5.setOption(option5);   
	  		 	  			       window.addEventListener("resize", function () {
		  				        		myChart5.resize();
		  				        		});
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
</script>
<body>
<div class="unicom"> 
	<div class="header">
		<span>客户</span>
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
			<div class="swiper-slide slide-1"  style="background:#8f83ff url(./webapp2.0/img/card-bg-02.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国上账期应收账款（万元）</div>
				<div id="incomeTrend" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="incomeTrendRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#8f83ff url(./webapp2.0/img/card-bg-02.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国上账期应收账款（万元）</div>
				<div id="connectNum" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="connectNumRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#8f83ff url(./webapp2.0/img/card-bg-02.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国上账期应收账款（万元）</div>
				<div id="accountNum" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="accountNumRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#8f83ff url(./webapp2.0/img/card-bg-02.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国上账期应收账款（万元）</div>
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
	  var swiper = new Swiper('.swiper-container', {
	//    loop : true,//无限循环
	    slidesPerView: 4,
	    spaceBetween: 15,
	   /*  autoplay: {
	       delay: 3000,
	       disableOnInteraction: false,
	     }, */
	    pagination: {
	      el: '.swiper-pagination',
	      clickable: true,
	    },
	  });
	</script>
	
	<!-- 图表卡片 -->
	<div class="card">
		<ul>
			<li class="small-card custom-one">
				<div class="card-box">
					<p class="card-title">全国各省商机数和出账客户数（个）</p>	
					<div id="main3" class="card-data">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					</div>
				</div>
			</li>
			<li class="small-card custom-two">
				<div class="card-box">
					<p class="card-title">地图</p>	
					<div id="main6" class="card-data" style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					</div>
				</div>
			</li>
			<li class="small-card custom-three">
				<div class="card-box">
					<p class="card-title">平台商机和客户数情况（个）</p>
					<div id="busiContainer" class="card-data">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					</div>
				</div>
			</li>
			<li class="small-card custom-four">
				<div class="card-box">
					<p class="card-title">全国每连接收入分布</p>
					<div id="main5" class="card-data">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					</div>
				</div>
			</li>
			<li class="small-card custom-five">
				<div class="card-box">
					<p class="card-title">全国各省商机商用计费、商用不计费、测试账户数（个）</p>
					<div id="main1" class="card-data">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
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
