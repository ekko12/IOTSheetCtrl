var tabData
$(document).ready(function() {
   tabData = $('#tabData').datagrid({
        url : 'smsweb/smsbusi/getSmsBuisList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'busiCode',
        columns : [[{
                    field : 'busiCode',
                    align : 'left',
                    width : 50,
                    title : 'Business Code'
                }, {
                    field : 'busiName',
                    align : 'left',
                    width : 50,
                    title : 'Business Name'
                }, {
                    field : 'implClass',
                    align : 'left',
                    width : 50,
                    title : 'Implementation class'
                }, {
                    field : 'implMethod',
                    align : 'left',
                    width : 50,
                    title : 'Implementation method'
                }, {
                    field : 'createDate',
                    align : 'left',
                    width : 50,
                    title : 'Create time' ,
                    hidden:true
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
                    field : 'control',
                    align : 'center',
                    width : 30,
                    title : 'Operations',
                    formatter : function(value, rowData, rowIndex) {
        				var array=[];
        				if(SMS_BIZ_CONFIG_EDIT){
    						array.push('<a href="smsweb/smsbusi/toSmsBusiModify.do?opType=2&busiCode='+rowData.busiCode+'" class="operButton" title="Modify"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="Modify" /></a>');
        				}
        				if(SMS_BIZ_CONFIG_DELETE){
    						array.push('<a href="javascript:void(0);" onclick="del(\''+rowData.busiCode+'\');" class="operButton" title="Delete"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="Delete" /></a>');
        				}
        				
        				return array.join('');
        			}
        		} ] ],
        		onLoadSuccess: function (data) {
        			tabData.datagrid('clearSelections'); 
        		}
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
   			
        })
    $("#btn_search").click(function() {
        queryData();
    });
   

  
function queryData() {
	
   $('#tabData').datagrid('load', {
        busiCode : $.trim($("#busiCode").val()),
        busiName : $.trim($("#busiName").val())
    });
}


function del(busiCode) {
	
	$.dialog.confirm('Confirm to delete this record?', function() {
        $.ajax({
            type : 'POST',
            url : 'smsweb/smsbusi/delSmsBusi.do',
            data : {
                busiCode : busiCode
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
function save() {
    var code = $.trim($("#busiCode").val());
    if (code == "" || code == null) {
        $.dialog({
            title : '提示',
            content : 'Business code can not be empty！',
            cancelVal : 'Close',
            zIndex : 9999,
            cancel : function() {
                return true;
            }
        });
        return false;
    }
    var name = $.trim($("#busiName").val());
    if (name == "" || name == null) {
        $.dialog({
            title : '提示',
            content : 'Business name can not be empty！',
            cancelVal : 'Close',
            zIndex : 9999,
            cancel : function() {
                return true;
            }
        });
        return false;
    }
    
    var implClass = $.trim($("#implClass").val());
    if (implClass == "" || implClass == null) {
        $.dialog({
            title : '提示',
            content : 'Implementation class can not be empty！',
            cancelVal : 'Close',
            zIndex : 9999,
            cancel : function() {
                return true;
            }
        });
        return false;
    }
    var implMethod = $.trim($("#implMethod").val());
    if (implMethod == "" || implMethod == null) {
        $.dialog({
            title : '提示',
            content : 'Implementation method can not be empty！',
            cancelVal : 'Close',
            zIndex : 9999,
            cancel : function() {
                return true;
            }
        });
        return false;
    }
    
    var state = $("#state").val();
    var opType =  $("#opType").val();

    $.ajax({
        type : 'POST',
        url : 'smsweb/smsbusi/saveSmsBusi.do',
        data : {
            busiCode : code,
            busiName : name,
            implClass : implClass,
            implMethod:implMethod,
            state:state,
            opType:opType
        },
        datatype : 'json',
        success : function(msg) {
        	 // 提示信息
            $.dialog({
                title : '提示',
                content : msg.msg,
                cancelVal : 'Close',
                cancel : function() {
                    return true;
                }
            });
            if (msg.flag) {
            	location.href=rootPath+"/smsweb/smsbusi/toSmsBusiCfg.do"
            }
        }
    });
}

function add(){
	location.href=rootPath+"/smsweb/smsbusi/toSmsBusiModify.do?opType=1"; 
}
