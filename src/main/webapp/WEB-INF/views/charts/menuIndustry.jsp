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
<body>
<div class="unicom"> 
	<div class="header">
		<span>行业</span>
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
			<div class="swiper-slide slide-1"  style="background:#31d9a4 url(./webapp2.0/img/card-bg-04.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国上账期应收账款（万元）</div>
				<div id="incomeTrend" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="incomeTrendRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#31d9a4 url(./webapp2.0/img/card-bg-04.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国上账期应收账款（万元）</div>
				<div id="connectNum" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="connectNumRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#31d9a4 url(./webapp2.0/img/card-bg-04.png) no-repeat;background-size:100% 100%; ">
				<div class="title">全国上账期应收账款（万元）</div>
				<div id="accountNum" class="shuzi"></div>			
				<div class="huanbi">环比:
					<span id="accountNumRate"></span>
				</div>
			</div>
			<div class="swiper-slide slide-1"  style="background:#31d9a4 url(./webapp2.0/img/card-bg-04.png) no-repeat;background-size:100% 100%; ">
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
	    //loop : true,//无限循环
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
	  
	  var flag =3;
	  var pieDate =[]; 
	  var proCode = 0;
	  var cityCode = 0;
	
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
		          		param["displayContent"] = displayContent;
	            		param["daPingFlag"] = daPingFlag;                                     
		          		getIncomeByDetailIndustry();
		          		getChinaMap();
		          		//getAreaTop();   
		          		getCustomAvagData();
		          		getCustomIndustryProvince();
		    	  		getCustInduProv();
		    	  		//setDisplayContent(5);
		    	  	    getIndustryTop();
				  		getHomePgFourChart();
		        	}
		             
		        }  
			});  
	  }); 
			
			var totalPage;
			var totalRecords;
			var page = 1;
			var param = {};
			var displayContent = "2";
			var daPingFlag = "1"
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
			  		getChinaMap();
			  		//getAreaTop();  
			  		getCustomAvagData();
			  		getCustomIndustryProvince();
			  		getCustInduProv();
			  		//setDisplayContent(5);
			  		getIndustryTop();
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
	  	  			    window.addEventListener("resize", function () {
			        		myChart8.resize();
			        		});
	  	  			    	//$("#nodata8").css("display","none"); 
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
       	  	  	    data: [
		  	            {
		  	                name: '后装-汽车车载电子设备',
		  	                value: 34212328,
		  	            }, {
		  	                name: '车厂及车厂推动的后装产品',
		  	                value: 20754416,
		  	            }, {
		  	                name: '自动售货机、自动售票机等',
		  	                value: 11386012,
		  	            }, {
		  	                name: '智能热表',
		  	                value: 9270083,
		  	            }, {
		  	                name: 'PAD类',
		  	                value: 7941959,
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
	  	  			    window.addEventListener("resize", function () {
			        		myChart8.resize();
			        		});
	  	  			    	//$("#nodata8").css("display","none"); 
	  						$("#main8").css("display","block");
	  			} 
	 
	  			function getAreaTop(){
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
	  			  	  				var dom = document.getElementById('main6');
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
	  				            	                }
	  		  	    					    },
	  		  	    					    yAxis: {
	  		  	    					        type: 'value',
	  		  	    					      boundaryGap:[0.5, 1]
	  		  	    					    },
		  		  	    					grid: {
		  					  	  		        left: 50,
		  					  	  		        right: 20,
		  					  	  		        top: 10,
		  					  	  		        bottom: 55,
		  				  	  		    	}, 
	  		  	    					    series: [
	  		  	    					    	{
	  		  	    					        data: yData,
	  		  	    					        type: 'line',
	  		  	    					        symbol: 'circle',
	  		  	    					        symbolSize: 10,
	  		  	    					        lineStyle: {
	  		  	    					            normal: {
	  		  	    					                color: '#ffbb28',
	  		  	    					                width: 2
	  		  	    					            }
	  		  	    					        },
	  		  	    					        label: {
	  		  	    					                normal: {
	  		  	    					                    show: true,
	  		  	    					                    position: 'bottom',
	  		  	    					                    color:'#fff'
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
	  		  	    					        	                        color:'#5e74fd',
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
/* 	  		  	    					                borderWidth: 3,
	  		  	    					                borderColor: '#39df18', */
	  		  	    					                color: '#ffcf10'
	  		  	    					            }
	  		  	    					        }
	  		  	    					    }]
	  		  	    					};
	  		 				      		echarts.dispose(document.getElementById("main10")); 
	  		 			  	  	        var myChart10 = echarts.init(document.getElementById('main10'));
	  		 	  			        	myChart10.setOption(option10);  
	  		 	  			       window.addEventListener("resize", function () {
	  					        		myChart10.resize();
	  					        		});
	  		 	  	  			    	$("#nodata10").css("display","none"); 
	  		 	  						$("#main10").css("display","block"); 
	  		 	  						xDate.splice(0,xDate.length); 
	  		 	  						yData.splice(0,yData.length);
	  		  					/* }else{ 
	  		  						$("#main5").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
	  		  					} */
	  		  					
	  		  				}else{
	  		  					//$("#nodata10").css("display","block");
	  		  					$("#main10").css("display","none");
	  		  				}
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
	  			function getCustInduProv() {  
	  				$.ajax({
	  						type: "POST",
	  						url: "piechart/getHomeSumAccuList.do",
	  						data: param,
	  						datatype: "json",
	  						success: function(data){ 
	  							var listString = "";
	  							
	  						  	for(var key in data){
	  								listString += "<tr >"; 
	  								listString += "<td >"+key+"</td>";  
	  								var infos = data[key];
	  								for(var d in infos){
	  									
	  									if (null == infos[d].value || infos[d].value.length ==0 ){
	  										listString += "<td></td>"; 
	  									}else{
	  										listString += "<td>"+(Number(infos[d].value)).toFixed(2)+"</td>"; 
	  									}
	  									
	  									if (null == infos[d].value1 || infos[d].value1.length ==0){
	  										listString += "<td></td>"; 
	  									}else{
	  										listString += "<td>"+(Number(infos[d].value1)*100).toFixed(2)+"%"+"</td>"; 
	  									}
	  									
	  									if (null == infos[d].value2 || infos[d].value2.length ==0){
	  										listString += "<td></td>"; 
	  									}else{
	  										listString += "<td>"+(Number(infos[d].value2)*100).toFixed(2)+"%"+"</td>"; 
	  									}
	  				  					
	  								}
	  								listString += "</tr>";	
	  							}     
	  							$("#custom6").html(listString); 	  		
	  						},
	  					error : function () {
	  						$("#year").innerHTML="<img src=\"img/login_bg.jpg\" height=\"300px\" width=\"400px\" />";
	  						return false;
	  					}
	  					});
	  			}
	  			//全国应收按主要行业分布（TOP10）
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
	  			  	  						/*if(displayName == "激活率"){
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
	  				  						}*/
	  				  						
	  				  					var fvalue = Number(Number(datas[d].value)/10000).toFixed(2); 
			  	  							float1 = fvalue;
	  				  						
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
	  			  	  					//$("#nodata3").css("display","block");
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
	  			  	  				        //text: 'TOP10行业',
	  			  	  				        x:'center',
	  				  					    y:'top'
	  			  	  				    },
	  			  	  				grid: {
	  		            		        left: 60,
	  		            		        right: 60,
	  		            		        bottom: 0,
	  		            		        top:20,
	  		            		    },
	  			  	  				    tooltip : {
	  			  	  				        trigger: 'item',
	  			  	  				        formatter: "{a} <br/>{b} : {c} ({d}%)"
	  			  	  				    },  
	  			  	  				    series : [
	  			  	  				        {
	  			  	  				            //name: displayName,
	  			  	  				            name: '平台应收',
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
	  		 				      	echarts.dispose(document.getElementById("main3"));
	  		 			  	  	    var myChart3 = echarts.init(document.getElementById('main3')); 
	  		 	  			        myChart3.setOption(option3);  
	  		 	  			   window.addEventListener("resize", function () {
	  				        		myChart3.resize();
	  				        		});
	  		 	    	  			//$("#nodata3").css("display","none"); 
	  		 	    				$("#main3").css("display","block"); 
	  		  					}else{ 
	  		  						$("#main3").html("<br/><br/><img src=\"img/codeerror.gif\" />");						
	  		  					}
	  		  					
	  		  				}else{
	  		  					//$("#nodata3").css("display","block");
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
	
	<!-- 图表卡片 -->
	<div class="card">
		<ul>
			<li class="small-card industry-one">
				<div class="card-box">
					<p class="card-title">全国应收按主要行业分布（TOP10）</p>	
					<div id="main3" class="card-data" style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					</div>
				</div>
			</li>
			<li class="small-card industry-two">
				<div class="card-box">
					<p class="card-title">全国应收按细分行业分布</p>	
					<div id="main8" class="card-data" style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					</div>
				</div>
			</li>
			<li class="small-card industry-three">
				<div class="card-box">
					<p class="card-title">地图</p>
					<div id="main6" class="card-data" style="top:80px">
						<div class="loader"><img src="webapp2.0/img/loader.gif"></div>
					</div>
				</div>
			</li>
			<li class="small-card industry-four">
				<div class="card-box">
					<p class="card-title">全国激活连接数按细分行业分布</p>
					<div class="card-data" style="border: 0.0625em solid #334350  ! important;top:80px">
				   <table class="table table-bordered" style="margin:0;padding:0;min-width:7000px">
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
				</div>
			</li>
			<li class="small-card industry-five">
				<div class="card-box">
					<p class="card-title">全国应收账款按细分行业分布</p>
					<div class="card-data" style="border: 0.0625em solid #334350  ! important;top:80px">
					  <table class="table table-bordered"  style="margin:0;padding:0;min-width:6000px">
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
						<tbody id="custom6">

						</tbody>
						</table>
					</div>
				</div>
			</li>
			<li class="small-card industry-six">
				<div class="card-box">
					<p class="card-title">全国各行业平均每连接流量</p>	
					<div id="main10" class="card-data" style="top:80px">
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
