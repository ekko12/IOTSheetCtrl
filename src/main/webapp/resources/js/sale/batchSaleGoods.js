$(document).ready(function() {
	 $("#btn_save").click(function() {
		 var lock = $.dialog({
            show : false
         }).lock();
		 var flag=true;
		 var goods=$('#haveGoods').val();//销售商品
		 var agents=$('#agentsId').val();//代理商账号
		 if(goods==null || goods==""){
			 flag = false;
			 $.dialog({
                 title : '提示',
                 content : '销售商品不能为空！',
                 cancelVal : '关闭',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
		 }
		 if(agents==null || agents==""){
			 flag = false;
			 $.dialog({
                 title : '提示',
                 content : '代理商不能为空！',
                 cancelVal : '关闭',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
		 }
		 
		 var payModes='';//获取勾选支付方式
		 $('input[name="payModes"]:checked').each(function(){ 
			 payModes+=$(this).val()+','; 
		 }); 
		 if(payModes=='' || payModes==null){
			 flag = false;
			 $.dialog({
                 title : '提示',
                 content : '请选择支付方式！',
                 cancelVal : '关闭',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
		 }
		 
		 var deliverys='';//获取勾选配送方式
		 $('input[name="deliverys"]:checked').each(function(){ 
			 deliverys+=$(this).val()+','; 
		 }); 
		 if(deliverys=='' || deliverys==null){
			 flag = false;
			 $.dialog({
                 title : '提示',
                 content : '请选择配送方式！',
                 cancelVal : '关闭',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
		 }
		 
		 var upDelayTime = $("#upDelayTime").val();//定时上架时间
         var upSetting = $("input[name='upSetting']:checked").val();//是否是手动上架
         if (upSetting == $("#WCS_TIMING_UP").val() && upDelayTime == "") {
             flag = false;
             $.dialog({
                 title : '提示',
                 content : '请设定定时上架时间！',
                 cancelVal : '关闭',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
         }
         
         if (upSetting == $("#WCS_TIMING_UP").val() && upDelayTime != "") {
             var myDate = new Date().format("yyyy-MM-dd hh:mm:ss");
             if (upDelayTime < myDate) {
                 flag = false;
                 $.dialog({
                     title : '提示',
                     content : '定时上架时间不能小于当前时间！',
                     cancelVal : '关闭',
                     cancel : function() {
                         lock.close();
                         return true;
                     }
                 });
                 return false;
             }
         }
         
         var dwonSetting = $("input[name='dwonSetting']:checked").val();//请选择下架方式
         if (dwonSetting == null || dwonSetting == "") {
             flag = false;
             $.dialog({
                 title : '提示',
                 content : '请选择下架方式！',
                 cancelVal : '关闭',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
         }
         
         var dwonDelayTime = $("#dwonDelayTime").val();//下架时间
         if (dwonSetting == $("#WCS_TIMING_DOWN").val() && dwonDelayTime == "") {
             flag = false;
             $.dialog({
                 title : '提示',
                 content : '请设定定时下架时间！',
                 cancelVal : '关闭',
                 cancel : function() {
                     lock.close();
                     return true;
                 }
             });
             return false;
         }
         //如果是定时下架
         if (dwonSetting == $("#WCS_TIMING_DOWN").val() && dwonDelayTime != "") {
             var myDate = new Date().format("yyyy-MM-dd hh:mm:ss");
             if (dwonDelayTime < myDate) {
                 flag = false;
                 $.dialog({
                     title : '提示',
                     content : $("#" + accessList[i]).val() + '版，定时下架时间不能小于当前时间！',
                     cancelVal : '关闭',
                     cancel : function() {
                         lock.close();
                         return true;
                     }
                 });
                 return false;
             }
         }
       
         if(flag){
        	 var batchDialog=$.dialog.tips('数据保存中...',600,'loading.gif').lock();
        	 $("#batchform").ajaxSubmit({
        		 type: "post",
 				 url: 'batchsale/batchPulishSaleGoods.do',
 				 dataType:"json",
 				 success: function (msg) {
 					 batchDialog.close();
 					 var message="";
 					 var salId="";//没有匹配的销售商品id
 					 var strChlSal="";//已经发布的渠道账号和销售商品id
 					 if(msg.salId!=null &&　msg.salId!=""){
 						salId=msg.salId;
 					 }
 					 if(msg.strChlSal!=null && msg.strChlSal!=null){
 						strChlSal=msg.strChlSal;
 					 }
 					 if(salId!=null && salId!=""){
 						if(strChlSal!=null && strChlSal!=""){
 							message='本次发布没有匹配渠道的销售商品id：'+salId+'</br></br>已经发布过的渠道账号和销售商品id：'+strChlSal;
 						}else{
 							message='本次发布没有匹配渠道的销售商品id：'+salId;
 						}
 					 }else{
 						message='已经发布过的渠道账号和销售商品id：'+strChlSal;
 					 }
 					 if (msg.flag==true || msg.flag=="true"){
 						 $.dialog({
 	                         title : '提示',
 	                         content : message+'<br/>本次发布的任务id为：'+msg.key,
 	                         ok : function() {
 	                             window.location.href = rootPath + "/batchsale/batchSaleGoodsMainPage.do";
 	                             return true;
 	                         }
 	                     });
 	                 }else{
 	                	$.dialog({
	                         title : '提示',
	                         content : message,
	                         ok : function() {
	                             return true;
	                         }
	                     });
 	                 }
 				 },
				 error:function(result){
					 batchDialog.close();
					 $.dialog({
                         title : '提示',
                         content : '后台报错',
                         ok : function() {
                         //    window.location.href = rootPath + "/batchsale/batchSaleGoodsMainPage.do";
                             return true;
                         }
                     });
				 }
             });
         }else {
             lock.close();
         }
	});
});

//导出商品模板
function exportGoods(){
	window.location.href = rootPath + "/batchsale/exportGoods.do";
}

//导出渠道模板
function exportAgent(){
	window.location.href = rootPath + "/batchsale/exportAgent.do";
}
