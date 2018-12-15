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
<body style="min-height: 900px;">
<script type="text/javascript">
var flag =2;
var pieDate =[]; 
var proCode = 0;
var cityCode = 0;
var displayContent = "${displayContent}";
var displayName = "${displayName}";
var province_ = "${pro}";
var monthDay = "${monthDay}";
$(document).ready(function() {
	var date=new Date;
	var yearNow=date.getFullYear();
	/* $("#year").empty();
	for(var i =0;i<5;i++){
		var y = yearNow-i;
		$("#year").append("<option value="+y+">" + y + "年</option>");
	} */
	$("#city2C").hide();
	$("#pro2C").hide();   
	var params = {};
	var pro;
	var city;
	loadJeDate("monthDay");
	$("#monthDay").val(monthDay);
	$("#number-"+displayContent).css("background-color","#db1316");
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
        		flag1 = data.flag;
        		if(flag1==1){
        			var province = data.pro;
        			for(x in province){
            			$("#province").append("<option value="+province[x].orgCode+">" + province[x].orgName + "</option>");  
            		}         		
        			/* $("#city2C").show();
        			$("#pro2C").show(); */
        		}/* else if(flag==2){
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
        		} */
        		$("#province").val("0"+province_);
        		var aa=$("#province option:selected").text();
        		$("#provinceName").val(aa);
        		$("#span1").html(aa+"上账期应收账款（万元）");
        		$("#span2").html(aa+"当日实际到达连接数（万个）");
        		$("#span3").html(aa+"当日连接数激活率（%）");
        		$("#span4").html(aa+"当日到达账户数（个）");
        		$("#span5").html(aa+"当日到达商用客户数（万个）");
        		$("#span6").html(aa+"本账期累计发货订单数（个）");
        		param["firstFlag"] = 0;  
        		pieDate.splice(0,pieDate.length);//清空数组 
        		page = 1; 
          		var provinceVal = $("#province option:selected").val()==undefined?"":$("#province option:selected").val();
          		var cityVal = $("#city option:selected").val()==undefined?"":$("#city option:selected").val();
          		
          		var industry = $("#industry option:selected").val()==undefined?"":$("#industry option:selected").val();
          		var customerType = $("#customerType option:selected").val()==undefined?"":$("#customerType option:selected").val();
          		var monthDay = $("#monthDay").val();
          		param["monthDay"] = monthDay.trim();
          		if(industry!=0){
          			param["industry"] = industry.trim();
          		}else{
          			param["industry"] = "";
          		}
          		if(customerType!=0){
          			param["customerType"] = customerType.trim();
          		}else{
          			param["customerType"] = "";
          		}
          		/* var monthVal = $("#month option:selected").val()==undefined?"":$("#month option:selected").val();
          		if(monthVal<10&&monthVal!=0){
          			monthVal= "0"+monthVal;
          		}
          		var dayVal = $("#day option:selected").val()==undefined?"":$("#day option:selected").val();
          		if(dayVal<10&&dayVal!=0){
          			dayVal= "0"+dayVal;
          		}
          		if(monthVal.trim()==0&&dayVal.trim()==0){
          			param["monthDay"] = monthVal.trim()+dayVal.trim(); 
          		}else if(monthVal.trim()!=0&&dayVal.trim()==0){
          			param["monthDay"] = yearNow+"-"+monthVal.trim(); 
          		}else{
          			param["monthDay"] = yearNow+"-"+monthVal.trim()+"-"+dayVal.trim(); 
          		} */
          		
          		/* if(proCode==0){
          	  		param["provinceCode"] = provinceVal.trim();  			
          		}
          		else{
          	  		param["provinceCode"] = proCode;    			
          		} */
          		param["provinceCode"] = province_.trim(); 
          		if(cityCode==0){
          			param["cityCode"] = cityVal.trim(); 			
          		}
          		else{
          			param["cityCode"] = cityCode;   			
          		}  		 
          		param["isFlag"] = flag;  
          		/* if(provinceVal!=1){
          			param["isFlag"] = 2;
          		}
          		if(cityVal!=1){
          			param["isFlag"] = 3;
          		} */
          		param["displayContent"] = displayContent;
          		getHomePgFourChart();
          		getPieChart();
          		
          		//getActiveRateByTrend();
          		getBarGraphByCity();
          		//getLineChartByConnHisTrend();
          		getLineChart();
          		//getTotalChargeRend();
          		getBarGraphByIndustry();
          		//getOrderTrend();
        	}
             
        }  
	});    
	$.ajax({
        type: "POST",  
        url: "piechart/getIndustry.do",   
        data: params,
		datatype: "json",
        success: function(data){ 
        	if (data!=null){
        		var industry = data.industry;
    			for(x in industry){
        			$("#industry").append("<option value="+industry[x].industryCode+">" + industry[x].industryName + "</option>");  
        		}         		
    			
        	}
             
        }  
	});
	
}); 
/**
 * 加载日期选择器
 * @returns
 */
