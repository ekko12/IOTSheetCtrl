var api = frameElement.api, W = api.opener;
api.button({
    name : 'Confirm',
    focus : true,
    callback:function(){
    	
       	var expr = $('#expr').val();
    	var content_en=$('#content_en').val();
    	var content_cn=$('#content_cn').val();
    	var content_jpz=$('#content_jpz').val();
    	if(expr == null || expr ==''){
    		$.dialog({
                title : 'Prompt',
                content : 'The expression can not be empty！',
                cancelVal : 'Close',
                zIndex : 9999,
                cancel : function() {
                    return true;
                }
            });
    		return false;
    	}
    	
    	if(content_en == null || content_en ==''){
    		$.dialog({
                title : 'Prompt',
                content : 'The template content(English) can not be empty！',
                cancelVal : 'Close',
                zIndex : 9999,
                cancel : function() {
                    return true;
                }
            });
    		return false;
    	}
    	
    	if(content_cn == null || content_cn ==''){
    		$.dialog({
                title : 'Prompt',
                content : 'The template content(Chinese) can not be empty！',
                cancelVal : 'Close',
                zIndex : 9999,
                cancel : function() {
                    return true;
                }
            });
    		return false;
    	}
    	
    	if(content_jpz == null || content_jpz==''){
    		$.dialog({
                title : 'Prompt',
                content : 'The template content(Khmer) can not be empty！',
                cancelVal : 'Close',
                zIndex : 9999,
                cancel : function() {
                    return true;
                }
            });
    		return false;
    	}
    	
    	var dtl ={
    			"dtlId":$('#dtlId').val(),
    			"expr":expr,
    			"content_en":content_en,
    			"content_cn":content_cn,
    			"content_jpz":content_jpz,
    			"dtlRemark":$('#dtlRemark').val(),
    			"dtlState":$('#dtlState').val()	
    	}
    	if (W && W.setDataToTable) {
            W.setDataToTable(dtl);
        }
    }
}, {
    name : 'Cancel'
});



