var tabData
$(document).ready(function() {	
   tabData = $('#tabData').datagrid({
        url : 'smsweb/smsBusiAccess/getSmsBusiAccessList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'busiAccessId',
	        columns :[[{
	            field : 'busiAccessId',
	            align : 'left',
	            width : 50,
	            title : 'ID',
	            hidden:true
	        },{
	            field : 'name',
	            align : 'left',
	            width : 50,
	            title : 'Business name'
	        }, {
	            field : 'busiAccessCmd',
	            align : 'left',
	            width : 50,
	            title : 'Access instructions'
	        }, {
	            field : 'busiAccessCode',
	            align : 'left',
	            width : 50,
	            title : 'Business code'
	        }, {
	            field : 'regionId',
	            align : 'left',
	            width : 50,
	            title : 'Region',
	            hidden:true
	        }, {
	            field : 'brandId',
	            align : 'left',
	            width : 50,
	            title : 'Brand',
	            hidden:true
	        }, {
	            field : 'state',
	            align : 'left',
	            width : 50,
	            title : 'Status',
	            formatter: function(value,row,index){
					if (value=="U"){
						return "Available";
						} else {
							return "Unavailable";
						}
				}
	        
	        }, {
	            field : 'control',
	            align : 'center',
	            width : 30,
	            title : 'Operations',
                    formatter : function(value, rowData, rowIndex) {
        				var array=[];
        				if(SMS_BIZ_PROCESS_EDIT){
    						array.push('<a href="smsweb/smsBusiAccess/toModify.do?busiAccessId='+rowData.busiAccessId+'" class="operButton" title="edit"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="edit" /></a>');
        				}
        				return array.join('');
        			}
        		} ] ],
        		onLoadSuccess: function (data) {
        			tabData.datagrid('clearSelections'); 
        		}
        	}); 
   
	   /***************刷新短信缓存**************/
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
//					                location.href=rootPath+"/smsweb/smsBusiAccess/toSmsAccessList.do";
					                return false;
								})
								.error(function(error) { alert("刷新失败！"+error); });
				         	},
				            focus: true
				        }
				    ]
				});
		//		sms.get('smsID',1).content('加载完成').time(2);
		});
});
$("#btn_search").click(function() {
    queryData();
});   
  
function queryData() {
	
   $('#tabData').datagrid('load', {
        busiCmd : $.trim($("#busiCmd").val()),
        busiCode : $.trim($("#busiCode").val())
    });
}


function back(){
	location.href = rootPath+'/smsweb/smsTemplate/toSmsTemplateList.do';
}
