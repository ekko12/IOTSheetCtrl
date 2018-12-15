var productDG=null;

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
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		}

		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getCheckedNodes(true),
			v = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var cityObj = $("#citySel");
			cityObj.attr("value", v);
			hideMenu("menuContent");
		}
		
		/**显示商品品类菜单*/
		function showMenu() {
			var cityObj = $("#citySel");
			var cityOffset = $("#citySel").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		/**隐藏商品品类菜单*/
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "citySel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		
		/**商品品类树形数据加载*/
		function getClassTree(){
			$.ajax({
			        type : 'POST',
			        url : rootPath+'/productClass/getTreeList.do?classType=goodsType',
			        //data:{language:language},
			        datatype : 'text',
			        success : function(result) {
			        	if(result != null){
			        		$.fn.zTree.init($("#treeDemo"), setting, result);
			        	}else{
			        		$.dialog.alert('No category!');
			        	}
			        }
			});
		}

	/**异步加载商品品类及关键字*/
	$(function(){
		productDG=$('#productDG').datagrid({
		url : rootPath+'/evaluate/keyword/getEvaKeywordsList.do',
		//queryParams:{status:"1"},
		fit : true,
		nowrap : true,
		fitColumns : true,
		pagination : true,
	    rownumbers : true,
	    pageSize : 10,
	    pageList : [10, 20, 30, 40, 50],
		idField : 'id',
		columns : [ [ {
			field : 'id',
			checkbox:true,
		},{
			field : 'className',
			align : 'center',
			width : 50,
			title : '商品品类'
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
					array.push('<a href="javascript:void(0);" onclick="show('+rowData.id+',1)"  class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
					array.push('<a href="javascript:void(0);" onclick="show('+rowData.id+',2)"  class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修改" /></a>');
				if(rowData.status == '1'){
						array.push('<a href="javascript:void(0);" onclick="deleteLogical('+rowData.id+')"  class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="禁用" /></a>');
				}else{
						array.push('<a href="javascript:void(0);" onclick="recover('+rowData.id+')"  class="operButton" title="恢复"><img src="resources/easyui13/themes/gray/images/button/btn_renew.gif" alt="恢复" /></a>');
				}
				return array.join('');
			}
		} ] ],
		onLoadSuccess: function (data) {
			productDG.datagrid('clearSelections'); 
		} 
	});
	
	
	})

	/**搜索*/
	function queryData(){
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getCheckedNodes(true);
		if(nodes.length>0&&nodes[0].id!=-1){
		    nodes=nodes[0];
		} 
		var classIds=[];
		classIds=getChildren(classIds,nodes);
		
		productDG.datagrid('load',{
			classIds:classIds.join(","),
			
		});
	}

	function getChildren(ids,treeNode){
	   ids.push(treeNode.id);
	   if (treeNode.isParent){
	      for(var obj in treeNode.children){
	         getChildren(ids,treeNode.children[obj]);
	      }
	   }
	   return ids;
	}

	/**跳转到新增关键字页*/
	function addKeyword(){
		window.location.href = rootPath+'/evaluate/keyword/addKeyword.do';
	}

	/**查看关键字详情*/
	function show(id,type) {
	var detailUrl=rootPath+'/evaluate/keyword/getEvaKeywordDetail.do?id='+id+'&type='+type+'&language=zh_CN';
		$.dialog({
			title:getTitle(type),
		    content:'url:'+detailUrl,
		    lock:true,
		    height:300,
		    width:500,
		    zIndex:350
		});
	}

	function getTitle(type){
		   if(type==1){
		       return "商品品类关键字详情";
		   }
		   if(type==2){
		       return "商品品类关键字修改";
		   }
	}

	function hide(id) {
		var divid = "" + id;
		divid = "#" + divid;
		$(divid).hide();
	}
		
	getClassTree();
	
	$("#className").click(function() {
        showMenu("className", "menuContent");
    });


	/**逻辑删除，使关键字状态置为无效*/
	function deleteLogical(id) {
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
	                    queryData();
	                }else{
	                	$.dialog.alert(data.msg);
	                }
	            }
	        });
	    });
	}
	
	/**恢复关键字状态有效*/
	function recover(id) {
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
	                	queryData();
	                }else{
	                	$.dialog.alert(data.msg);
	                }
	            }
	        });
	    });
	}