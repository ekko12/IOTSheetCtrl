var tabData
var smsDG
$(document).ready(function(){
	tabData = $('#tabDetail').datagrid({
        url : 'smsweb/smsBusiAccess/getSmsAccessStepList.do?busiAccessId='+$("#hidAccessId").val(),
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'busiProcId',
	        columns :[[{
	            field : 'busiProcId',
	            align : 'left',
	            width : 20,
	            title : 'busiProcId',
	            hidden:true
	           
	        }, {
	            field : 'procId',
	            align : 'left',
	            width : 50,
	            title : 'procId',
	            hidden:true
	           
	        }, {
	            field : 'procStep',
	            align : 'left',
	            width : 50,
	            title : 'Processing steps'
	        }, {
	            field : 'procType',
	            align : 'left',
	            width : 50,
	            title : 'Processing type',
	            formatter: function(value,row,index){
	            	switch(value){
	            		case  2:
	            			return "Menu publish";
	            			break;
	            		case 3:
	            			return  "SMS publish";
	            			break;
	            		case 4:
	            			return "Parameter settings";
	            			break;
	            		case 5:
	            			return "SESSION sharing";
	            			break;
	            		case 6:
	            			return "Wait for the response";
	            			break;
	            		case 8:
	            			return "Port switch"
	            			break;
	            		case 9:
	            			return "Local classes call";
	            			break;
	            	}
					
				}
	        }, {
	            field : 'procCode',
	            align : 'left',
	            width : 50,
	            title : 'Business Code'
	        }, {
	            field : 'next',
	            align : 'left',
	            width : 50,
	            title : 'Next'
	        }, {
	            field : 'remarks',
	            align : 'left',
	            width : 100,
	            title : 'remark'
	        }, {
	            field : 'state',
	            align : 'left',
	            width : 50,
	            title : 'Status',
	            formatter: function(value,row,index){
				if (value=="U"){
					return "Valid";
					} else {
						return "Invalid";
					}
				}
	        }, {
	            field : 'control',
	            align : 'center',
	            width : 50,
	            title : 'Operations',
                    formatter : function(value, rowData, rowIndex) {
        				var array=[];
        				array.push('<a href="javascript:;" onclick="editSmsAccessStep('+rowData.busiProcId+','+rowIndex+','+rowData.procId+')" class="operButton" title="EDIT"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="EDIT" /></a>');
        				array.push('<a href="javascript:;" onclick="delSmsAccessStep('+rowData.busiProcId+')" class="operButton" title="del"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="EDIT" /></a>');
        				return array.join('');
        				
        			}        		
        		} ] ],
        		onLoadSuccess: function (data) {
        			tabData.datagrid('clearSelections'); 
        		}
        	});



	$("#closeSmsAccessStepDiv").on("click",function(){
		$("#smsProc").hide();
	});
	/**************增加步骤参数*******************/
	$("#addSmsAccessStep").on("click",function(){
		var len=$('#tabSmsAccessStep tr').length; 
		var htmlstr="<tr><input type='hidden'  id='paramId' name='paramId' value='0' />";
		htmlstr= htmlstr+"<td ><input type='text'  id='parmCode' name='parmCode' class='input inputclass' style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><input type='text'  id='parmName' name='parmName' class='input inputclass' style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><input type='text'  id='parmGetValue' name='parmGetValue' class='input inputclass' style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><input type='text' id='parmType' name='parmType' class='input inputclass' style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><input type='text' id='parmSort' name='parmSort' class='input inputclass' style='width:60px'/></td>";
		htmlstr= htmlstr+"<td ><select id='parmSource' name='parmSource'style='width:60px' ><option value='IN'>Input</option><option value='OUT'>Output</option></select></td>";
		htmlstr= htmlstr+"<td ><img alt='delete'  onclick='removeTr(this)' src='resources/easyui13/themes/gray/images/button/btn_del.gif'></td></tr>"
		$("#tabSmsAccessStep>tbody tr:last").after(htmlstr);
	
	});
	/***********步骤保存操作 ******/
	$("#saveAccessStep").on("click",function(){
		var smsAccessProcStep = $("#smsAccessProcStep").val();		
		var smsAccessProcType=$("#smsAccessProcType").val();	
		var smsAccessProcCode=$("#smsAccessProcCode").val();		
		var smsAccessProcNextStep=$("#smsAccessProcNextStep").val();
		var remarks=$("#remarks").val();
		var busiAccessId = $("#hidAccessId").val();
				
		if(checkIsNull("smsAccessProcStep","step")==false) return false;
		if(checkIsNull("smsAccessProcType","type")==false) return false;
		if(busiAccessId=="" || busiAccessId==undefined){
			alertDialog("","No instruction ID, cannot manipulate the data！")
			//alert("No instruction ID, cannot manipulate the data！");
			return false;
		}
		if(smsAccessProcType==9 || smsAccessProcType==3 || smsAccessProcType==8){
			if(checkIsNull("smsAccessProcCode","code")==false) return false;
			$("#smsAccessProcCode").focus();
			if(smsAccessProcType==8 && $.isNumeric("smsAccessProcType")==false){alert("Port conversion, code must be numeric.!");return false;}
		}
		
		$.post(rootPath+"/smsweb/smsBusiAccess/saveAccessCfgStepData.do",$('#smsAccessFormStempContent').serialize())
		.success(function(data) { 
			alertDialog("","No instruction ID, cannot manipulate the data！")
			//alert("save  success");
			$("#smsAccessFormStempContent").hide();
			var busiAccessId=$("#hidAccessId").val();
			if(data==""||data=="undefined"){
				alertDialog("","Instruction is empty, cannot be increased next step！")
				//alert("Instruction is empty, cannot be increased next step！");
				location.href=rootPath+"/smsweb/smsBusiAccess/getSmsAccessStepList.do";
			}
			location.href=rootPath+"/smsweb/smsBusiAccess/smsAccessCfgOfStep.do?busiAccessId="+busiAccessId;
		})
   		.error(function() { alert("error"); });
	});
	
	/**************增加窗口*******************/
//	$("#addSmsAccessStepContent").on("click",function(){
//		initStepData();
//		$("#smsProc").show();
//		$("#smsAccessProcType").on("change",function(){
//			var selV = $(this).children('option:selected').val();
//			if(selV==""){return false;}
//			$('input[name=smsAccessProcCode]').attr("value","");
//			switch(parseInt(selV)){
//				case 3:
//					$("#addSelBtn").html("<a href='javascript:operWin("+selV+");' class='button3'  id='selAccessStepOfType'  >选择</a>");
//					break;
//				case 9:
//					$("#addSelBtn").html("<a href='javascript:operWin("+selV+");' class='button3'  id='selAccessStepOfType'  >选择</a>");
//					break;
//				case 8:
//					$('input[name=smsAccessProcCode]').removeAttr("readonly");
//					$("#addSelBtn").empty();
//					break;
//				default:
//					$('input[name=smsAccessProcCode]').removeAttr("readonly");
//					$("#addSelBtn").empty();
//			}			
//		});
//	});
	$("#addSmsAccessStepContent").on("click",function(){
		var busiAccessId = $("form [name='hidAccessId']").val();
		var addUrl=rootPath+'/smsweb/smsBusiAccess/toAddStepParam.do?busiAccessId='+busiAccessId;
	   	smsDG = $.dialog({
			title:"New step(s)",
		    content:'url:'+addUrl,
		    cancelVal: 'close',
		    cancel: true,
		    button: [
				        {
				            name: 'Confirm',
				            callback:function(){
				            	smsDG.content.save();
					            return false;
				            },
				            focus: true
				        }
				    ],
		    lock:false,
		    height:550,
		    width:700
		});
	});
	
	$("#saveSmsDemo").on("click",function(){
		$.dialog({
            title : '提示',
            content : "save  success",
            cancelVal : '关闭',
            cancel : function() {
                lock.close();
                return true;
            }
        });
		//alert("save  success");
		window.location.href="smsweb/smsBusiAccess/toSmsAccessList.do";
	});
});

