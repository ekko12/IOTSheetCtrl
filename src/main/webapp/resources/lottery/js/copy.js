function numRand() {
	var x = 999999; //上限
	var y = 0; //下限
	var rand = parseInt(Math.random() * (x - y + 1) + y);
	return rand;
}
var count=1; 
var u = 126;    
function numMove(){
    $(".l_num").each(function(index){
        var _num = $(this);
//        _num.animate({ 
//					//backgroundPositionY:u*200
//                   moveY
//				},{
//					duration: 10000+index*3000,
//					easing: "easeInOutCirc",
//					
//				});
        _num.addClass("numMoveY");
   
});
}
var isBegin = false;
$(function(){
    
//    //star
//    var star_num =25;
//        var $star=$(".l_stars");
//        for(var j=0;j<star_num;j++){
//            var posL=Math.random()*$star.width()+'px';
//            var posT=Math.random()*$star.height()+'px';
//            $star.append("<span style=\'"+"left:"+posL+";top:"+posT+";"+"\'>");
//            dark();
//        }
//        function dark(){
//            $star1=$star.find('span');
//            $star1.animate({'opacity':'0'},200,function(){light()});
//        }
//        function light(){
//            $star1.animate({'opacity':'0.8'},100,function(){dark()});
//        }
        
    
    //Lottery Num
	var u = 126;
	$('#start').click(function(){
		if(isBegin) return false;
		isBegin = true;
        $('.l_light').addClass('light_flash');
        $(this).addClass('disabled');
        $('#stop').removeClass('disabled');
		$(".l_num").css('backgroundPositionY',0);
        numMove();
		
		
	});	
    $('#stop').click(function(){
        var result = numRand();
		$('#res').text('摇奖结果 = '+result);
		var num_arr = (result+'').split('');
        $(this).addClass('disabled');
		$(".l_num").each(function(index){
			var _num = $(this);
			setTimeout(function(){
                _num.removeClass("numMoveY");
				_num.animate({ 
					backgroundPositionY: (u*60) - (u*num_arr[index])
				},{
					duration: 3000+index*3000,
					easing: "easeOutCirc",
					complete: function(){
						if(index==5){ 
                            isBegin = false;
                            $('#start').removeClass('disabled');
                            $('.l_light').removeClass('light_flash');
                        }
					}
				});
			}, index * 300);
		});
         
    });
    
        $('.stop2').click(function(){
        var result = numRand();
		$('#res').text('摇奖结果 = '+result);
           
		var num_arr = (result+'').split('');
        for(var i=0;i<num_arr.length;i++){
            if(i>(2-1)){
                num_arr[i]=0;
            }
        }
		$(".num").each(function(index){
			var _num = $(this);
			setTimeout(function(){
                _num.removeClass("numMoveY");
				_num.animate({ 
					backgroundPositionY: (u*60) - (u*num_arr[index])
				},{
					duration: 3000+index*3000,
					easing: "easeOutCirc",
					complete: function(){
						if(index==1) isBegin = false;
					}
				});
			}, index * 300);
		});
    });

});


//
////star flash
// $(function(){
//        var num =25;
//        var $star=$(".l_stars");
//        for(var i=0;i<num;i++){
//            var posL=Math.random()*$star.width()+'px';
//            var posT=Math.random()*$star.height()+'px';
//            $star.append("<span style=\'"+"left:"+posL+";top:"+posT+";"+"\'>");
//            dark();
//        }
//        function dark(){
//            $star1=$star.find('span');
//            $star1.animate({'opacity':'0'},200,function(){light()});
//        }
//        function light(){
//            $star1.animate({'opacity':'0.8'},100,function(){dark()});
//        }
//        
//       
//    });