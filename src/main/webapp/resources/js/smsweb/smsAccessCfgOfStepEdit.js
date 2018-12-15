/**************增加步骤参数*******************/
$(function(){
	$("#addSmsAccessStep").on("click",function(){
		var htmlstr="<tr><input type='hidden'  id='paramId' name='paramId' value='0' />";
		htmlstr= htmlstr+"<td ><input type='text'  id='parmCode' name='parmCode' class='input inputclass easyui-validatebox'  data-options='required:true'   maxlength='128' style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><input type='text'  id='parmName' name='parmName' class='input inputclass easyui-validatebox' maxlength='20' style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><input type='text'  id='parmGetValue'    name='parmGetValue' class='input inputclass easyui-validatebox' maxlength='2000'    style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><input type='text' id='parmType' name='parmType' class='input inputclass easyui-validatebox' maxlength='20' style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><input type='text' id='parmSort' name='parmSort' maxlength=2 class='input inputclass easyui-validatebox '   onkeyup='javascript:onlyNum(this)'   style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><select id='parmSource' name='parmSource'style='width:60px' ><option value='IN'>Input</option><option value='OUT'>Output</option></select></td>";
		htmlstr= htmlstr+"<td ><img alt='delete'  onclick='removeTr(this)' src='resources/easyui13/themes/gray/images/button/btn_del.gif'></td></tr>";
		$("#tabSmsAccessStep>tbody tr:last").after(htmlstr);
		$.parser.parse($('#tabSmsAccessStep').parent());		
	});	
	/********************选择下拉框************************/
	$("#smsAccessProcType").on("change",function(){
			$("#addSelBtn").empty();
			var selV = $(this).children('option:selected').val();
			if(selV==""){return false;}
			$('input[name=smsAccessProcCode]').attr({readOnly:"true",value:""});
			switch(parseInt(selV)){
				case 3:
					$("#addSelBtn").html("<a href='javascript:operWin("+selV+");' class='button3'  id='selAccessStepOfType'  >select</a>");
					break;
				case 9:
					$("#addSelBtn").html("<a href='javascript:operWin("+selV+");' class='button3'  id='selAccessStepOfType'  >select</a>");
					break;
				case 8:
					$('input[name=smsAccessProcCode]').removeAttr("readOnly");
					$("#addSelBtn").empty();
					break;
				default:
					//$('input[name=smsAccessProcCode]').removeAttr("readonly");
					$("#addSelBtn").empty();
			}			
		});
	
	/***********步骤保存操作  此方法停用******/
	/*$("#saveAccessStep").on("click",function(){
		alert("my is save step");
		return false;
		var smsAccessProcStep = $("#smsAccessProcStep").val();		
		var smsAccessProcType=$("#smsAccessProcType").val();	
		var smsAccessProcCode=$("#smsAccessProcCode").val();		
		var smsAccessProcNextStep=$("#smsAccessProcNextStep").val();
		var remarks=$("#remarks").val();
		var busiProcId = $("#hidBusiProcId").val();
				
		if(checkIsNull("smsAccessProcStep","步骤")==false) return false;
		if(checkIsNull("smsAccessProcType","类型")==false) return false;
		
		if(smsAccessProcType==8){
			if(checkIsNull("smsAccessProcCode","编码")==false) return false;
			if(validate("smsAccessProcType","")==false){return false;}
		}
		$.post(rootPath+"/smsweb/smsBusiAccess/saveAccessCfgStepData.do",$('#smsAccessFormStempContent').serialize())
		.success(function() { 
			$.messager.alert('OK', 'save success');
			var api = frameElement.api, W = api.opener;
			api.reload();
			api.close(); 
			
		})
   		.error(function() { $.messager.alert('Error', '参数输入格式！'); });
	});	*/
});

/*$.extend($.fn.validatebox.defaults.rules, { 
	NON: { 
		validator: function(value, param){
		if($.trim(value) =="" && $.trim($(param[0]).val()) ==""){
			return false;
		}
		return true; 
		}, 
		message: 'Parameter value or parmSort must one is not null' 
		} 
	});*/
