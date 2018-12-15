/**
 * 页面加载
 */
$(function(){
	/**加载当前用户功能操作权限*/
	$.ajax({
        type : 'POST',
        url : 'funOperate/getFunOperatesByOperator.do',
        datatype : 'json',
        success : function(result) {
        	//结束
        }
    });
	
});