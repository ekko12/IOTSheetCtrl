//music
var music = document.getElementById("audio");
var m_btn = document.getElementById('m_btn');
var m_spin = document.getElementById('m_spin');
var m_win = document.getElementById('m_win');
var m_change = document.getElementById('m_change');

function playBtn() {
	if (m_btn.paused) {
		m_btn.play();
	}
}

function pauseBtn() {
	if (!m_btn.paused) {
		m_btn.pause();
	}
}

function playSpin() {
	if (m_spin.paused) {
		m_spin.play();
	}
}

function pauseSpin() {
	if (!m_spin.paused) {
		m_spin.pause();
	}
}
function playWin() {
	if (m_win.paused) {
		m_win.play();
	}
}
function playMusic() {
    if (music.paused) {
        music.play();
        $("#music").removeClass("stopped");
    }
}
function pauseMusic() {
    if (!music.paused) {
        music.pause();
        $("#music").addClass("stopped");
    }
}



function numRand(level){
	result = "000000";
	$.ajax({
		type: 'POST',
		url: ctx+'/luck/getWinningNumber.do',
		datatype : 'json',
		data : {"level":level},
		success : function(data){
			result = data.number;
			$('.btn_stop').removeClass('disabled');
			isEnd = false;
		}
	});
}
function numMove(){
    $(".l_num_2").each(function(index){
        var _num = $(this);
        _num.addClass("numMoveY");
	});	
}
var isBegin = false;
var isEnd = true;
var isNext = true;
var isAd = true;
var titleArr = new Array();
titleArr.push("l_title_1");
titleArr.push("l_title_2");
titleArr.push("l_title_3");
titleArr.push("l_title_4");
titleArr.push("l_title_5");
var prizeArr = new Array();
prizeArr.push("First Prize :");
prizeArr.push("Second Prize :");
prizeArr.push("Third Prize :");
prizeArr.push("Fourth Prize 2 :");
prizeArr.push("Fourth Prize 1 :");
var result = "000000";
var u=92.4;
var winWidth = $(document).width();
if(winWidth > 1366){
    u = 126;
}
$(function(){
	$("#ad").click(function(){
		adpress();
	});
	$("#title").addClass(titleArr[$("#level").val()-1]);
	$('.l_num').addClass('l_num_default');
	if(prize5!=""){
		$('.result_lists_one').prepend(' <li><span class=\"lottery_name\">'+prizeArr[4]+'</span><span class=\"lottery_num\">'+prize5+'</span></ li>');
	}
	if(prize4!=""){
		$('.result_lists_one').prepend(' <li><span class=\"lottery_name\">'+prizeArr[3]+'</span><span class=\"lottery_num\">'+prize4+'</span></ li>');
	}
	if(prize3!=""){
		$('.result_lists_one').prepend(' <li><span class=\"lottery_name\">'+prizeArr[2]+'</span><span class=\"lottery_num\">'+prize3+'</span></ li>');
	}
	if(prize2!=""){
		$('.result_lists_one').prepend(' <li><span class=\"lottery_name\">'+prizeArr[1]+'</span><span class=\"lottery_num\">'+prize2+'</span></ li>');
	}
	// BGM
	$("#music").click(function() {
		if (music.paused) {
			music.play();
			$("#music").removeClass("stopped");
		} else {
			music.pause();
			$("#music").addClass("stopped");

		}
	});
	$('#start').click(function(){start();});	
    
  
    $('#stop').click(function(){stop();});
    
    
    $('#next').click(function(){next();});	

	$(document).keydown(function(e) {
		switch (e.which) {
		case 32:// user presses the "空格" key
			start();
			break;
		case 13:// user presses the "enter" key
			stop();
			break;
		case 39: // user presses the "->" key
			next();
			break;
		case 109: // user presses the "m" key
			musicPress();
			break;
		case 77:// user presses the "M" key
			musicPress();
			break;
		default:
			adpress();
			break;
		}
	});

});

function start(){
	if(isBegin||isAd) return false;
	isBegin = true;
	// music
    pauseMusic();
    playBtn();
    playSpin();
    // light
	$(".l_num_box").children("div").removeAttr("style") ;
    $('.l_light').addClass('light_flash');
    $('#start').addClass('disabled');
    var level = $("#level").val();
    numRand(level);
    for(var l=0;l<tempdos;l++){
        $(".l_num").eq(l).addClass('l_num_1');
    }
    for(var l=tempdos;l<6;l++){
        $(".l_num").eq(l).addClass('l_num_2');
    }
    $(".l_num").removeClass('l_num_default').css('backgroundPositionY', 0);//set num
    numMove();
}

function stop(){
	if(isEnd||isAd)return;
    $('#stop').addClass('disabled');   
	isEnd = true;
	playBtn();
	var level = $("#level").val();
	var num_arr = (result+'').split('');
	var mark = 5;
    for(var i=0;i<num_arr.length;i++){
    	if(num_arr[i] == "*"){
    		mark = i-1;
    		break;
    	}
    }
	$(".l_num_2").each(function(index){
		var _num = $(this);
		setTimeout(function(){
            if(num_arr[index+tempdos*1] == "*"){
                _num.removeClass("numMoveY");
               _num.addClass('l_num_default').removeAttr("style");
            } else{
                _num.removeClass("numMoveY");
                _num.animate({ 
                    backgroundPositionY: (u*60) - (u*num_arr[index+tempdos*1])
                },{
                    duration: 3000+index*3000,
                    easing: "easeOutCirc",
                    complete: function(){
                        if(index==mark-tempdos){ 
                            $('#next').removeClass('disabled');
                            isNext = false;
                            $('.l_light').removeClass('light_flash');
           					$("#level").val(level-1);
           					pauseSpin();
                            playWin();
                        }
                    }
                });
            }
		}, index * 300);
	});
}

function next(){
	if($("#level").val()==0){
		window.location.href=ctx+"/luck/result.do";
		return;
	}
	if(isNext||isAd)return;
	isNext = true;
	isBegin = false;
	if(m_change.paused){
        m_change.play();
	}
	playMusic();
	$('.l_num').addClass('l_num_default').removeAttr("style");
    $('#start').removeClass('disabled');
    $("#title").addClass(titleArr[$("#level").val()-1]);
    $('.result_lists_one').prepend(' <li><span class=\"lottery_name\">'+prizeArr[$("#level").val()]+'</span><span class=\"lottery_num\">'+result+'</span></ li>');
    $('#next').addClass('disabled');
}

function musicPress() {
    if (music.paused) {
        music.play();
        $("#music").removeClass("stopped");
    } else {
        music.pause();
        $("#music").addClass("stopped");
    }
}

function adpress(){
	if(!isAd)return;
	$("#ad").fadeOut();
	isAd = false;
}