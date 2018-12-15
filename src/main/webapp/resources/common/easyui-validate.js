/**
 * easyui中验证框拓展
 * 
 * @author 舒少雄
 * 
 * ************************** 验证方法说明 ************************开始
 * 
 * =============================validatebox=====================================start
 * 
 * multiple[param_N]                       组合验证(多个验证方法一起使用),每一个参数对应一个验证方法(用法：validType="multiple['length[10,20]', 'spaceValid']")
 * 
 * minLength[param_0]                      至少输入{0}个字符(一个中文占两个字符).
 * maxLength[param_0]                      最多输入{0}个字符(一个中文占两个字符).
 * length[param_0,param_1]                 请输入{0}至{1}个字符(一个中文占两个字符).
 * 
 * dataValid                               日期格式如：2012-10-01
 * dataTimeValid                           日期时间格式如：2012-10-01 09:09:09
 * timeValid                               时间格式如：09:09:09
 * 
 * spaceValid                              该输入项不允许输入空格
 * chineseValid                            该输入项不允许输入中文字符
 * onlyChineseValid                        该输入项只允许输入中文字符
 * numberValid                             该输入项只允许输入数字
 * 
 * =============================validatebox=====================================end
 * 
 * 
 * =============================combo===========================================start
 * 
 * requiredCombo[param_0]                  验证框combo控制ID
 * 
 * =============================combo===========================================end
 * 
 * 
 * =============================numberbox=======================================start
 * 
 * minValue[param_0]                       该输入项的值必须大于或等于{0}
 * 
 * =============================numberbox=======================================end
 * 
 * ************************** 验证方法说明 ************************结束
 */

