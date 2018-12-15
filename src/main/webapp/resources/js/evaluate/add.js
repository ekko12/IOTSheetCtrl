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
		$("#className").val(treeNode.name);
		var zTree = $.fn.zTree.getZTreeObj("classTree");
		zTree.checkNode(treeNode, !treeNode.checked, null, true);
		return false;
	}
	
	function onCheck(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("classTree"),
		nodes = zTree.getCheckedNodes(true),
		v = "";
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		var cityObj = $("#className");
		cityObj.attr("value", v);
		hideMenu("menuContent");
	}
	
	/**产品包品类树数据加载*/
	function showMenu() {
		
		var cityObj = $("#className");
		var cityOffset = $("#className").offset();
		$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	  
	   $.ajax({
	    	type : 'POST',
	    	url : rootPath+'/product/getClassList.do',
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
	
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	
	function onBodyDown(event) {
		if (!(event.target.id == "className" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}


	var api = frameElement.api, W = api.opener;
	/**保存评价关键词*/
	function doSubmit() {
		
		var classId = $('#classId').val();
		if (null==classId || classId==''){
			$.dialog.alert('请先选择商品品类');
			return;
		}
		var keyword = $('#name').val();
		if (null==keyword || keyword==''){
			$.dialog.alert('关键词不能为空');
			$('#name').focus();
			return;
		}
		
		$.ajax({
			type : 'POST',
			url : rootPath+'/evaluate/keyword/saveEvaluateKeyword.do',
			data : $('#form1').serialize(),
			datatype : 'json',
			async : false,
			success : function(msg) {
				var flag = msg.flag;
				if(flag){
					api.close();
				}else{
					$.dialog.alert(msg.msg);
	                return false;
				}
			}
		});
	}


	function getNodes(){
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getCheckedNodes(true);
		if(nodes.length>0&&nodes[0].id!=-1){
		    nodes=nodes[0];
		} 
		var classIds=[];
		classIds=getChildren(classIds,nodes);
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

	/**关闭*/
	function closeWin() {
		api.close();
	}
