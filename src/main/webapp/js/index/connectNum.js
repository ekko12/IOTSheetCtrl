var param = {};

$(document).ready(function() {
	var date=new Date;
	var yearNow=date.getFullYear();
	var params = {};

	getConNumActivityTrend();  
}); 

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
  	  		        
  	  			option = {
	  	  		        	title:{
		  	  		        	//text: '各省发卡连接数（万个）',
	  					        x:'left',
	  					        y:'top'
	  	  		        	},
	  	  		        	grid:{
			                	top:60,//距上边距
			                  	left:60,//距离左边距
				               	right:60,//距离右边距
				               	bottom:60,//距离下边距
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
		  			        	itemWidth: 20,
		  			            itemHeight: 10,
		  			            itemGap: 3,
		  			          	data:['连接数(万)','激活率'],
		  			            textStyle: {
		  			            	fontSize:12,
		  			            	color:'#b6bcff'
		  			         	}
		  	  		        },
		  	  		        
		  	  		        xAxis: [
		  	  		            {
		  	  		                type: 'category',
		  	  		                data: xName,
		  	  		                axisPointer: {
		  	  		                    type: 'shadow'
		  	  		                },
		  	  		            axisLine:{
            	                	lineStyle:{
            	                		color:"#b6bcff"
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
            	                		 color:"#b6bcff"
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
        	                		color:"#b6bcff"
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
		        	                		color:"#b6bcff"
		        	                	}
		        	                },
		  	  		            }
		  	  		        ],
		  	  		    series : [
					          //柱一
					            {
					            	name:'连接数(万)',
					                type:'bar', 
					                barWidth: 5,
					                color:'#fff',
					                data:conNum,
					                itemStyle: {
					                	emphasis: {
				                            barBorderRadius:[5, 5, 0, 0],
				                        },
					                  normal: {
					                	  barBorderRadius:[5, 5, 0, 0],
					                    color: new echarts.graphic.LinearGradient(
					                      0, 0, 0, 1,
					                    [
					                    	{offset: 1, color: '#ffe897'}, 
					                    	{offset: 0, color: '#ffc000'}, 
					                     
					                    ]
					                 )
					            },
					            emphasis: {
					              color: new echarts.graphic.LinearGradient(
					                    0, 0, 0, 1,
					                   [
					                	   {offset: 1, color: '#ffe897'}, 
					                    	{offset: 0, color: '#ffc000'},
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
	  	  		            itemStyle: {
	  	  		            normal: {
	  	  		            	color: "#06ff00",//折线点的颜色
	  	  		            	lineStyle: {
	  	  		            		color: "#06ff00"//折线的颜色
	  	  		            	},
	  	  		           }
	  	  		           },
		  	  		       
					    }
				],
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