 $(function () {
            //input获取焦点
            $("input,textarea").focusin(function(){
                $(this).addClass("focus");
            });
            $("input,textarea").focusout(function(){
                $(this).removeClass("focus");
            });
            
            //    登录表单验证 
            $("#loginForm").validate({
                /*自定义验证规则*/
                rules:{
                    UserName: { required: true, minlength: 3, maxlength: 18, remote: "/Home/CheckUserName" },
                    UserPassword: { required: true ,minlength: 6 },
                    yzm:{required: true ,minlength: 6}
                   
                },
                 messages:{
                    UserName: { 
                        required: "请输入用户名！",
                        minlength: "用户名长度最少需要3位！",
                        maxlength: "用户名长度最大不能超过18位！",
                        remote: "此用户名已存在！"
                     },
                     UserPassword: {
                        required: "请输入你的密码!",
                        minlength: "密码长度不能小于6位"
                    },
                     yzm:{
                         required:"请输入验证码!",
                          minlength: "验证码长度不能小于6位"
                     }
                   
                },
                onkeyup: false, //禁止keyup.
                focusCleanup:true,
                success:"valid"
               

            });
            //    注册表单验证
            $("#registerForm").validate({
                /*自定义验证规则*/
                rules:{
                    UserName: { required: true, minlength: 3, maxlength: 18, remote: "/Home/CheckUserName" },
                    UserPassword: { required: true ,minlength: 6 },
                    SedPassword:{required: true },
                    Email: { required: true,email:true },
                    Name: { required: true },
                    Mobile: { required: true, number:true,minlength:11 }, 
                    Address: { required: true }, 
                    IdCard: { required: true,isIdCardNo: true }
                    
                },
                 messages:{
                    UserName: { 
                        required: "请输入用户名！",
                        minlength: "用户名长度最少需要3位！",
                        maxlength: "用户名长度最大不能超过18位！",
                        remote: "此用户名已存在！"
                     },
                     UserPassword: {
                        required: "请输入你的密码!",
                        minlength: "密码长度不能小于6位"
                    }, 
                    SedPassword:{
                        required:"请再输入一次密码"
                    }, 
                    Email: {
                        required: "请输入你的邮箱！",
                        email: "请输入正确的邮箱格式"
                    },
                    Name:{
                        required:"请输入你的姓名！"
                    },
                    Mobile: {
                        required: "请填写你的手机号码",
                        number:"手机号码只能为数字",
                        minlength:"请输入11位手机号码"
                     },
                    Address:{
                        required:"请输入你的居住地址！"
                    },
                    IdCard: {
                        required: "请输入身份证号码！",
                        isIdCardNo:"请输入正确的身份证号码！"
                    }
                    
                },
                onkeyup: false, //禁止keyup.
                focusCleanup:true,
                success:"valid"
            });
     
     
     //左导航栏
        //$.sidebar("#sidebar .item h4","#sidebar .item .info","fast",3,"click"); /*5个参数顺序不可打乱，分别是：相应区,隐藏显示的内容,速度,类型,事件*/
     
     
     //生成分页控件 
     var totalPage=20;
     var totalRecords=30;
     var pageNo = getParameter('pno');
     if(!pageNo){
         pageNo = 1;
     }  
     kkpager.generPageHtml({
        pno : pageNo,
        mode : 'click', //设置为click模式
        //总页码  
        total : totalPage,  
        //总数据条数  
        totalRecords : totalRecords,
        //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
        //适用于不刷新页面，比如ajax
        click : function(n){
            //处理完后可以手动条用selectPage进行页码选中切换
            this.selectPage(n);
            return false;
        }
    });
     
     
});

//返回字符串
function getParameter(name) { 
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); 
	var r = window.location.search.substr(1).match(reg); 
	if (r!=null) return unescape(r[2]); return null;
}

//左导航栏
jQuery.sidebar = function(obj,obj_c,speed,obj_type,Event){
	if(obj_type == 2){
		$(obj+":first").find("b").addClass("fa-caret-down").removeClass("fa-caret-right");
		$(obj_c+":first").show();
	}
	$(obj).bind(Event,function(){
		if($(this).next().is(":visible")){
			if(obj_type == 2){
				return false;
			}
			else{
				$(this).next().slideUp(speed).end().removeClass("selected");
				$(this).find("b").addClass("fa-caret-right").removeClass("fa-caret-down");
			}
		}
		else{
			if(obj_type == 3){
				$(this).next().slideDown(speed).end().addClass("selected");
				$(this).find("b").addClass("fa-caret-down").removeClass("fa-caret-right");
			}else{
				$(obj_c).slideUp(speed);
				$(obj).removeClass("selected");
				$(obj).find("b").addClass("fa-caret-right").removeClass("fa-caret-down");
				$(this).next().slideDown(speed).end().addClass("selected");
				$(this).find("b").addClass("fa-caret-down").removeClass("fa-caret-right");
			}
		}
	});
}