function alertDialog(id,msg){
	$.dialog({
        title : '提示',
        content : msg,
        cancelVal : '关闭',
        cancel : function() {
        	if(id!=""){
        		$("#"+id).focus();
        	}        	
            return true;
        }
    });
	
}

$("#querStepyData").click(function() {
        queryData();
});
//添加步骤
function operWin(type){
	 $.dialog({
         title : 'Select content',
         content : "url:smsweb/smsBusiAccess/selAccessStepOfType.do",
         data:type,
         zIndex:9999
     })
}

function validate(id,msg){
    var reg = new RegExp("^[0-9]*$");
    var obj = $("#"+id);
    if(!reg.test(obj.value)){
    	alertDialog("",msg);
    	//alert(msg);
        return false;
    }
    return true;
}
function queryData() {
   $('#tabDetail').datagrid('load', {
        procId : $.trim($("#procId").val()),
        procCode : $.trim($("#procCode").val())
    });
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
			 			busiPattern = busiPattern.text();
			 		}
			 		var busiValidDate = $("td:eq(1)",$(this));
			 		if(busiValidDate.text() !=""){
			 			busiValidDate =busiValidDate.text();
			 		}
			 		var busiExpireDate = $("td:eq(2)",$(this));
			 		if(busiExpireDate.text() !=""){
			 			busiExpireDate=busiExpireDate.text();
			 		}
			 		var busiCodeType = $("td:eq(3)",$(this));
			 		if(busiCodeType.text() !=""){
			 			busiCodeType = busiCodeType.text();
			 		}
			 		var busiCodeValue = myRows.find("input[id='hidbusiCodeType']").eq(i-1).val();
			 		
			 		$('#smsPattern').show();
			 		$("#busiPattern").attr('value',busiPattern);
			 		$("#busiValidDate").attr('value',busiValidDate);
			 		$("#busiExpireDate").attr('value',busiExpireDate);
			 		$("#busiCodeType option[value='"+busiCodeValue+"']").attr("selected", true);
			 }); 
	 });           
}
function checkIsNull(id,msg)
{
 	if($.trim($("#"+id).val())==""){ 		 
 		alertDialog(id,"【"+msg+"】Cannot be empty！");
  		//alert("【"+msg+"】Cannot be empty！");
  		return false;
	}
 		return true;
}
function alertDialog(id,msg){
	$.dialog({
        title : '提示',
        content : msg,
        cancelVal : '关闭',
        height:100,
	    width:250,
        cancel : function() {
        	$("#"+id).focus();
            return true;
        }
    });
	
}

