$(document).ready(function(){
	var chAreaval="";
	var chBrandval="";
	var chResul="";
	initData();
	 $("#saveSmsAccess").on("click",function(){
		if(checkIsNull("busiCmd","Access instructions")==false) return false;
		if(checkIsNull("busiCode","Business Code")==false) return false;		
//		if(checkIsNull("busiPort","Business Port")==false) return false; 
		if(checkIsNull("busiName","Business name")==false) return false;
		if(checkIsNull("timeOut","Timeout period")==false) return false;

		if(false==$("#busiArea").prop("checked")){
			alertDialog("","please select Region!");
			//alert("please select Region!");
			return false;
		}
		if(false==$("#busiBrand").prop("checked")){
			alertDialog("","please select Brand");
			//alert("please select Brand!");
			return false;
		}
		if($('#smsAccessForm').form('validate')==true){
			$.post(rootPath+"/smsweb/smsBusiAccess/saveBusiAccessCfgMainData.do", $("#smsAccessForm").serialize())
			.success(function(data) { 
				//alert("save success");
				location.href=rootPath+"/smsweb/smsBusiAccess/smsAccessCfgOfStep.do?busiAccessId="+parseInt(data);	
			})
	   		.error(function() { alert("error"); });
		}		
	});
	
	//业务地区
	$("#busiAreaAll").click(
		function(){
			if(this.checked){
				$("input[name='busiArea']").each(function(){this.checked=true;});
			}else{
				$("input[name='busiArea']").each(function(){this.checked=false;});
			}
		}
	);
	//业务品牌
	$("#busiBrandAll").click(
		function(){
			if(this.checked){
				$("input[name='busiBrand']").each(function(){this.checked=true;});
			}else{
				$("input[name='busiBrand']").each(function(){this.checked=false;});
			}
		}
	);
	//增加指令
	$("#patternOk").on("click",function(){	
		var busiPattern = $("#busiPattern").val();
		var busiCodeType=$("#busiCodeType").val();
		var busiValidDate=$("#busiValidDate").val();
		var busiExpireDate=$("#busiExpireDate").val();
		var busiCodeText = $("#busiCodeType").find("option:selected").text(); 
		if(checkIsNull("busiPattern","Access instructions")==false) return false;
		if(checkIsNull("busiCodeType","Match Mode")==false) return false;
		if(checkIsNull("busiValidDate","Effective time")==false) return false;
		if(checkIsNull("busiExpireDate","Expiry time")==false) return false;
		
		var cmd = $("#cmd").val();
		if(cmd !=""){
			$("#tabPatternDetail tr:eq("+cmd+")").each(function(){ 
				  $(this).children('td').eq(0).html(busiPattern+"<input type='hidden' id='busiPattern' name='busiPattern' value='"+busiPattern+"' />");
				  $(this).children('td').eq(1).html(busiValidDate+"<input type='hidden' id='busiValidDate'  name='busiValidDate'  value='"+busiValidDate+"' />");
				  $(this).children('td').eq(2).html(busiExpireDate+"<input type='hidden' id='busiExpireDate' name='busiExpireDate' value='"+busiExpireDate+"' />");
				  $(this).children('td').eq(3).html(busiCodeText+"<input type='hidden' id='hidbusiCodeType' value='"+busiCodeType+"' /><input type='hidden' id='busiCodeType' name='busiCodeType' value='"+busiCodeType+"' />");
			});			
			
		}else{
			$('#tabPatternDetail tr:last').after("<tr><td>"+busiPattern+"</td><td>"+busiValidDate+"</td><td>"+busiExpireDate+"</td><td>"+busiCodeText+"<input type='hidden' id='hidbusiCodeType' value='"+busiCodeType+"' /></td><td> <img alt='编辑' onclick='editTr(this)' src='resources/easyui13/themes/gray/images/button/btn_edit.gif'>&nbsp;<img alt='删除'  onclick='removeTr(this)' src='resources/easyui13/themes/gray/images/button/btn_del.gif'></td></tr>");
			$('#tabPatternDetail tr:last').after("<input type='hidden' id='busiPattern' name='busiPattern' value='"+busiPattern+"' /><input type='hidden' id='busiValidDate'  name='busiValidDate'  value='"+busiValidDate+"' /><input type='hidden' id='busiExpireDate' name='busiExpireDate' value='"+busiExpireDate+"' /><input type='hidden' id='hidbusiCodeType' value='"+busiCodeType+"' /><input type='hidden' id='busiCodeType' name='busiCodeType' value='"+busiCodeType+"' />");
		}
		$("#cmd").attr('value','');	
		closeLayerWin();
	});
	//关闭指令层
	$("#closePatternForm").on("click",function(){
		$('#patternForm')[0].reset(); 
		$('#smsPattern').hide();
	});

});
function closeLayerWin()
{
	$('#patternForm')[0].reset(); 
	$('#smsPattern').hide();
}
function checkIsNull(id,msg)
{
 	if($.trim($("#"+id).val())=="" || $.trim($("#"+id).val())==null){
 		alertDialog(id,"【"+msg	+"】Cannot be empty！");
  		return false;
	}
 		return true;
}
function initData(){
	$("#busiPattern").attr('value','');
	$("#busiValidDate").attr('value','');
	$("#busiExpireDate").attr('value','');
	$("#busiCodeType").attr('value','');
	$("#cmd").attr('value','');
	$("#timeOut").val("120");
}

//新增指令层
function addPattern(cmd,column){
	initData();
	$('#smsPattern').show();
	$('#busiExpireDate').val('2099-01-01 00:00:00');
}
function alertDialog(id,msg){
	$.dialog({
        title : '提示',
        content : msg,
        cancelVal : '关闭',
        cancel : function() {
        	$("#"+id).focus();
            return true;
        }
    });
	
}

function back()
{
	location.href=rootPath+"/smsweb/smsBusiAccess/toSmsAccessList.do";
}

 function removeTr(obj){
	 $(obj).closest('tr').remove();
}
function editTr(obj){
	var myRows = $('#tabPatternDetail tr').on('click',function()
	{
			i= myRows.index(this);	
			$("#cmd").attr('value',i);
			$("#tabPatternDetail tr:eq("+i+")").each(function(){ 
			 		var busiPattern = $("td:eq(0)",$(this));
			 		if(busiPattern.text() !=""){
			 			busiPattern = $.trim(busiPattern.text());
			 		}
			 		var busiValidDate = $("td:eq(1)",$(this));
			 		if(busiValidDate.text() !=""){
			 			busiValidDate =$.trim(busiValidDate.text());
			 		}
			 		var busiExpireDate = $("td:eq(2)",$(this));
			 		if(busiExpireDate.text() !=""){
			 			busiExpireDate=$.trim(busiExpireDate.text());
			 		}
			 		var busiCodeType = $("td:eq(3)",$(this));
			 		if(busiCodeType.text() !=""){
			 			busiCodeType = $.trim(busiCodeType.text());
			 		}
			 		var busiCodeValue = myRows.find("input[id='hidbusiCodeType']").eq(i-1).val();
			 		
			 		$('#smsPattern').show();
			 		$("#busiPattern").attr('value',$.trim(busiPattern));
			 		$("#busiValidDate").attr('value',$.trim(busiValidDate));
			 		$("#busiExpireDate").attr('value',$.trim(busiExpireDate));
			 		$("#busiCodeType option[value='"+$.trim(busiCodeValue)+"']").attr("selected", true);
		 		
			 }); 
	 });           
}