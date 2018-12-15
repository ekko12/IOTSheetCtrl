	var setting = {
			 check: {
				enable: true,
	            chkStyle : "radio",
	            radioType : "all"
			},
			view: {
				dblClickExpand: false
			}, 
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick: onClick,
				onCheck: onCheck
			}
		};

	function onClick(e, treeId, treeNode) {
		$("#classId").val(treeNode.id);
		var id  = $("#classId").val();
		var zTree = $.fn.zTree.getZTreeObj("classTree");
		zTree.checkNode(treeNode, !treeNode.checked, null, true);
		getKeyword(id);
		return false;
	}

	function onCheck(e, treeId, treeNode) {
		$("#classId").val(treeNode.id);
		var id  = $("#classId").val();
		var zTree = $.fn.zTree.getZTreeObj("classTree"),
		nodes = zTree.getCheckedNodes(true),
		v = "";
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		var cityObj = $("#className");
		cityObj.attr("value", v);
		getKeyword(id);
		hideMenu("menuContent");
	}

	/**商品品类树数据加载*/
	function showMenu() {
		var cityObj = $("#className");
		var cityOffset = $("#className").offset();
		$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	  
	   $.ajax({
	    	type : 'POST',
	    	url : rootPath+'/productClass/getTreeList.do?classType=goodsType',
	    	datatype : 'text',
	    	success : function(result) {
	    		if(result!=null){
	    			$.fn.zTree.init($("#classTree"), setting, result);
	    		}else{
	    			$.dialog.alert('No category!');
	    		}
	    	}
	    });
	}

	/**隐藏商品品类菜单*/
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	
	function onBodyDown(event) {
		if (!(event.target.id == "className" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}

	var productDG=null;
	/**异步加载商品品类及关键字*/
	function getKeyword(id){
		productDG=$('#productDG').datagrid({
		url : rootPath+'/evaluate/keyword/getEvaKeywordsList.do?classIds='+id,
		fit : true,
		nowrap : true,
		fitColumns : true,
		pagination : true,
	    rownumbers : true,
	    singleSelect : true,
	    sortName : 'id',
	    sortOrder : 'asc',
	    pageSize : 10,
	    pageList : [10, 20, 30, 40, 50],
		idField : 'id',
		

		columns : [ [ {
			field : 'id',
			checkbox : true
		},{
			field : 'name',
			align : 'center',
			width : 50,
			title : '评价关键词'
		},{
			field : 'control',
			align : 'center',
			width : 30,
			title : '操作',
			formatter : function(value, rowData, rowIndex){
				var array=[];
				array.push('<a href="javascript:void(0);" onclick="show('+rowData.id+',2)"  class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修改" /></a>');
				if(rowData.status == '1'){
					array.push('<a href="javascript:void(0);" onclick="deleteLogical('+rowData.id+')"  class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="禁用" /></a>');
					
				}else{
					array.push('<a href="javascript:void(0);" onclick="recover('+rowData.id+')"  class="operButton" title="恢复"><img src="resources/easyui13/themes/gray/images/button/btn_renew.gif" alt="恢复" /></a>');
				}
				return array.join('');
			}
		} ] ],
		toolbar: [{
			text : "上移",
			iconCls: 'icon-add',
			handler: function(isUp){ 
				MoveUp();
			}
		},'-',{
			text : "下移",
			iconCls: 'icon-remove',
			handler: function(){
				MoveDown();
			}
		}],
		onLoadSuccess: function (data) {
			productDG.datagrid('clearSelections'); 
		} 
	});
		
	}
	//上移
	function MoveUp() {
	    var row = productDG.datagrid('getSelected'); 
	    var index = productDG.datagrid('getRowIndex', row);
	    mysort(index, 'up', 'productDG');
	}
	//下移
	function MoveDown() {
	    var row = productDG.datagrid('getSelected');
	    var index = productDG.datagrid('getRowIndex', row);
	    mysort(index, 'down', 'productDG');
	}
	
	function mysort(index, type, gridname) {
	    if ("up"== type) {
	        if (index != 0) {
	            var toup = $('#' + gridname).datagrid('getData').rows[index];
	            var todown = $('#' + gridname).datagrid('getData').rows[index - 1];
	            $('#' + gridname).datagrid('getData').rows[index] = todown;
	            $('#' + gridname).datagrid('getData').rows[index - 1] = toup;
	            $('#' + gridname).datagrid('refreshRow', index);
	            $('#' + gridname).datagrid('refreshRow', index - 1);
	            $('#' + gridname).datagrid('selectRow', index - 1);
	        }
	    } else if ("down"== type) {
	        var rows = $('#' + gridname).datagrid('getRows').length;
	        if (index != rows - 1) {
	            var todown = $('#' + gridname).datagrid('getData').rows[index];
	            var toup = $('#' + gridname).datagrid('getData').rows[index + 1];
	            $('#' + gridname).datagrid('getData').rows[index + 1] = todown;
	            $('#' + gridname).datagrid('getData').rows[index] = toup;
	            $('#' + gridname).datagrid('refreshRow', index);
	            $('#' + gridname).datagrid('refreshRow', index + 1);
	            $('#' + gridname).datagrid('selectRow', index + 1);
	        }
	    }
	 
	}
	
	//var api = frameElement.api, W = api.opener;
	/**保存关键字排序*/
	function doSubmit() {

		var ids = new Array();
		var data=productDG.datagrid('getData');
		var rows = data.rows;
		for(var i=0; i<rows.length; i++){
			ids.push(rows[i].id);
		}
		$.ajax({
			type: "POST",
			url: rootPath+'/evaluate/keyword/updateKeywordsSort.do?ids='+ids,
			//data: {ids:ids},
			dataType: "json",
			success: function(data){
				 if(data.flag){
					 	$.dialog.alert(data.msg);
					 	productDG.datagrid('load');
	                }else{
	                	$.dialog.alert(data.msg);
	                	return false;
	             }
			}
		});
	}
	
	/**弹出窗口，添加商品品类关键字*/
	function add(){
		var id  = $("#classId").val();
		var detailUrl=rootPath+'/evaluate/keyword/add.do?classId='+id;
		$.dialog({
			title:'添加商品品类关键字',
		    content:'url:'+detailUrl,
			lock: true,
			drag: false,
			resize: false,
		    width: '550px',
		    height: '300px',
		    close: function(event, ui) { productDG.datagrid('reload');}
		});
	}

	/**编辑关键字*/
	function show(id,type) {
	var detailUrl=rootPath+'/evaluate/keyword/getEvaKeywordDetail.do?id='+id+'&type='+type+'&language=zh_CN';
		$.dialog({
			title:"商品品类关键字修改",
		    content:'url:'+detailUrl,
		    lock:true,
		    height:300,
		    width:500,
		    zIndex:350
		});
	}

	/**逻辑删除，使关键字状态置为无效*/
	function deleteLogical(id) {
		var classId  = $("#classId").val();
		$.dialog.confirm('确定把商品品类关键字状态改为无效?', function() {
	        $.ajax({
	            type : 'POST',
	            url : rootPath+'/evaluate/keyword/deleteLogical.do',
	            data : {
	            	id : id
	            },
	            datatype : 'json',
	            success : function(data) {
	                if(data.flag){
	                	getKeyword(classId);
	                }else{
	                	$.dialog.alert(data.msg);
	                }
	            }
	        });
	    });
	}
	
	/**恢复关键字状态有效*/
	function recover(id) {
		var classId  = $("#classId").val();
		$.dialog.confirm('确定把商品品类关键字状态改为有效?', function() {
	        $.ajax({
	            type : 'POST',
	            url : rootPath+'/evaluate/keyword/recover.do',
	            data : {
	            	id : id
	            },
	            datatype : 'json',
	            success : function(data) {
	                if(data.flag){
	                	getKeyword(classId);
	                }else{
	                	$.dialog.alert(data.msg);
	                }
	            }
	        });
	    });
	}
	
	/**关闭*/
	function closeWin(){
		window.location.href = rootPath+'/evaluate/keyword/index.do';
	}
