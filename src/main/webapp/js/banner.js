//上传文件
function uploadAttach() {
	if ($("#uploaded").val()==null||$("#uploaded").val().trim()=="") {
        $.jBox.error("图片不能为空", '提示');
		return false;
	}
			$.ajaxFileUpload({
				url: 'bannerInfo/uploadPic.do' ,
	            secureuri: false,
	            type:'post',
	            dataType:'text',
	            fileElementId: 'uploaded',
	            success: function (data) { 	            	
	            	var msg=eval('('+data+')'); 
	            	if (msg.flag) {
						$.jBox.tip("图片上传成功","success"); 
						$("#picOne").val(msg.type);
						$("#picShow").html("图片上传地址："+msg.type);
					} else {
			            $.jBox.error("操作异常", '提示'); 
					}
	            } 
			});
	}
//新增，移除功能
$(function(){
    $("#demo5").easyinsert({
        name: ["piclinkadd", "pic","linkadd", "link","br","rd","recorder"],
        type: ["custom", "custom", "custom", "custom","custom","custom","custom"],
        value: ["图片链接地址:", "<input   name=\"pic\" style=\"width:300px\" maxlength=\"100\" type=\"text\" class=\"input-text\" value=\"\" onblur=\"jiaoyanBpic();\">	"
                ,"点击链接地址:", "<input id=\"link\" name=\"link\" style=\"width:300px\" maxlength=\"100\" type=\"text\" class=\"input-text\" value=\"\" onblur=\"jiaoyanBlink();\">",
                "<br/>","显示顺序:","<input id=\"recorder\" name=\"recorder\" style=\"width:200px\" maxlength=\"100\" type=\"text\" class=\"input-text\" value=\"\" onblur=\"jiaoyanBrecorder();\">"],  
        initValue: [
            ["图片链接地址:", "<input   name=\"pic\" style=\"width:300px\" maxlength=\"100\" type=\"text\" class=\"input-text\" value=\"\" onblur=\"jiaoyanBpic();\">",
             "点击链接地址:", "<input id=\"link\" name=\"link\" style=\"width:300px\" maxlength=\"100\" type=\"text\" class=\"input-text\" value=\"\" onblur=\"jiaoyanBlink();\">",
             "<br/>","显示顺序:","<input id=\"recorder\" name=\"recorder\" style=\"width:200px\" maxlength=\"100\" type=\"text\" class=\"input-text\" value=\"\" onblur=\"jiaoyanBrecorder();\">"]
        ]
    });
});
function publish(bannerId){
	$(".publishpage").hide();
	var params = {};
	params["id"]=bannerId;
	params["type"]="pub";//操作类型		 
	$.ajax({
		type: "POST",
		url: "bannerInfo/bannerUpdate.do",
		data: params,
		datatype: "json",
		success: function(msg){
			if (msg.flag) { 
				$.jBox.tip(msg.msg,"success");
				getList();
			} else {
	            $.jBox.error(msg.msg, '提示');
				menuParams = "";
				btnParams = "";
			}
		}
	});
}
	//预览banner
	function preview(bannerId){
		$(".previewpage").hide();
		var params = {};
		params["id"]=bannerId;
		params["type"]="preview";//操作类型		 
		$.ajax({
			type: "POST",
			url: "bannerInfo/bannerUpdate.do",
			data: params,
			datatype: "json",
			success: function(msg){
				if (msg.flag) {  
					window.open(msg.msg);
					
				} else {
		            $.jBox.error(msg.msg, '提示');
					menuParams = "";
					btnParams = "";
				}
			}
		});
	}
	
	function beforDel(bId){
		$("#bId").val(bId);
	}
	function del(){
		$("#Modal-delete").modal('hide');
		var bId = $("#bId").val();
		var bannerId = $("#id").val();
		var params = {};
		params["id"]=bId;
		params["bannerId"]=bannerId;
  		$.ajax({
  			type: "POST",
  			url: "bannerInfo/delOnePic.do",
  			data: params,
  			datatype: "json",
  			success: function(data){
  				if (data.flag) {
  					window.location.href="bannerInfo/toPage.do?bannerId="+bannerId+"&operType=edit";
				}else{
		            $.jBox.error(data.msg, '提示');
				}
  			}
  		});
	}
	
	function addOnePic(){
		if ($("#recorderOne").val()==null||$("#recorderOne").val()=="") {
            $.jBox.error("显示顺序不能为空", '提示');
			return false;
		} 
		if ($("#uploaded").val()==null||$("#uploaded").val().trim()=="") {
            $.jBox.error("图片不能为空", '提示');
			return false;
		}
		var recorder = $("#recorderOne").val();
		var link = $("#linkOne").val();
		var pic = $("#picOne").val();
		var id = $("#id").val();
		var params = {};
		params["recorder"]=recorder;
		params["link"]=link;
		params["pic"]=pic;
		params["bannerId"]=id;
  		$.ajax({
  			type: "POST",
  			url: "bannerInfo/addOnePic.do",
  			data: params,
  			datatype: "json",
  			success: function(data){
  				if (data.flag) {
  					window.location.href="bannerInfo/toPage.do?bannerId="+id+"&operType=edit";
				}else{
		            $.jBox.error(data.msg, '提示');
				}
  			}
  		});
	}
	function produceJson() { 
		var data = $("#editList").serializeArray();
		console.log(data.length);
		var kvArray = new Array();
		for(var i=1;i<=data.length/3;i++){
		var id = $("#id"+i).val(); 
		var link = $("#link"+i).val();
		var recorder = $("#recorder"+i).val();
		if (recorder==null||recorder=="") {
            $.jBox.error("显示顺序不能为空", '提示');
			return false;
		}
		var obj = {};
		obj["id"]=id;
		obj["link"]=link;
		obj["recorder"]=recorder;
		kvArray.push(obj);		
		}		
		console.log(kvArray);
		console.log(JSON.stringify(kvArray));
		return JSON.stringify(kvArray);
	 }
	function edit(){ 
		if ($("#name").val()==null||$("#name").val()=="") {
            $.jBox.error("横幅名称不能为空", '提示');
			return false;
		}
		var jsonData = produceJson();  
		var id = $("#id").val();  
		var name = $("#name").val();  
		$.ajax({
			type:'POST',
			url: "bannerInfo/bannerEdit.do?id="+id +"&name="+name,
            dataType:"json",        
            data:jsonData,
            contentType: 'application/json',
			cache: false,
			success: function(data){
  				if (data.flag) {
  					$.jBox.tip("修改成功","success"); 
  					window.location.href="bannerInfo/toPage.do?bannerId="+id+"&operType=edit";
				}else{
		            $.jBox.error(data.msg, '提示');
				}
  			}
		});
	}
	$.fn.serializeObject = function () {
        var obj = {};
        var count = 0;
        $.each(this.serializeArray(), function (i, o) {
            var n = o.name, v = o.value;
            count++;
            obj[n] = obj[n] === undefined ? v
            : $.isArray(obj[n]) ? obj[n].concat(v)
            : [obj[n], v];
        });
        //obj.nameCounts = count + "";//表单name个数
        return JSON.stringify(obj);
    };
    function jiaoyanName(){ 
		if ($("#name").val()==null||$("#name").val()=="") {
            $.jBox.error("横幅名称不能为空", '提示');
			return false;
		}
		return true;
	} 
	 function jiaoyanBlink(count){ 
			if ($("#link"+count).val()==null||$("#link"+count).val()=="") {
	            $.jBox.error("链接地址确定为空吗", '提示');
				return false;
			}
			return true;
		}
	 function jiaoyanBrecorder(count){ 
			if ($("#recorder"+count).val()==null||$("#recorder"+count).val()=="") {
	            $.jBox.error("显示顺序不能为空", '提示');
				return false;
			}
			return true;
		}
	 function jiaoyanLink(){ 
			if ($("#linkOne").val()==null||$("#linkOne").val()=="") {
	            $.jBox.error("链接地址确定为空吗", '提示');
				return false;
			}
			return true;
		}
	 function jiaoyanRecorder(){ 
			if ($("#recorderOne").val()==null||$("#recorderOne").val()=="") {
	            $.jBox.error("显示顺序不能为空", '提示');
				return false;
			}
			return true;
		}
	 function jiaoyanPic(){ 
			if ($("#uploaded").val()==null||$("#uploaded").val().trim()=="") {
	            $.jBox.error("图片不能为空", '提示');
				return false;
			}
			return true;
		} 