function loadJeDate(id) {
    $("#" + id).jeDate({
        format: "YYYY-MM-DD", //日期格式YYYY-MM-DD hh:mm:ss
        minDate:"2018-01-01 00:00:00", //最小日期
		//maxDate:"2099-12-31 23:59:59", //最大日期
		//isinitVal:false, //是否初始化时间
		//isTime:true, //是否开启时间选择
		//isClear:true, //是否显示清空
		//festival:false, //是否显示节日
		//zIndex:999,  //弹出层的层级高度
		//marks:null, //给日期做标注
		//choosefun:function(val) {},  //选中日期后的回调
		//clearfun:function(val) {},   //清除日期后的回调
		//okfun:function(val) {}       //点击确定后的回调
		choosefun:function(val) {//选中日期后的回调
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
        okfun:function(val) {//点击确定后的回调
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
			$("#number-1").css("background-color","#db1316");
			$("#number-2").css("background-color","#999");
			$("#number-3").css("background-color","#999");
			$("#number-4").css("background-color","#999");
			$("#number-5").css("background-color","#999");
			$("#number-6").css("background-color","#999");
			
		}else if(type==2){
			displayName = "连接数";
			$("#number-2").css("background-color","#db1316");
			$("#number-1").css("background-color","#999");
			$("#number-3").css("background-color","#999");
			$("#number-4").css("background-color","#999");
			$("#number-5").css("background-color","#999");
			$("#number-6").css("background-color","#999");
		}else if(type==3){
			displayName = "激活率";
			$("#number-3").css("background-color","#db1316");
			$("#number-2").css("background-color","#999");
			$("#number-1").css("background-color","#999");
			$("#number-4").css("background-color","#999");
			$("#number-5").css("background-color","#999");
			$("#number-6").css("background-color","#999");
		}else if(type==4){
			displayName = "订购数";
			$("#number-4").css("background-color","#db1316");
			$("#number-2").css("background-color","#999");
			$("#number-3").css("background-color","#999");
			$("#number-1").css("background-color","#999");
			$("#number-5").css("background-color","#999");
			$("#number-6").css("background-color","#999");
		}else if(type==5){
			displayName = "平台应收";
			$("#number-5").css("background-color","#db1316");
			$("#number-2").css("background-color","#999");
			$("#number-3").css("background-color","#999");
			$("#number-4").css("background-color","#999");
			$("#number-1").css("background-color","#999");
			$("#number-6").css("background-color","#999");
		}else{
			displayName = "客户数";
			$("#number-6").css("background-color","#db1316");
			$("#number-2").css("background-color","#999");
			$("#number-3").css("background-color","#999");
			$("#number-4").css("background-color","#999");
			$("#number-5").css("background-color","#999");
			$("#number-1").css("background-color","#999");
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
		param["firstFlag"] = 1; 
		pieDate.splice(0,pieDate.length);//清空数组 
		page = 1; 
  		var provinceVal = $("#province option:selected").val()==undefined?"":$("#province option:selected").val();
  		var cityVal = $("#city option:selected").val()==undefined?"":$("#city option:selected").val();
  		var industry = $("#industry option:selected").val()==undefined?"":$("#industry option:selected").val();
  		var customerType = $("#customerType option:selected").val()==undefined?"":$("#customerType option:selected").val();
  		var monthDay = $("#monthDay").val();
  		param["monthDay"] = monthDay.trim();
  		if(industry!=0){
  			param["industry"] = industry.trim();
  		}else{
  			param["industry"] = "";
  		}
  		if(customerType!=0){
  			param["customerType"] = customerType.trim();
  		}else{
  			param["customerType"] = "";
  		}
  		
  		/* var monthVal = $("#month option:selected").val()==undefined?"":$("#month option:selected").val();
  		if(monthVal<10&&monthVal!=0){
  			monthVal= "0"+monthVal;
  		}
  		var dayVal = $("#day option:selected").val()==undefined?"":$("#day option:selected").val();
  		if(dayVal<10&&dayVal!=0){
  			dayVal= "0"+dayVal;
  		}
  		if(monthVal.trim()==0&&dayVal.trim()==0){
  			param["monthDay"] = monthVal.trim()+dayVal.trim(); 
  		}else if(monthVal.trim()!=0&&dayVal.trim()==0){
  			param["monthDay"] = yearNow+"-"+monthVal.trim(); 
  		}else{
  			param["monthDay"] = yearNow+"-"+monthVal.trim()+"-"+dayVal.trim(); 
  		} */
  		/* if(proCode==0){
  	  		param["provinceCode"] = provinceVal.trim();  			
  		}
  		else{
  	  		param["provinceCode"] = proCode;    			
  		} */
  		param["provinceCode"] = province_.trim(); 
  		if(cityCode==0){
  			param["cityCode"] = cityVal.trim(); 			
  		}
  		else{
  			param["cityCode"] = cityCode;   			
  		}  		 
  		param["isFlag"] = flag;  
  		/* if(provinceVal!=1){
  			param["isFlag"] = 2;
  		}
  		if(cityVal!=1){
  			param["isFlag"] = 3;
  		} */
  		param["displayContent"]=displayContent;
  		getHomePgFourChart();
  		getPieChart();
  		
  		//getActiveRateByTrend();
  		getBarGraphByCity();
  		//getLineChartByConnHisTrend();
  		getLineChart();
  		//getTotalChargeRend();
  		getBarGraphByIndustry();
  		//getOrderTrend();
	}
	function getHomePgFourChart() {
		$.ajax({
  			type: "POST",
  			url: "piechart/getHomePgFourTb.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				$("#accountNum").html(data.datas[0].accountNum);
  				$("#connectNum").html(Number(Number(data.datas[0].connectNum)/10000).toFixed(2));
  				$("#activityTrend").html(Number(data.datas[0].activityTrend).toFixed(2)+"%");
  				$("#orderTrend").html(data.datas[0].orderTrend);
  				$("#incomeTrend").html(Number(Number(data.datas[0].incomeTrend)/10000).toFixed(2));
  				$("#customerNum").html(data.datas[0].customerNumber);
  				
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
  			url: "piechart/getPieChart.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (null!=data.datas&&data.datas.length>0) {
  					if(data.code==200){  
  						var valueElse = 0;
  						datas = data.datas; 
  						var countElse =0;
  						var nullCount=0;
  	  					for(var d in datas){
  	  						if(datas[d]!=null){
  	  							var name="";
  	  							//01为测试用户
  	  							//02 为商用不计费用户
  	  							//03 为商用计费用户
  	  							if(datas[d].name=="01"){
  	  								name="测试用户";
  	  							}else if(datas[d].name=="02"){
  	  								name="商用不计费用户";
  	  							}else if(datas[d].name=="03"){
  	  								name="商用计费用户";
  	  							}else{
  	  								name="其他";
  	  							}
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
		  	  				            name: name,
		  	  				            value: float1
		  	  				        });  
	  	  						}else{
	  	  							valueElse += parseFloat(float1);
	  	  						}
  	  						}else{
  	    						nullCount++;
  	  						}
  	  						  	  												
  	  					} 
  	  					if(nullCount==datas.length){
	  	  					$("#nodata2").css("display","block");
	  						$("#main2").css("display","none");
	  						return;
  	  					}
  	  					if(countElse>=10){
  	  	  					pieDate.push({
  					            name: '其他',
  					            value: valueElse
  					        });
  	  					}
	  	  		        // 指定图表的配置项和数据
	  	  		        option = {
	  	  				    title : {
	  	  				        text: '商用账户占比',
	  	  				        subtext: '', 
	  	  				    x:'center',
  					        y:'top'
	  	  				    },
	  	  				    tooltip : {
	  	  				        trigger: 'item',
	  	  				        formatter: "{a} <br/>{b} : {c} ({d}%)"
	  	  				    },  
	  	  				    series : [
	  	  				        {
	  	  				            name: displayName,
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
	function getBarGraphByCity(){
		var activeRate =[];
  		$.ajax({
  			type: "POST",
  			url: "piechart/getBarGraphByCity.do",
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
  	  						//if(datas[d]!=null){
  	  							var value;
  	  							var name;
  	  							if(datas[d]==null){
  	  								value=0;
  	  								name="";
  	  							}else{
  	  								value=datas[d].value;
	  								name=datas[d].name;
  	  							}
	  	  						allcount= allcount+1;
	  	  						//if (datas[d].isForecastFlag==1) forecast=forecast+1;//isForecastFlag去掉
	  	  						if(displayName == "激活率"){
		  	  						var fvalue = Number(value).toFixed(2);
		  	  						float1 = fvalue;
	  	  						}else{
	  	  							//alert(displayName);
	  	  							float1 = value;
	  	  						}
		  	  					if(displayName == "平台应收"){
	  	  							var fvalue = Number(Number(datas[d].value)/10000).toFixed(2); 
	  	  							float1 = fvalue;
		  						}else{
		  							float1 = datas[d].value;
		  						}
		  							activeRate.push([
		  	  				            name.trim(),
		  	  				      		float1
		  	  				        ]); 
  	  						}
  	  						 						
  	  					//}  
  				            option3 = {
  				            	    title : {
  				            	        text: '本省TOP10地市',
  				            	      x:'center',
  		  					        y:'top'
  				            	    },
  				            	    tooltip : {
  				            	        trigger: 'axis',
  				        		        formatter: "{a} <br/>{b} : {c}"
  				            	    },  
  		  	  					    grid: {
  			  	  					    left: '6%',
  			  	  					    right: '10%',
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
  				            	            name:displayName,
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
  				      		echarts.dispose(document.getElementById("main3"));
  			  	  	        var myChart4 = echarts.init(document.getElementById('main3')); 
  	  			        	myChart4.setOption(option3);  
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
	
	function getBarGraphByIndustry(){
		var TotalChargeRend =[];
		var yName=[];
		var xValue=[];
  		$.ajax({
  			type: "POST",
  			url: "piechart/getBarGraphByIndustry.do",
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
		  							var fvalue = Number(Number(datas[d].value)/10000).toFixed(2); 
		  							float1 = fvalue;
	  						}else{
	  							float1 = datas[d].value;
	  						}
	  	  					yName.push(name);
	  	  					xValue.push(float1);
  	  					TotalChargeRend.push([
  	  	  				            name.trim(),
  	  	  				      		float1
  	  	  				        ]);  						
  	  					}
  				            	var option4 = {
  				            		    title: {
  				            		        text: '本省TOP10行业',
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
  				            		        left: '3%',
  				            		        right: '10%',
  				            		        bottom: '3%',
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
  				      	echarts.dispose(document.getElementById("main5"));
  			  	  	        var myChart5 = echarts.init(document.getElementById('main5'));
  	  			        myChart5.setOption(option4);   
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

	function getLineChart(){
  		$.ajax({
  			type: "POST",
  			url: "piechart/getLineChart.do",
  			data: param,
  			datatype: "json",
  			success: function(data){
  				if (null!=data.datas&&data.datas.length>0) {
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
  	  						//if (datas[d].isForecastFlag==1) forecast=forecast+1;//isForecastFlag去掉
  	  						var value;
							var name;
							if(datas[d]==null){
								value=0;
								name="";
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
		  							var fvalue = Number(Number(datas[d].value)/10000).toFixed(2); 
		  							float1 = fvalue;
	  						}else{
	  							float1 = datas[d].value;
	  						}
  	  						if(datas[d].isForecastFlag==1&&forecastMark==0){
  	  							if(d>0)
  	  								forecastMonth1 = datas[d-1].name;
  	  							else
  	  	  							forecastMonth1 = datas[d].name;
  	  							forecastMark = 1;
  	  						}
  	  						if(datas[d].isForecastFlag==1){
  	  							forecastMonth2 = name; 
  	  						}
  	  						lineChartByConnHisTrend1.push(
  	  				            name
  	  				        );  
  	  						lineChartByConnHisTrend2.push(
  	  							float1
  	  				        );
 
  	  					}     	  					
  	  						var option2 = {
  	  							title: {
	  	  					            text: '近一月变化趋势',
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
	  	  					            name: displayName,
	  	  					            type: 'line',
	  	  					            data: lineChartByConnHisTrend2,
	  	  					        
	  	  					        }]
  	  	  				        };
  	  						echarts.dispose(document.getElementById("main4"));
  			  	  	        var myChart3 = echarts.init(document.getElementById('main4'));
  	  			        myChart3.setOption(option2);  
  	  	  			    $("#nodata4").css("display","none"); 
  	  					$("#main4").css("display","block"); 
  					}else{  
  						$("#main4").html("<br/><br/><img src=\"img/codeerror.gif\" />");							
  					}
  					
  				}else{
				//		$("#main3").html("<br/><br/>连接数,无数据");   
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
	//add in 20180502
	function selectMonth(str)   //月发生变化时日期联动     
	{  
		var yearvalue = 2018;     
		if (yearvalue == "")  
		{   
			var e = document.getElementById("day");   
			optionsClear(e);  
			return;  
		}
		MonHead = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var n = MonHead[str - 1];     
		if (  str ==2 && IsPinYear(yearvalue)  )   
			n++;     
		writeDay(n);    
	}
   function writeDay(n)   //据条件写日期的下拉框     
   {     
       var e = document.getElementById("day"); 
       optionsClear(e);     
       for (var i=1; i<(n+1); i++)     
           e.options.add(new Option(" "+ i + " 日", i));     
   }
   function IsPinYear(year)//判断是否闰平年     
   {       
       return(  0 == year%4 && ( year%100 !=0 || year%400 == 0 )  );  
   } 
   function optionsClear(e)   
   {   
       e.options.length = 1;   
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
            <div class="search-form">
            	<form id="searchForm">
                 <div class="row cl">
                      <div class="col-sm-13" style="display:none">
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
                      <!--  <div class="col-sm-13">  
                       <label class="form-label" for="">月份：</label><div class="formControls">
                           <select class="input-text" name="month" id="month" onchange="selectMonth(this.value)">   
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
                     <div class="col-sm-13">  
                       <label class="form-label" for="">日期：</label><div class="formControls">
                           <select class="input-text" name="day" id="day">   
                               <option value="0">请选择</option>
                           </select>
                       </div>
                     </div>  -->
                     <div class="form-group cl clclclcl">
								 <input type="text"  id="provinceName" name="provinceName"  readonly style="width:100px;float:left;border:none;text-align:left;">
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
					</div>
                    <div class="col-sm-13" id="pro2C" style="display:none;margin-top:10px;">
                       <label class="form-label" for="">省份：</label><div class="formControls">
                           <select class="input-text" name="province" id="province">
                               <option value="1">请选择</option>  
                           </select>
                       </div>
                     </div>
                      <div class="col-sm-13" id="city2C" style="display:none;margin-top:10px;">
                       <label class="form-label" for="">地市：</label><div class="formControls">
                           <select class="input-text" name="city" id="city">
                               <option value="1">请选择</option>  
                           </select>
                       </div>
                     </div> 
                     <div class="col-sm-13" id="indus" style="display:none;margin-top:10px;">
                       <label class="form-label" for="">行业：</label><div class="formControls">
                           <select class="input-text" name="industry" id="industry">
                               <option value="0">请选择</option>  
                           </select>
                       </div>
                     </div>
                     <div class="col-sm-13" id="customer" style="display:none;margin-top:10px;">
                       <label class="form-label" for="">客户类型：</label><div class="formControls">
                           <select class="input-text" name="customerType" id="customerType">
                               <option value="0">请选择</option>
                               <option value="01">测试客户</option>
                               <option value="02">商用不计费客户</option>  
                               <option value="03">商用计费客户</option>
                           </select>
                       </div>
                     </div>
                 <div class="col-sm-1 text-r" style="display:none;margin-top:10px;">
                    <a onClick="searchList();" class="btn btn-primary ">查询</a>  
                 </div><br/><br/>
                 </div>
                </form> 
              </div>
           <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
           <div class="row cl">
           
					<div class="col-sm-12 col-box">
						<div class="number-box number-1" id = "number-5" onclick="setDisplayContent(5);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-05.svg">
				            </div>
				            <div class="right">
								<span class="name" id="span1">省份上账期应收账款（万元）</span>
							  <p id="incomeTrend" class="number">loading...</p>
				            </div>
				        </div>
				        <div class="number-box number-2" id = "number-2" onclick="setDisplayContent(2);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-02.svg">
				            </div>
				            <div class="right">
							  <span class="name" id="span2">省份发卡连接数（万个）</span>
							  <p id="connectNum" class="number">loading...</p>
							</div> 
				        </div>
				        <div class="number-box number-3" id = "number-3" onclick="setDisplayContent(3);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-03.svg">
				            </div>
				            <div class="right">
							  <span class="name" id="span3">省份连接数激活率（%）</span>
							  <p id="activityTrend" class="number">loading...</p>
				            </div>
				        </div>
				        <div class="number-box number-4" id = "number-1" onclick="setDisplayContent(1);">
				            <div class="ico">
				              <img src="img/number-ico/number-ico-01.svg">
				            </div>
				            <div class="right">
							  <span class="name" id="span4">省份总账户数（个）</span>
							  <p id="accountNum" class="number">loading...</p>
				            </div>
				        </div>
				        <div class="number-box number-5" id = "number-6" onclick="setDisplayContent(6);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-06.svg">
				            </div>
				            <div class="right">
				              <span class="name" id="span5">省份商用客户数（个）</span>
							  <p id="customerNum" class="number">loading...</p>
							</div> 
				        </div>
				        <div class="number-box number-6" id = "number-4" onclick="setDisplayContent(4);">
				            <div  class="ico">
				              <img src="img/number-ico/number-ico-04.svg">
				            </div>
				            <div class="right">
								<span class="name" id="span6">省份本账期累计发货订单数（个）</span>
							  <p id="orderTrend" class="number">loading...</p>
				            </div>
				        </div>
   				        
				        
 					</div>
 					
				  </div>
			<div class="col-sm-12 col-box-2">
			      <ul>
				      <li class="lt">
						  <span id ="nodata3" style="display:none">本省TOP10地市,无数据</span>	
				  	  	  <div id="main3" class="data"><br/><br/><img src="img/codeerror.gif" /></div>
					  </li>
				      <li class="cr">
				      	  <span id ="nodata5" style="display:none;height:350px">本省TOP10行业,无数据</span>
						  <div id="main5" class="data"><br/><br/><img src="img/codeerror.gif" /></div>
					  </li>
				      <li class="rt">
					  	  <span id ="nodata2" style="display:none">商用账户占比,无数据</span>
					  	  <div id="main2" class="data"><br/><br/><img src="img/codeerror.gif" /></div>
					  </li>
					  <li class="bt">
					  	  <span id ="nodata4" style="display:none;height:350px">近一月变化趋势,无数据</span>
						  <div id="main4" class="data"><br/><br/><img src="img/codeerror.gif" /></div>
					  </li>
			      </ul>
              </div>
	       </div> 
	  	 </div>                                      
        </div>       
</body>
</html>