function save(){
	var smsAccessProcStep = $("#smsAccessProcStep").val();		
	var smsAccessProcType=$("#smsAccessProcType").val();	
	var smsAccessProcCode=$("#smsAccessProcCode").val();		
	var smsAccessProcNextStep=$("#smsAccessProcNextStep").val();
	var remarks=$("#remarks").val();
	var busiProcId = $("#hidBusiProcId").val();
	var busiAccessId = $("#hidAccessId").val();
	if(checkIsNull("smsAccessProcStep","next step")==false) return false;
	if(checkIsNull("smsAccessProcType","type")==false) return false;
	//cmd==1为增加，==2为修改
	if($("#cmd").val()==1){
		if(busiAccessId=="" || busiAccessId==undefined){
			alertDialog("","Instruction is empty, cannot be increased step!");
			//alert("Instruction is empty, cannot be increased step!");
			return false;
		}	
	}
	if($("#cmd").val()==2){
		if(busiProcId=="" && $.isNumeric(busiProcId)==false){
			alertDialog("","step is empty, cannot be increased step！");
			//alert("step is empty, cannot be increased step！");
			return false;
		}
	}
	if(smsAccessProcType==8){
		if(checkIsNull("smsAccessProcCode","code")==false) return false;
		if($.isNumeric($("#smsAccessProcCode").val())==false){ $.messager.alert('Error', '【code】encoding must be numeric.！'); return false};
		$("#hidsmsAccessProcCode").val($("#smsAccessProcCode").val());
	}
	
	var postJSON={data:JSON.stringify($('#smsAccessFormStempContent').serializeJson())};
	var formSerial = $('#smsAccessFormStempContent').serialize();
	var flag=true;
	$("#tabSmsAccessStep tr").each(function(index){ 
		if(index>0){
			var parmGetValue =  $("#parmGetValue",$(this));
			var parmSort = $("#parmSort",$(this));
			if(parmGetValue.val()=="" && parmSort.val()==""){
				alertDialog("","【sort by】or 【parmGetValue】 Cannot be empty！");
				flag=false;
				return false;
			}
			return true;
		}
	});
	if($('#smsAccessFormStempContent').form('validate')==true){
		if(flag==false){return false;}
		$.post(rootPath+"/smsweb/smsBusiAccess/saveAccessCfgStepData.do",formSerial)
		.success(function() { 
			$.messager.alert('OK', 'save success');
			var api = frameElement.api, W = api.opener;
			api.reload();
			
		}).error(function() { $.messager.alert('Error', 'input Parameters  error！');  });
		
	}	
}
function removeTr(obj){
	 $(obj).closest('tr').remove();
}
function checkIsNull(id,msg)
{
 	if($.trim($("#"+id).val())==""){
 		alertDialog(id,"【"+msg+"】Cannot be empty！");
  		return false;
	}
 		return true;
}
function alertDialog(id,msg){
	$.dialog({
        title : '提示',
        content : msg,
        cancelVal : '关闭',
        zIndex:9999,
        cancel : function() {
        	$("#"+id).focus();
            return true;
        }
    });
	
}
function operWin(type){
	 $.dialog({
         title : 'Select content',
         content : "url:smsweb/smsBusiAccess/selAccessStepOfType.do",
         data:type,
         zIndex:9999
     })
}

(function($){
	$.fn.serializeJson=function(){
	var serializeObj={};
	var array=this.serializeArray();
	var str=this.serialize();
	$(array).each(function(){
	if(serializeObj[this.name]){
	if($.isArray(serializeObj[this.name])){
	serializeObj[this.name].push(this.value);
	}else{
	serializeObj[this.name]=[serializeObj[this.name],this.value];
	}
	}else{
	serializeObj[this.name]=this.value;
	}
	});
	return serializeObj;
	};
})(jQuery);