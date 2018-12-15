/**
 * 重写(扩展)easyui中bug方法
 * 
 * @author 舒少雄
 */
$(function(){
	// datagrid控件删除后,后面的<tr>中id属性值没有重置
	$.extend($.fn.datagrid.defaults.view, {
        deleteRow: function(target, index) {
            var opts = $.data(target, "datagrid").options;
            var data = $.data(target, "datagrid").data;
            opts.finder.getTr(target, index).remove();
            var gd = $.data(target, "datagrid");
            for (var i = index + 1; i < data.rows.length; i++) {
                opts.finder.getTr(target, i, "body", 2).attr("datagrid-row-index", i - 1)
                .attr("id",gd.rowIdPrefix+"-2-"+(i-1));
                var tr1 = opts.finder.getTr(target, i, "body", 1).attr("datagrid-row-index", i - 1)
                .attr("id",gd.rowIdPrefix+"-1-"+(i-1));
                if (opts.rownumbers) {
                    tr1.find("div.datagrid-cell-rownumber").html(i);
                }
            }
            data.total -= 1;
            data.rows.splice(index, 1);
        }
	});
	
	// datagrid中editors增加datetimebox
	$.extend($.fn.datagrid.defaults.editors, {
		datetimebox: {//datetimebox就是你要自定义editor的名称
			init: function(container, options){
				var input = $('<input type="text">').appendTo(container);
				// 格式化
				options.formatter = function(data) {
					return new Date(data).format("yyyy-MM-dd hh:mm:ss");
				};
				return input.datetimebox(options);
			},
			destroy:function(target){
				$(target).datetimebox("destroy");
			},
			getValue:function(target){
				return $(target).parent().find('input.combo-value').val();
			},
			setValue:function(target,value){
				$(target).datetimebox("setValue",value);
			},
			resize:function(target,width){
				var input = $(target);
				if ($.boxModel == true){
					input.width(width - (input.outerWidth() - input.width()));
	            } else {
	            	input.width(width);
	            }
			}
		}
	});
	
	/*// validatebox方法扩展
	$.extend($.fn.validatebox.methods, {
		// 移除验证
		removeValida: function (jq, newposition) {
	        return jq.each(function () {
	        	alert($(this).data().validatebox.options);
	        	$(this).data().validatebox.options.validtype = "";
	            $(this).removeClass("easyui-validatebox validatebox-invalid")
	            		.removeClass("validatebox-text validatebox-invalid")
	            		.removeClass("validatebox-invalid")
	            		.removeClass("validatebox-invalid");
	        });
	    },
	    
	    // 还原验证
	    reduceValida: function (jq, newposition) {
	        return jq.each(function () {
	            var opt = $(this).data().validatebox.options;
	            $(this).addClass("validatebox-text").validatebox(opt);
	        });
	    }
	});
	
	$.extend($.fn.validatebox.methods, {
	    remove: function (jq, newposition) {
	        return jq.each(function () {
	            $(this).removeClass("validatebox-text validatebox-invalid").unbind('focus').unbind('blur');
	        });
	    },

	    reduce: function (jq, newposition) {
	        return jq.each(function () {
	            var opt = $(this).data().validatebox.options;
	            $(this).addClass("validatebox-text").validatebox(opt);
	        });
	    }
	});*/
	
	/* 关闭panel时关闭其中的iframe，回收内存 */
	$.fn.panel.defaults.onBeforeDestroy = function() {
		var frame = $('iframe', this);
		if (frame.length > 0) {
			frame[0].contentWindow.document.write('');
			frame[0].contentWindow.close();
			frame.remove();
			if ($.browser.msie) {
				CollectGarbage();
			}
		}
	};
	/**获取选中的节点与子节点的ID集合 param 为数组(指定节点数组)或对象(指定节点对象)   为boolean时 ，true为获取getChecked节点 false或为空时 获取getSelected节点**/
	$.extend($.fn.tree.methods, {
		getNodeAndChildId:function(jq,param){
		    	var $nodes;
		    	if(param){
		    	    var type=$.type(param);
		    	    if(type=='object'){$nodes=[param];}
		    	    else if(type=='array'){$nodes=param;}
		    	    else{
		    		$nodes=$(jq).tree('getChecked');
		    	    }
		    	}else{
		    	    $nodes=$(jq).tree('getSelected');
		    	}
		    	if(!$nodes){return null;}
				var array=[],data=$.type($nodes)=='object'?[$nodes]:$nodes;
				for(var i=0;i<data.length;i++){
					array.push(data[i].id);
					var $childNodes=$(jq).tree('getChildren',data[i].target);
					if(!$childNodes){break;}
					for(var j=0;j<$childNodes.length;j++){
					    array.push($childNodes[j].id);
					}
				}
				return array;
		}
	});
});

// 时间格式化
Date.prototype.format = function (format) {
    /**
     * eg:format="yyyy-MM-dd hh:mm:ss";
     */
	if (!format) {
		format = "yyyy-MM-dd hh:mm:ss";
    }
	
    var o = {
    		"M+": this.getMonth() + 1, // month
            "d+": this.getDate(), // day
            "h+": this.getHours(), // hour
            "m+": this.getMinutes(), // minute
            "s+": this.getSeconds(), // second
            "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
            "S": this.getMilliseconds()
    };
    
    if (/(y+)/.test(format)) {
    	format = format.replace(RegExp.$1, (this.getFullYear() +"").substr(4 - RegExp.$1.length));
    }
    
    for (var k in o) {
    	if (new RegExp("(" + k + ")").test(format)) {
    		format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" +o[k]).length));
    	}
    }
    
    return format;
};
