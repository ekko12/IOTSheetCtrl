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
	var pro;
	var city;
	$("#province").change(function(){
		$.ajax({  
	        type: "POST",  
	        url: "piechart/getCityByPro.do?pro="+$("#province").val(),   
	        data: params,
			datatype: "json",
	        success: function(data){
	        	if (data!=null){
	        		$("#city").empty();
	        		$("#city").append("<option value=\"1\">请选择</option>");
	        		var city = data.city;
        			for(x in city){
            			$("#city").append("<option value="+city[x].orgCode+">" + city[x].orgName + "</option>");  
            		}	        		    
	        	}	             
	        }  
		});    
	});
	$.ajax({
        type: "POST",  
        url: "piechart/getOrg.do",   
        data: params,
		datatype: "json",
        success: function(data){ 
        	if (data!=null){
        		flag = data.flag;
        		if(flag==1){
        			var province = data.pro;
        			for(x in province){
            			$("#province").append("<option value="+province[x].orgCode+">" + province[x].orgName + "</option>");  
            		}         		
        			$("#city2C").show();
        			$("#pro2C").show(); 	
        		}else if(flag==2){
        			pro = data.pro;
        			proCode = data.pro;
        			var city = data.city;
        			for(x in city){
            			$("#city").append("<option value="+city[x].orgCode+">" + city[x].orgName + "</option>");  
            		}
        			$("#city2C").show();
        		}else{
        			city = data.city;
        			pro = data.pro;
        			proCode = data.pro;
        			cityCode = data.city;
        			$("#city2C").hide();
        			$("#pro2C").hide();   
        		}
        		//searchList();
        		param["firstFlag"] = 0;  
        		pieDate.splice(0,pieDate.length);//清空数组 
        		page = 1; 
          		var yearVal = $("#year option:selected").val()==undefined?"":$("#year option:selected").val();
          		var monthVal = $("#month option:selected").val()==undefined?"":$("#month option:selected").val();
          		var provinceVal = $("#province option:selected").val()==undefined?"":$("#province option:selected").val();
          		var cityVal = $("#city option:selected").val()==undefined?"":$("#city option:selected").val();
          		/* console.log(yearVal+"++"+monthVal+"++"+provinceVal+"++" + cityVal); */
          		param["busAccYear"] = yearVal.trim();
          		param["busAccMonth"] = monthVal.trim(); 
          		if(proCode==0){
          	  		param["provinceCode"] = provinceVal.trim();  			
          		}
          		else{
          	  		param["provinceCode"] = proCode;    			
          		}
          		if(cityCode==0){
          			param["cityCode"] = cityVal.trim(); 			
          		}
          		else{
          			param["cityCode"] = cityCode;   			
          		}  		 
          		param["isFlag"] = flag;  
          		if(provinceVal!=1){
          			param["isFlag"] = 2;
          		}
          		if(cityVal!=1){
          			param["isFlag"] = 3;
          		}
          		getHomePgFourChart();
          		getPieChart();
          		getLineChartByConnHisTrend();
          		getActiveRateByTrend();
          		getTotalChargeRend();
          		getOrderTrend();
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
	function searchList(){
		param["firstFlag"] = 1; 
		pieDate.splice(0,pieDate.length);//清空数组 
		page = 1; 
  		var yearVal = $("#year option:selected").val()==undefined?"":$("#year option:selected").val();
  		var monthVal = $("#month option:selected").val()==undefined?"":$("#month option:selected").val();
  		var provinceVal = $("#province option:selected").val()==undefined?"":$("#province option:selected").val();
  		var cityVal = $("#city option:selected").val()==undefined?"":$("#city option:selected").val();
  		/* console.log(yearVal+"++"+monthVal+"++"+provinceVal+"++" + cityVal); */
  		param["busAccYear"] = yearVal.trim();
  		param["busAccMonth"] = monthVal.trim(); 
  		if(proCode==0){
  	  		param["provinceCode"] = provinceVal.trim();  			
  		}
  		else{
  	  		param["provinceCode"] = proCode;    			
  		}
  		if(cityCode==0){
  			param["cityCode"] = cityVal.trim(); 			
  		}
  		else{
  			param["cityCode"] = cityCode;   			
  		}  		 
  		param["isFlag"] = flag;  
  		if(provinceVal!=1){
  			param["isFlag"] = 2;
  		}
  		if(cityVal!=1){
  			param["isFlag"] = 3;
  		}
  		getHomePgFourChart();
  		getPieChart();
  		getLineChartByConnHisTrend();
  		getActiveRateByTrend();
  		getTotalChargeRend();
  		getOrderTrend();
	}
	function getHomePgFourChart() {
		$.ajax({
  			type: "POST",
  			url: "busAccSnap/getHomePgFourTb.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				$("#accountNum").html(data.datas[0].companyNumber);
  				$("#accountNumAdd").html((parseFloat(data.datas[0].companyNumRate)).toFixed(0));
  				$("#connectNum").html(data.datas[0].connections);
  				$("#connectNumAdd").html((parseFloat(data.datas[0].connectionsRate)).toFixed(0));
  			},
			error : function () {
				$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
				return false;
			}
  		});
	}
	function getPieChart(){
  		$.ajax({
  			type: "POST",
  			url: "busAccSnap/getPieChart.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (data.datas.length>0) {
  					if(data.code==200){  
  						var valueElse = 0;
  						datas = data.datas; 
  						var countElse =0;
  	  					for(var d in datas){
  	  					countElse++;
  	  						if(d<10){
	  	  						pieDate.push({
	  	  				            name: datas[d].name,
	  	  				            value: datas[d].value
	  	  				        });  
  	  						}else{
  	  							valueElse += parseFloat(datas[d].value);
  	  						}  	  												
  	  					}  
  	  					if(countElse>=10){
  	  	  					pieDate.push({
  					            name: '其他',
  					            value: valueElse
  					        });
  	  					}
  	  				echarts.dispose(document.getElementById("main2"));
  	  				var myChart2 = echarts.init(document.getElementById('main2'));
  	  			        myChart2.setOption(option);   
  	  			    $("#nodata2").css("display","none"); 
  					$("#main2").css("display","block");
  					}else{  
  						$("#main2").html("<br/><br/><img src=\"img/codeerror.gif\" />");  						
  					}
  					
  				}else{
  				//	$("#main2").html("<br/><br/>连接数占比,无数据"); 
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
	function getActiveRateByTrend(){
		var activeRate =[];
  		$.ajax({
  			type: "POST",
  			url: "busAccSnap/getActiveRateByTrend.do",
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
  	  							activeRate.push([
  	  	  				            datas[d].name.trim(),
  	  	  				        	float1
  	  	  				        ]);  						
  	  					}  
  				            option3 = {
  				            	    title : {
  				            	        text: '激活率趋势（单位：%）'
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
  				            	            data : activeRate.map(function (item) {
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
  				            	            name:'激活率',
  				            	            type:'bar',
  				            	          	barWidth : 10,//柱图宽度
  				            	            data:activeRate.map(function (item) {
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
  	  			        	myChart4.setOption(option3);  
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
	function getOrderTrend(){
		var getOrderTrend =[];
  		$.ajax({
  			type: "POST",
  			url: "busAccSnap/getOrderTrend.do",
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
  	  						float1 = parseFloat(fvalue).toFixed(2);
  	  					getOrderTrend.push([
  	  	  				            datas[d].name.trim(),
  	  	  				        	float1
  	  	  				        ]);  						
  	  					}  
  				            option5 = {
  				            	    title : {
  				            	        text: '订购情况趋势（单位：个）'
  				            	    },
  				            	    tooltip : {
  				            	        trigger: 'axis',
  				        		        formatter: "{a} <br/>{b} : {c}"
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
  				            	            name:'订购情况',
  				            	            type:'bar',
  				            	          	barWidth : 10,//柱图宽度
  				            	            data:getOrderTrend.map(function (item) {
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
  				      		echarts.dispose(document.getElementById("main6"));
  			  	  	        var myChart6 = echarts.init(document.getElementById('main6'));
  	  			        		myChart6.setOption(option5);  
  	  	  	  			    $("#nodata6").css("display","none"); 
  	    					$("#main6").css("display","block"); 
  					}else{ 
  						$("#main6").html("<br/><br/><img src=\"img/codeerror.gif\" />");				
  					}
  					
  				}else{
			//			$("#main6").html("<br/><br/>订购情况,无数据");  
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
	function getTotalChargeRend(){
		var TotalChargeRend =[];
  		$.ajax({
  			type: "POST",
  			url: "busAccSnap/getTotalChargeRend.do",
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
  	  						float1 = parseFloat(fvalue).toFixed(2);
  	  					TotalChargeRend.push([
  	  	  				            datas[d].name.trim(),
  	  	  				        	float1
  	  	  				        ]);  						
  	  					}  
  				            option4 = {
  				            	    title : {
  				            	        text: '出账收入情况趋势（单位：元）'
  				            	    },
  		  	  					    grid: {
  			  	  					    left: '6%',
  			  	  					    right: '4%',
  			  	  					    containLabel: true,
  			  	  					    y2: 10
  			  	  					    },
  				            	    tooltip : {
  				            	        trigger: 'axis',
  				        		        formatter: "{a} <br/>{b} : {c}"
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
  				            	            data : TotalChargeRend.map(function (item) {
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
  				            	            name:'出账收入',
  				            	            type:'bar',
  				            	          	barWidth : 10,//柱图宽度
  				            	            data:TotalChargeRend.map(function (item) {
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
  				      	echarts.dispose(document.getElementById("main5"));
  			  	  	        var myChart5 = echarts.init(document.getElementById('main5'));
  	  			        myChart5.setOption(option4);   
  	  	  			    $("#nodata5").css("display","none"); 
  	  					$("#main5").css("display","block"); 
  					}else{ 
  						$("#main5").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
  					}
  					
  				}else{

				//	$("#main5").html("<br/><br/>出账收入,无数据");  	 
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

	function getLineChartByConnHisTrend(){
  		$.ajax({
  			type: "POST",
  			url: "busAccSnap/getLineChartByConnHisTrend.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (data.datas.length>0) {
  					if(data.code==200){
  						var lineChartByConnHisTrend1 =[];
  	  					var lineChartByConnHisTrend2 =[];
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
  	  						if (datas[d].isForecastFlag==1) forecast=forecast+1;
  	  						if(datas[d].isForecastFlag==1&&forecastMark==0){
  	  							if(d>0)
  	  								forecastMonth1 = datas[d-1].name;
  	  							else
  	  	  							forecastMonth1 = datas[d].name;
  	  							forecastMark = 1;
  	  						}
  	  						if(datas[d].isForecastFlag==1){
  	  							forecastMonth2 = datas[d].name; 
  	  						}
  	  						lineChartByConnHisTrend1.push(
  	  				            datas[d].name
  	  				        );  
  	  						lineChartByConnHisTrend2.push(
  	  				            datas[d].value/10000
  	  				        );
 
  	  					}     	  					
  	  						var option2 = {
  	  							title: {
	  	  					            text: '连接数趋势（单位：万）'
	  	  					        },
	  	  					    grid: {
	  	  					    left: '6%',
	  	  					    right: '4%',
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
	  	  					        },   
	  	  					        dataZoom: [{
  	  	  					            startValue: startMonth
  	  	  					        }, {
  	  	  					            type: 'inside'
  	  	  					        }],
	  	  					        series: [{
	  	  					            name: '连接数',
	  	  					            type: 'line',
	  	  					            data: lineChartByConnHisTrend2,
	  	  					        
	  	  					        }]
  	  	  				        };
  	  						echarts.dispose(document.getElementById("main3"));
  			  	  	        var myChart3 = echarts.init(document.getElementById('main3'));
  	  			        myChart3.setOption(option2);  
  	  	  			    $("#nodata3").css("display","none"); 
  	  					$("#main3").css("display","block"); 
  					}else{  
  						$("#main3").html("<br/><br/><img src=\"img/codeerror.gif\" />");							
  					}
  					
  				}else{
				//		$("#main3").html("<br/><br/>连接数,无数据");   
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
                 <div class="row cl">
                      <div class="col-sm-13">
                       <label class="form-label" for="">年份：</label><div class="formControls">
                           <select class="input-text" name="year" id="year">
                               <option value="2018">2018</option> 
                               <option value="2017">2017</option>
                               <option value="2016">2016</option>
                               <option value="2015">2015</option>
                               <option value="2014">2014</option>
                           </select>
                       </div>
                     </div>
                      <div class="col-sm-13">  
                       <label class="form-label" for="">月份：</label><div class="formControls">
                           <select class="input-text" name="month" id="month">   
                               <option value="0">请选择</option>
                               <option value="1">1月</option>
                               <option value="2">2月</option>
                               <option value="3">3月</option>
                               <option value="4">4月</option>
                               <option value="5">5月</option>
                               <option value="6">6月</option>
                               <option value="7">7月</option>
                               <option value="8">8月</option>
                               <option value="9">9月</option>
                               <option value="10">10月</option>
                               <option value="11">11月</option>
                               <option value="12">12月</option> 
                           </select>
                       </div>
                     </div>
                      <div class="col-sm-13" id="pro2C" style="display:none">
                       <label class="form-label" for="">省份：</label><div class="formControls">
                           <select class="input-text" name="province" id="province">
                               <option value="1">请选择</option>  
                           </select>
                       </div>
                     </div>
                      <div class="col-sm-13" id="city2C" style="display:none">
                       <label class="form-label" for="">地市：</label><div class="formControls">
                           <select class="input-text" name="city" id="city">
                               <option value="1">请选择</option>  
                           </select>
                       </div>
                     </div> 
                 <div class="col-sm-1 text-r" >
                    <a onClick="searchList();" class="btn btn-primary ">查询</a>  
                 </div><br/><br/>
                 </div>
                </form> 
              </div>
           <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
           <div class="row cl">
           
					<div class="col-sm-12">
					
						<div class="col-sm-3">
				          <div class="small-box bg-aqua">
				            <div class="inner">
				              <p1>平台账户数</p1>
				              <p id="accountNum">loading...</p>
				            </div>
				            <div class="icon">
				              <i class="ion ion-ios-person"></i>
				            </div> 
				            
				          </div>
				        </div>
			        
				        <div class="col-sm-3"">
				          <div class="small-box bg-green">
				            <div class="inner">
				              <p1>账户数月增长</p1>
				              <p id="accountNumAdd">loading...</p>
				            </div>
				            <div class="icon">
				              <i class="ion ion-stats-bars"></i>
				            </div> 
				            
				          </div>
				        </div>
			        
						<div class="col-sm-3">
				          <div class="small-box bg-yellow">
				            <div class="inner">
				              <p1>平台连接数</p1>
				              <p id="connectNum">loading...</p>
				            </div>
				            <div class="icon">
				              <i class="ion ion-ios-calculator"></i>
				            </div> 
				            
				          </div>
				        </div> 
				                
				        <div class="col-sm-3">
				          <div class="small-box bg-red">
				            <div class="inner">
				              <p1>连接数月增长</p1>
				              <p id="connectNumAdd">loading...</p>
				            </div>
				            <div class="icon">
				               <i class="ion ion-connection-bars"></i> 
				            </div> 
				            
				          </div>
				        </div>
				        
 					</div>
 					
				  </div>
				  
				 <div class="row cl">
				  <div class="col-sm-8"><span id ="nodata2" style="display:none">连接数统计,无数据</span>
					  <div id="main2" style="width: 700px;height:300px;"><br/><br/><img src="img/codeerror.gif" /></div>
				  </div>
				  <div class="col-sm-4"><span id ="nodata3" style="display:none">连接数,无数据</span>	
				  	  <div id="main3" style="width: 300px;height:300px;"><br/><br/><img src="img/codeerror.gif" /></div>
				  </div>
			</div>
			<br/><br/>
			<div class="row cl">
				  <div class="col-sm-4" >  
					  <div id="main4" style="width:350px;height:350px;"><br/><br/><img src="img/codeerror.gif" /></div>
					  <span id ="nodata4" style="display:none;height:350px">激活率,无数据</span>
				  </div>
				  <div class="col-sm-4">
					  <div id="main5" style="width: 350px;height:350px;"><br/><br/><img src="img/codeerror.gif" /></div>
					  <span id ="nodata5" style="display:none;height:350px">出账收入情况,无数据</span>
				  </div>
				  <div class="col-sm-4">
				  	  <div id="main6" style="width: 350px;height:350px;"><br/><br/><img src="img/codeerror.gif" /></div>
				  	  <span id ="nodata6" style="display:none;height:350px">订购情况,无数据</span>
				  </div>
			</div> 
  <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例 
        
    
        // 指定图表的配置项和数据
        option = {
		    title : {
		        text: '连接数统计占比',
		        subtext: '', 
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },  
		    series : [
		        {
		            name: '连接数占比',
		            type: 'pie',
		            radius : ['45%', '80%'], 
		            //    radius : '60%', 
		            center: ['50%', '60%'], 
		            data: pieDate ,
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
//		    ,
//		    color: ['rgb(115,17,147)','rgb(20,27,84)','rgb(7,9,46)','rgb(2,2,1)','rgb(167,51,37)','rgb(160,68,53)','rgb(237,109,0)',
//					'rgb(72,14,165)','rgb(238,82,37)','rgb(216,0,15)','rgb(226,89,61)','rgb(206,108,89)','rgb(243,160,120)','rgb(239,206,172)',
//					'rgb(191,19,19)','rgb(219,114,0)','rgb(57,35,183)','rgb(183,65,135)','rgb(99,9,179)','rgb(153,135,158)','rgb(94,70,116)']
}; 
        // 使用刚指定的配置项和数据显示图表。
        
        
         
        
        
       
       
        
    </script> 
	       </div> 
	  	 </div>                                      
        </div>       
 

 

</body>
</html>