$(function(){
	$.extend($.fn.validatebox.defaults.rules, {
	    multiple: {
	        validator: function (value, param) {
	            var returnFlag = true;
	            var opts = $.fn.validatebox.defaults;
	            for (var i = 0; i < param.length; i++) {
	                var methodinfo = /([a-zA-Z_]+)(.*)/.exec(param[i]);
	                var rule = opts.rules[methodinfo[1]];
	                if (value && rule) {
	                    var parame = eval(methodinfo[2]);
	                    if (!rule["validator"](value, parame)) {
	                        returnFlag = false;
	                        this.message = rule.message;
	                        break;
	                    }
	                }
	            }
	            return returnFlag;
	        },
			message: ''
	    },
	    
	    minLength: {
	        validator: function(value, param){
	        	if (param[0] == 'none') return true;
	        	
	        	var value_length = value.replace(/[^\x00-\xff]/g, "**").length;
	        	
	        	if (value_length < param[0]) {
	        		this.message = '至少输入'+param[0]+'个字符(一个中文占两个字符).';
	        		return false;
	        	}

        		return true;
	        },
			message: ''
	    },
	    maxLength: {
	        validator: function(value, param){
	        	if (param[0] == 'none') return true;
	        	
	        	var value_length = value.replace(/[^\x00-\xff]/g, "**").length;
	        	
	        	if (value_length > param[0]) {
	        		this.message = '最多输入'+param[0]+'个字符(一个中文占两个字符).';
	        		return false;
	        	}
	        	
        		return true;
	        },
			message: ''
	    },
	    length: {
	        validator: function(value, param){
	        	var value_length = value.replace(/[^\x00-\xff]/g, "**").length;
	        	
	        	if ((value_length < param[0]) || (value_length > param[1])) {
	        		this.message = '请输入'+param[0]+'至'+param[1]+'个字符(一个中文占两个字符).';
		            return false;
	        	}
	        	
        		return true;
	        },
			message: ''
	    },
	    
	    dataValid: {
	        validator: function(value, param){
	        	var r = value.match(/^(\d{4})(-|\/)(\d{2})\2(\d{2})$/);
	        	if( r == null) {
	        		this.message = '日期格式如：2012-10-01';
	        		return false;
	        	}
	        	
	        	var d = new Date(r[1], r[3]-1, r[4]);
	        	if (!(d.getFullYear()==r[1] && (d.getMonth()+1)==r[3] && d.getDate()==r[4])) {
	        		this.message = '日期格式如：2012-10-01';
	        		return false;
	        	}

        		return true;
	        },
			message: ''
	    },
	    dataTimeValid: {
	        validator: function(value, param){
	        	var reg = /^(\d{4})(-|\/)(\d{2})\2(\d{2}) (\d{2}):(\d{2}):(\d{2})$/;
	        	var r = value.match(reg);
	        	if(r == null) {
	        		this.message = '日期时间格式如：2012-10-01 09:09:09';
	        		return false;
	        	}
	        	
	        	var d = new Date(r[1], r[3]-1,r[4],r[5],r[6],r[7]);
	        	if (!(d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]&&d.getHours()==r[5]&&d.getMinutes()==r[6]&&d.getSeconds()==r[7])) {
	        		this.message = '日期时间格式如：2012-10-01 09:09:09';
	        		return false;
	        	}
	        	
        		return true;
	        },
			message: ''
	    },
	    timeValid: {
	        validator: function(value, param){
	        	var a = value.match(/^(\d{2})(:)?(\d{2})\2(\d{2})$/);
	        	if (a == null) {
	        		this.message = '时间格式如：09:09:09';
	        		return false;
        		}
	        	
	        	if (a[1]>24 || a[3]>60 || a[4]>60) {
	        		this.message = '时间格式如：09:09:09';
	        		return false;
	        	}
	        	
	        	return true; 
	        },
			message: ''
	    },
	    spaceValid: {
	        validator: function(value, param){
	            var pattern = /(^\s)/g; // 文本前面的空格
	        	if (pattern.test(value)) {
	        		this.message = '该输入项不允许输入空格';
	        		return false;
        		}

	            pattern = /(\s$)/g; // 文本后面的空格
	        	if (pattern.test(value)) {
	        		this.message = '该输入项不允许输入空格';
	        		return false;
	        	}
	        	
	            pattern = /\s/g; // 文本中间的空格
	        	if (pattern.test(value)) {
	        		this.message = '该输入项不允许输入空格';
	        		return false;
	        	}
	        	
	        	return true; 
	        },
			message: ''
	    },
	    chineseValid: {
	        validator: function(value, param){
	            var pattern = /[^\x00-\xff]/g;
	        	if (pattern.test(value)) {
	        		this.message = '该输入项不允许输入中文字符(包括中文符号)';
	        		return false;
        		}
	        	
	        	return true; 
	        },
			message: ''
	    },
	    onlyChineseValid: {
	        validator: function(value, param){
	            var pattern = /[\x00-\xff]/g;
	        	if (pattern.test(value)) {
	        		this.message = '该输入项只允许输入中文字符(包括中文符号)';
	        		return false;
        		}
	        	
	        	return true; 
	        },
			message: ''
	    },
	    numberValid: {
	        validator: function(value, param){
	            var r = value.match(/^(-?\d+)(\.\d+)?$/);
	        	if (r == null) {
	        		this.message = '该输入项只允许输入数字(包括小数)';
	        		return false;
        		}

	        	if (param && param.length > 0) {
	        		var str = value.substring(value.indexOf('.') + 1, value.length);
	        		if (str.length > param[0]) {
		        		this.message = '该输入项只允许输入数字(小数位最多两位)';
	        			return false;
	        		}
	        	}
	        	
	        	return true; 
	        },
			message: ''
	    },
	    numberLimitValid: {
	        validator: function(value, param){
	            var r = value.match(/^(-?\d+)(\.\d+)?$/);
	        	if (r == null) {
	        		this.message = '该输入项只允许输入数字(包括小数)';
	        		return false;
        		}
	        	if (param) {
	        	        var num1=param,num2=value.split('.');
	        	        if(num1[0]<num2[0].length){
	        	            this.message = '该输入项只允许输入数字(整数最多'+num1[0]+'位)';
	        	            return false;
	        	        }
	        	        if(num1.length==1&&num2.length==2){
	        	            this.message = '该输入项只允许输入数字(只能是整数)';
	        	            return false;
	        	        }
	        	        if(num2.length==2&&num1[1]<num2[1].length){
	        	            this.message = '该输入项只允许输入数字(小数位最多'+num1[1]+'位)';
	        	            return false;
	        	        }
	        	}
	        	
	        	return true; 
	        },
			message: ''
	    }

    	/*loginName: {  
		// param 参数集合  
		validator: function (value, param) {  
			if (value.length < param[0]) {  
				$.fn.validatebox.defaults.rules.loginName.message = '用户名要' + param[0] + '位数！';  
				return false;  
			} else {  
				if (!/^[\w]+$/.test(value)) {  
					$.fn.validatebox.defaults.rules.loginName.message = '用户名只能英文字母、数字及下划线的组合！';  
					return false;  
				} else {  
					var postdata = {};  
					if (param[3]) {  
						postdata[param[2]] = param[3];  
					} else {  
						postdata[param[2]] = value;  
					}  
					var result = $.ajax({  
						url: param[1],  
						data: postdata,  
						type: 'post',  
						dataType: 'json',  
						async: false,  
						cache: false  
					}).responseText;  
					if (result == 'false') {  
						$.fn.validatebox.defaults.rules.loginName.message = '用户名已存在！';  
						return false;  
					} else {  
						return true;  
					}  
				}  
			}  
		},
		message: ''  
	}*/
	});
	
	// 下拉选择框必填验证
	$.extend($.fn.combo.defaults.rules, {
		requiredCombo: {
	        validator: function(value, param){
	        	var data = $('#'+param[0]).combo("getValues");
	        	if (data.length == 1) {
	        		if ($.trim(data[0]) == "") {
	        			this.message = '该输入项为必输项';
	        			return false;
	        		}
	        	}
	        	return true;
	        },
			message: ''
		}
	});
	
	$.extend($.fn.numberbox.defaults.rules, {
		minValue: {
	        validator: function(value, param){
	        	if (value < param[0]) {
        			this.message = '该输入项的值必须大于或等于'+param[0];
		        	return false;
	        	}
	        	return true;
	        },
			message: ''
		}
	});
});