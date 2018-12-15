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
	<title>首页全国商机数和出账客户数趋势-中国联通研究院大数据运营后台管理系统</title>
	<base href="<%=basePath1 %>" />

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/core.css">
    <link rel="stylesheet" href="js/kkpager/kkpager_blue.css">
    <link rel="stylesheet" href="js/jbox/jbox.css">
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
    <script type="text/javascript" src="js/china.js"></script>
</head>
<body style="min-height: 900px;">
	
<input type="hidden" id="roleId" />
<!-------------------------CONT---------------------------->  
<div class="List-cont box-cont">
	<div class="panel panel-default">
	    <div class="panel-header">
	      <h4>首页</h4>
	    </div>
		<div id="panel-body" class="panel-body">
     
           <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
            <span id ="nodata3" style="display:none">各省商用客户数及商机数（个）,无数据</span>
 			<div id="busiContainer" style="width:1200px;height:550px;"><br/><br/>
 				<img src="img/codeerror.gif" />
 			</div>
				  
	   </div> 
	</div>                                      
</div>   

<script type="text/javascript">
var param = {};
var displayContent = "7";
var daPingFlag = "1"
$(document).ready(function() {
	var date=new Date;
	var yearNow=date.getFullYear();
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
        		//pieDate.splice(0,pieDate.length);//清空数组 
        		page = 1; 
          		param["monthDay"] = data.date;
          		param["displayContent"] = displayContent;
          		param["daPingFlag"] = daPingFlag;
          		getPlatformBusiCust();                                            
        	}
        }  
	});    
}); 

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
		  	  					    left: '50',
		  	  					    right: '50',
		  	  					    bottom:'20',

		  	  					    },
  						 title : {
  					        text: '平台商机和客户数情况（个）',
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
		      		echarts.dispose(document.getElementById("busiContainer"));
	  	  	        var myChart3 = echarts.init(document.getElementById('busiContainer')); 
			        	myChart3.setOption(option3);  
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




</script>
    
</body>
</html>
