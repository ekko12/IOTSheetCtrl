//star flash
 $(function(){
        var num =25;
        var $star=$(".l_stars");
        for(var i=0;i<num;i++){
            var posL=Math.random()*$star.width()+'px';
            var posT=Math.random()*$star.height()+'px';
            $star.append("<span style=\'"+"left:"+posL+";top:"+posT+";"+"\'>");
            dark();
        }
        function dark(){
            $star1=$star.find('span');
            $star1.animate({'opacity':'0'},200,function(){light()});
        }
        function light(){
            $star1.animate({'opacity':'0.8'},100,function(){dark()});
        }
        
       
    });