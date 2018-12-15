var tabData;
var smsTab;
$(document).ready(function() {
	
   tabData = $('#tabData').datagrid({
        url : 'smsweb/smsTemplate/getSmsTemplateList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'msgTemplateId',
        columns : [[{
                    field : 'msgTemplateId',
                    align : 'left',
                    width : 50,
                    title : 'ID',
                    hidden:true
                }, {
                    field : 'name',
                    align : 'left',
                    width : 50,
                    title : 'Template Name'
                }, {
                    field : 'remarks',
                    align : 'left',
                    width : 50,
                    title : 'Remark'
                }, {
                    field : 'state',
                    align : 'left',
                    width : 50,
                    title : 'Availability',
                    formatter: function(value,row,index){
        				if (value=="U"){
        					return "Valid";
        					} else {
        						return "Invalid";
        					}
        				}

                }, {
                    field : 'createDate',
                    align : 'left',
                    width : 50,
                    title : 'Create Time', 
                    hidden:true
                }, {
                    field : 'control',
                    align : 'center',
                    width : 30,
                    title : 'Operations',
                    formatter : function(value, rowData, rowIndex) {
        				var array=[];
        				if(SMS_BIZ_TEMPLATE_EDIT){
    						array.push('<a href="smsweb/smsTemplate/toModify.do?opType=2&templateId='+rowData.msgTemplateId+'" class="operButton" title="Modify"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修    改" /></a>');
        				}
						if(SMS_BIZ_TEMPLATE_DELETE){
							array.push('<a href="javascript:void(0);" onclick="del(\''+rowData.msgTemplateId+'\');" class="operButton" title="Delete"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="Delete" /></a>');
						}
        				return array.join('');
        			}
        		} ] ],
        		onLoadSuccess: function (data) {
        			tabData.datagrid('clearSelections'); 
        		}
        	});
   
   $("#btn_search").click(function() {
       queryData();
   });
$("#flushCache").on("click",function(){
	var sms=$.dialog({
		    id: 'smsID',
		    title:'SMS Business Office refresh the cache',
		    content: 'Click【 OK】 to refresh the cache of SMS business office！',
		    lock: true,
		    background: '#000', 
		    opacity: 0.5, 
		    button: [
		        {
		            name: 'OK',
		            callback: function () {
		            	this.content('Loading is complete').time(2);
		            	$.post(rootPath+"/smsweb/smsBusiAccess/smsFlushCache.do")
						.success(function() { 								
			                return false;
						})
						.error(function(error) { alert("刷新失败！"+error); });
		         	},
		            focus: true
		        }
		    ]
		});
});

$(document).keyup(function(event){
	  if(event.keyCode ==13){
	    queryData();
	  }
	});
        });
   
  
function queryData() {
	
   $('#tabData').datagrid('load', {
        templateId : $.trim($("#templateId").val()),
        templateName : $.trim($("#templateName").val())
    });
}


function add(){
	location.href=rootPath+"/smsweb/smsTemplate/toModify.do?opType=1"; 
}

function del(templateId) {
	
	$.dialog.confirm('Confirm to delete this record?', function() {
        $.ajax({
            type : 'POST',
            url : 'smsweb/smsTemplate/delSmsTemplate.do',
            data : {
                templateId : templateId
            },
            datatype : 'json',
            success : function(msg) {
                if (msg.flag) {
                    queryData();
                }
                $.dialog.alert(msg.msg);
            }
        });
    });
  
}

function addDtl(title,opType,trId){
	
	var url = "url:smsweb/smsTemplate/toSmsDtl.do?opType="+opType;
	var params="";
	if(opType==2){
		
		params = "&msgTemplateDtlId=" + $("#tr_"+trId+" td:nth-child(1)").html();
	    params += "&expr=" + dealSpecialChar($("#tr_"+trId+" td:nth-child(2)").html());
	    params += "&contentEn=" + encodeURIComponent($("#tr_"+trId+" td:nth-child(3)").html());
	    params += "&contentCn=" + encodeURIComponent($("#tr_"+trId+" td:nth-child(4)").html());
	    params += "&contentJpz=" + encodeURIComponent($("#tr_"+trId+" td:nth-child(5)").html());
	    params += "&remarks=" + $("#tr_"+trId+" td:nth-child(6)").html();
	    params += "&state=" + $("#tr_"+trId+" td:nth-child(7)").html();
	    url += params;
	}
	console.info(params);
	smsTab = $.dialog({
        title : title,
        min : false,
        max : false,
        zIndex : 2000,
        lock : true,
        drag : false,
        resize : false,
        width:800,
    	height:470,
        content : url
    });	
}


