 
	
	/*nav */	
	var shownum,endN,total,winH,leftH;
	var $navli;
	var liH =46;
	var startN =0;
	
   // alert($navli.length);
	

	
	
	function menu_f(){
		$navli = $(".nav>ul>li");
		total = $navli.length;
		 
		winH = $(window).height();
		var upos,utop,lin; 
		 
		leftH = $(".west").height(); 
		 
		//alert("1"+":"+winH+":"+leftH+":"+shownum );
			
		if(leftH>liH*total){
			 
			shownum = total;
			$("#navbtn").hide();
			$navli.show();
		}else{
			 
			shownum = Math.floor((leftH-50)/liH);
			$navli.show();
			for(lin=shownum;lin<total;lin++){
				$navli.eq(lin).hide();
			}
			$("#navbtn").show();
			$("#upt").removeClass("on");
			$("#dnt").addClass("on");
			  
		}
		 
	
		
	 
	};
	
	function menubtn(){
		$navli = $(".nav>ul>li");
		
		$("#upt").click(function(){
				 
				if($(this).hasClass("on")){
					 
					startN = (startN-shownum)<0?0:(startN-shownum);
					endN = (startN+shownum)<total ? (startN+shownum) :total;
					$navli.hide();
					for(lin=startN;lin<endN;lin++){					
						$navli.eq(lin).show();
					}
					$("#dnt").addClass("on");
					if(startN == 0){
					 $("#upt").removeClass("on");	
					}
				 }
		})
		
		$("#dnt").click(function(){ 
				 
				if($(this).hasClass("on")){
					 
					startN = (startN+shownum)<total?(startN+shownum):0;
					endN = (startN+shownum)<total ? (startN+shownum) : total;
					$navli.hide();
					for(lin=startN;lin<endN;lin++){					
						$navli.eq(lin).show();
					}
					$("#upt").addClass("on");	
					if(endN == total){
					 $("#dnt").removeClass("on");	
					}
					
				}
			});
			
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
		
	}

 