function initData(){
	$("#busiPattern").attr('value','');
	$("#busiValidDate").attr('value','');
	$("#busiExpireDate").attr('value','');
	$("#busiCodeType").attr('value','');
	$("#cmd").attr('value','');
	$("#timeOut").val("1200");
}
function initStepData(){
	$("#smsAccessFormStempContent")[0].reset();
}


function editSmsAccessStep(busiProcId,rowIndex,procID){
	var busiAccessId = $("#hidAccessId").val();
   	var editUrl=rootPath+'/smsweb/smsBusiAccess/toModifyStepParam.do?busiProcId='+busiProcId+'&busiAccessId='+busiAccessId;
   	smsDG = $.dialog({
		title:"Modify step",
	    content:'url:'+editUrl,
	    cancelVal: '关闭',
	    cancel: true,
	    button: [
			        {
			            name: '确定',
			            callback:function(){
			            	smsDG.content.save();
				            return false;
			            },
			            focus: true
			        }
			    ],
	    lock:false,
	    height:550,
	    width:700
	});
}
//delete process step
function delSmsAccessStep(busiProcId){
	 $.dialog({
			title:"delete step",
		    content:"please comfirm delete !",
		    cancelVal: '关闭',
		    cancel: true,
		    button: [
				        {
				            name: '确定',
				            callback:function(){
				            	ajaxDel(busiProcId);
					            return false;
				            },
				            focus: true
				        }
				    ],
		    lock:false,
		    height:100,
		    width:100
		});   	
}
function ajaxDel(param1)
{
	var busiAccessId = $("#hidAccessId").val();
   	$.post(rootPath+'/smsweb/smsBusiAccess/delStepParam.do?busiProcId='+param1+'&busiAccessId='+busiAccessId)
	.success(function(data) {
		if(data==""||data=="undefined" || data==false){
			alertDialog("","delete fail！")
			location.href=rootPath+"/smsweb/smsBusiAccess/smsAccessCfgOfStep.do";
		}
		alertDialog("","delete success！")
		location.href=rootPath+"/smsweb/smsBusiAccess/smsAccessCfgOfStep.do?busiAccessId="+busiAccessId;
	})
	.error(function() { alert("delete error"); });
  }