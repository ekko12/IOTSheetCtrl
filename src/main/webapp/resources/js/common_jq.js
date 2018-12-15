// JavaScript Document
$(document).ready(function(){
	$(".phd .search .txt").click(function(){
		$(this).val("")
	});
	$(".phd .search .txt").blur(function(){
		if($(this).val() == "") $(this).val("请输入关键字");
	});
	
	$(".mod-wordlist .mbd ul li > .meta").toggle(function(){
		$(this).siblings(".cont").show(); 
	},function(){
		$(this).siblings(".cont").hide(); 
	});
	$(".mod-wordlist .mbd ul li > .cont .close").click(function(){
		$(this).parent(".cont").hide();
		return false;
	});
});
/* tabs */
$(document).ready(function(){	
	$(".tab_menu").each(function(i){		
		$(this).find("li").each(function(j){		
			$(this).hover(function(){				
				$(".tab_content:eq("+i.toString()+") div").css("display","none");
				$(".tab_content:eq("+i.toString()+") div:eq("+j.toString()+")").fadeIn("fast");
				$(this).parent().find("li").removeClass("hover");
				$(this).addClass("hover");			
			});		
		});		
	});
});
/*nav 
function menu_f(){
	var winH = $(window).height();
	var upos, utop, total,shownum,liH,leftH,lin; 
	
	var $navli = $(".nav>ul>li");
	total = $navli.length;
	liH = $navli.eq(0).height();
	leftH = $(".west").height();
		
	if(leftH>liH*total){
		shownum = total;
		$("#navbtn").hide().removeClass("navback");
	}else{
	   	shownum = Math.floor((leftH-40)/liH);
		for(lin=shownum;lin<total;lin++){
			$navli.eq(lin).hide();
		}
		$("#navbtn").show().click(function(){
			$navli.toggle();
			$(this).toggleClass("navback");
		})
	}
	 

	$(".nav > ul > li:has(dl)").each(function(){
		var $snav = $(this).children(".subnav");
		
		$(this).hover(function(){
			$(this).addClass("hover");
			
			upos = $(this).offset(); 
			if(upos.top+$snav.height()>winH){
				utop = $(this).height()-$snav.height()+1;
			 }else{
				utop = -2; 
			}
			$snav.css({top: utop});			
			$snav.show();
			
		}, function(){
			$snav.hide();
			$(this).removeClass("hover");
		});
		
	});
	
}*/	

function show(id)
{
	var divid = "" + id;
	divid = "#" + divid;
	$(divid).show();
}

function hide(id)
{
	var divid = "" + id;
	divid = "#" + divid;
	$(divid).hide();
}

function show(id)
{
	var divid = "" + id;
	divid = "#" + divid;
	$(divid).show();
}

/**
 * 如果指定的元素为隐藏时,则显示出来,否则将其隐藏
 * @param id html对应元素的id
 * @return
 */
function showOrHide(id)
{
	var divid = "" + id;
	divid = "#" + divid;
	if($(divid).css("display") == "none"){
		$(divid).show();
	}else{
		$(divid).hide();
	}
}

//删除元素(参数动态获取)
function removeELementByIds(){
	var length = arguments.length;
	if(length > 0){
		for(var i = 0;i < length;i++){
			$("#" + arguments[i]).remove();
		}
	}
}