function setDataToTable(dtl){
	var len=$('#tabDetail tr').length;
	var htmlText=[];
	var flag=false;//用来判断是否有重复
	htmlText.push('<tr id="tr_',len,'" class="trC">');
	var tid = "";
	if(dtl.dtlId==""){
		tid = len;
	}else{
		tid = dtl.dtlId;
	}
	htmlText.push('<td class="tdT" style="display:none;">',tid,'</td>');
	htmlText.push('<td class="tdC">',dtl.expr,'</td>');
	htmlText.push('<td>',dtl.content_en,'</td>');
	htmlText.push('<td>',dtl.content_cn,'</td>');
	htmlText.push('<td>',dtl.content_jpz,'</td>');
	htmlText.push('<td>',dtl.dtlRemark,'</td>');
	htmlText.push('<td style="display:none;">',dtl.dtlState,'</td>');
	var stateText = "";
	if(dtl.dtlState=="E"){
		stateText = "Invalid"
	}else{
		stateText = "Valid"
	}
	
	htmlText.push('<td>',stateText,'</td>');
	htmlText.push('<td><a href="javascript:void(0);" class="operButton" onclick="addDtl(\'Modify\',2,',tid,')"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="Modify" /></a><a href="javascript:void(0);" class="operButton" onclick="deleteTr(',tid,')"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="Delete" /></a></td>');
	htmlText.push('</tr>');
	
	  $('#tabDetail tr').each(function () {
		  if($(this).children('td').eq(0).text()==tid){
			 $(this).children('td').eq(1).html(dtl.expr);
			 $(this).children('td').eq(2).html(dtl.content_en);
			 $(this).children('td').eq(3).html(dtl.content_cn);
			 $(this).children('td').eq(4).html(dtl.content_jpz);
			 $(this).children('td').eq(5).html(dtl.dtlRemark);
			 $(this).children('td').eq(6).html(dtl.dtlState);
			 $(this).children('td').eq(7).html(stateText);
			 flag = true;
			 return false;
		  }
      });
	  
	  if(flag){
		  return;
	  }
	
	if(!flag){
		$('#tabDetail').append(htmlText.join(''));
	}
}

function deleteTr(id){
	$('#tr_'+id).remove();
}


$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

function getTableJson(){
	var temp = "";
	var tabLen = document.getElementById("tabDetail");
	var jsonT = "\"dtlList\":[";
	for ( var i = 1; i < tabLen.rows.length; i++) {
			jsonT += "{\"msgTemplateDtlId\":\""+ tabLen.rows[i].cells[0].innerHTML;
			jsonT+= "\",\"expr\":\""+ tabLen.rows[i].cells[1].innerHTML 
			+ "\",\"contentEn\":\""+tabLen.rows[i].cells[2].innerHTML
			+ "\",\"contentCn\":\""+tabLen.rows[i].cells[3].innerHTML
			+"\",\"contentJpz\":\""+tabLen.rows[i].cells[4].innerHTML
			+"\",\"remarks\":\""+ tabLen.rows[i].cells[5].innerHTML
			+"\",\"state\":\""+ tabLen.rows[i].cells[6].innerHTML+"\"";
			jsonT+="},";
	}
	if(jsonT.lastIndexOf(",")==jsonT.length-1){
		jsonT = jsonT.substring(0, jsonT.length-1);
	}
	jsonT += "]";
	return jsonT;
}

function save(){
	var templateName=$('#name').val();
	var remark = $('#remarks').val();
	var msgTemplateId = $('#msgTemplateId').val();
	var state = $("#state").val();
	if (templateName == null || templateName == "") {
        $.dialog({
            title : 'Prompt',
            content : "Template name can not be empty！",
            cancelVal : 'Close',
            cancel : function() {
                return true;
            }
        });
        return false;
    }
	var params = {};
	params.msgTemplateId =msgTemplateId==""?-1:msgTemplateId;
	params.name =templateName;
	params.remarks = remark;
	params.state = state;
	
	var temp = "";
	var tabLen = document.getElementById("tabDetail");
	
	for ( var i = 1; i < tabLen.rows.length; i++) {
		params['dtlList['+(i-1)+'].msgTemplateDtlId'] = tabLen.rows[i].cells[0].innerHTML;
		params['dtlList['+(i-1)+'].expr'] = dealSpecialChar(tabLen.rows[i].cells[1].innerHTML);
		params['dtlList['+(i-1)+'].contentEn'] = tabLen.rows[i].cells[2].innerHTML;
		params['dtlList['+(i-1)+'].contentCn'] = tabLen.rows[i].cells[3].innerHTML;
		params['dtlList['+(i-1)+'].contentJpz'] = tabLen.rows[i].cells[4].innerHTML;
		params['dtlList['+(i-1)+'].remarks'] = tabLen.rows[i].cells[5].innerHTML;
		params['dtlList['+(i-1)+'].state'] = tabLen.rows[i].cells[6].innerHTML;
	}
	console.info(params);
	$.ajax({
		type : 'post',
		url : 'smsweb/smsTemplate/modifySmsTemplate.do',
		data : params,
		success : function(msg) {
			if (msg.flag) {
				$.dialog({
					title:'Prompt',
					content : msg.msg,
					ok : function() {
						back();
					},
					lock : true
				});
			}
		}
	});
	
}

function back(){
	location.href = rootPath+'/smsweb/smsTemplate/toSmsTemplateList.do';
}

function dealSpecialChar(str){
	return str.replace(/&amp;/g,"＆").replace(/&lt;/g,"《").replace(/&gt;/g,"》");
}


