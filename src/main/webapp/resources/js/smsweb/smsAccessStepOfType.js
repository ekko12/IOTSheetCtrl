var productDG=null;
var setData;
var setting = {
			check: {
				enable: true
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};

$(function(){
	var listUrl,fileld01,fileld02,fileld03,fileld04,fileld01Title,fileld02Title,fileld03Title,fileld04Title
	setData = getData
	if(getData==3){
		listUrl='smsweb/smsTemplate/getSmsTemplateList.do';
		fileld01='msgTemplateId';
		fileld01Title='';
		fileld02='name';
		fileld02Title='Template Name';
		fileld03='state';
		fileld03Title='Status';
		fileld04='remarks';
		fileld04Title='Remark';
		
	}else if(getData==9){
		listUrl='smsweb/smsBusiAccess/getSmsAccessBuisList.do';
		fileld01='implClass';
		fileld01Title='Impl Class';
		fileld02='busiCode';
		fileld02Title='Business Code';
		fileld03='busiName';
		fileld03Title='Business Name';
		fileld04='state';
		fileld04Title='Status';
		
	}
	productDG=$('#productDG').datagrid({
	url : listUrl,
	fit : true,
	nowrap : true,
	fitColumns : true,
	pagination : true,
	rownumbers : true,
	pageSize : 10,
	pageList : [ 10, 20, 30, 40, 50 ],
	idField : fileld01,
	columns : [ [ {
		field : fileld01,
		checkbox:true
	}, {
        field : fileld02,
        align : 'left',
        width : 50,
        title : fileld02Title
    }, {
    	 field : fileld03,
         align : 'left',
         width : 50,
         title : fileld03Title
    }, {
    	 
        field : fileld04,
        align : 'left',
        width : 50,
        title : fileld04Title
    
	}] ],
	onLoadSuccess: function (data) {
		productDG.datagrid('clearSelections'); 
	}
});


$('#queryProductName').keypress(function(event) {
	if (event.keyCode == 13) {
		queryData();
		return false;
	}
});

	$(document).keyup(function(event){
	  if(event.keyCode ==13){
	    queryData();
	  }
	});


})

function queryData(){
	if(setData==3){
		productDG.datagrid('load',{			
				templateId:$('#queryProductName').val(),
				templateName:$('#citySel').val()
		});
	}
	if(setData==9){
		productDG.datagrid('load',{
				queryField01:$('#queryProductName').val(),
				queryField02:$('#citySel').val()
		});
	}
}
	

var api = frameElement.api
var W = api.opener;
var getData=api.data; //getData=3:短信下发;getData=9:本地类配置
api.button({
    name : 'OK',
    callback : confirmSelect,
    focus : true
}, {
    name : 'Cancel'
});
	
	/**
	 * 选择确定后的回调函数处理(返回对象,交由所调用的页面处理)
	 * @return
	 */
	function confirmSelect() {
        var rows = $('#productDG').datagrid('getSelections');
        for (var i = 0; i < rows.length; i++) {
        	if(getData==3){
        		W.document.getElementById('smsAccessProcCode').value = rows[i].msgTemplateId+"_"+rows[i].name;
        		W.document.getElementById('hidsmsAccessProcCode').value= rows[i].msgTemplateId;
        	}
        	if(getData==9){
        		W.document.getElementById('smsAccessProcCode').value = rows[i].busiCode+"_"+rows[i].busiName;
        		W.document.getElementById('hidsmsAccessProcCode').value= rows[i].busiCode; 
        	}
        	 
        }
    }
	
	