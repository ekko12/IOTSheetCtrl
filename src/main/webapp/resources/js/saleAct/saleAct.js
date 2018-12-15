

function delConfirm(id,status){
	var postData = '';
	if(id){
		postData = 'hdSalesId='+id;
	} else {
		row = saleActTable.datagrid('getSelections');
		if(row.length < 1){
			$.dialog({
				lock: true,
				title: "提示",
			    content: '请选择您要删除的记录!',
			    cancelVal: '关闭',
			    cancel: true
			});
			return false;
		}			
		for(var i=0;i<row.length;i++){
			ids.push(row[i].hdSalesId);
		}
		postData='hdSalesId='+ ids.join('&hdSalesId=');
	}
	$.dialog.confirm('确定删除此记录?', function (r) {
       	if (r) {
       		deleteData(postData,status);
       	}
    });
}


function deleteData(postData,status){
	if(status == '2'){
		$.dialog({
			lock: true,
			title: "提示",
		    content: '下架后才允许删除!',
		    cancelVal: '关闭',
		    cancel: true
		});
		return false;
	}
	$.ajax({
		type : 'POST',
		url : 'salesAct/deleteActs.do',
		data : postData,
		datatype : 'json',
		success : function(msg) {
			if(msg.flag){
				saleActTable.datagrid('load',{});
			}
			$.dialog({
				lock: true,
				title: "Info",
			    content: msg.msg,
			    ok: function(){
			    	this.title('Prompt：').time(0.001);//0.001绉掑悗鍏抽棴
			    	return false;
			    }
			});
		}
	});
}


function upShelfSaleAct(hdSalesId) {
	$.dialog.confirm('是否上架当前活动?', function() {
        $.ajax({
            type : 'POST',
            url : 'salesAct/upShelfSaleAct.do',
            data : {
            	hdSalesId : hdSalesId
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

function downShelfSaleAct(hdSalesId) {
	$.dialog.confirm('是否下架当前活动?', function() {
        $.ajax({
            type : 'POST',
            url : 'salesAct/downShelfSaleAct.do',
            data : {
            	hdSalesId : hdSalesId
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

