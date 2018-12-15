var param = {};
var displayContent = "2";
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
          		getAreaTop();                                            
        	}
        }  
	});    
}); 

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
  	  				var dom = document.getElementById('mapContainer');
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