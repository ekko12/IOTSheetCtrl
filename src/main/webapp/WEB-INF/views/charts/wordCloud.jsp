
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
  		//getHomePgFourChart();                                 
  		
  		//getPlatformBusiness();//平台商机和客户情况 getLineChartByConnHisTrend();
  		//getPlatformIncome();//平台收入分省情况 getActiveRateByTrend();
  		
  		getIncomeByDetailIndustry();
  		//getHomeRate();
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