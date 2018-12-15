var param = {};
/**
 * 页面加载
 */
$(function() {
    if (! param.parentChannelTypeId) {
        // 加载渠道类型树数据
        $.ajax({
            type : 'POST',
            url : 'channelType/getTreeList.do',
            datatype : 'text',
            success : function(result) {
                $.fn.zTree.init($("#channelTypeTree"), {
                    check : {
                        enable : true,
                        chkStyle : "radio",
                        radioType : "all"
                    },
                    view : {
                        dblClickExpand : false
                    },
                    data : {
                        simpleData : {
                            enable : true
                        }
                    },
                    callback : {
                        beforeClick : checkIsSon,
                        beforeCheck : checkIsSon,
                        onClick : onClick1,
                        onCheck : onCheck1
                    }
                }, result);
            }
        });
    }
    // 加载渠道树数据
    /*
     * $.ajax({ type : 'POST', url : 'channel/getChannelTree.do', datatype : 'text', success : function(result) {
     * $.fn.zTree.init($("#parentChannelTree"), { check : { enable : true, chkStyle : "radio", radioType : "all" }, view : {
     * dblClickExpand : false }, data : { simpleData : { enable : true } }, callback : { onClick : onClickParentChannel,
     * onCheck : onCheckParentChannel } }, result); } });
     */
    /*
    // 地市全选
    $("#regionCodeAll").click(function() {
        if ("checked" == $("#regionCodeAll").attr("checked")) {// 全选
            $("input[name='region_codes']").each(function() {
                $("input[name='region_codes']").attr("checked", "checked");
            });
        }
        else {
            $("input[name='region_codes']").each(function() {
                $("input[name='region_codes']").removeAttr("checked");
            });
        }
    });
    */
    //电话号码填写校验
   $("#linkmanTel").blur(function(){
	  var   linkmanTel  = $("#linkmanTel").val();
	   if (null == linkmanTel || '' == linkmanTel) {
	        showDialog('联系电话不能为空', 'error', function() {
	            $('#linkmanTel').focus();
	        });
	        return false;
	    }else{
	    	if(!checkIsMobile(linkmanTel)){
	    		  showDialog('联系电话格式不正确，请重新填写！（号码格式：0189+6位数字）', 'error', function() {
	    	            $('#linkmanTel').focus();
	    	        });
	    	        return false;
	    	}
	    }
   });
    // 渠道发展人
    $(".area .btn").click(function() {
        $(this).parent(".area").toggleClass("on");
        var cl_btn = $(this).next(".city").children(".button3");
        cl_btn.click(function() {
            var sp = "";
            $("#region_span").html('');// 清空
            // 获取选中的地市编码
            $("input[name='region_codes']:checkbox").each(function() {
                if ($(this).attr("checked")) {
                    var code = $(this).val();
                    var c = code.split("_")[0];// 地市编码
                    var n = code.split("_")[1];// 地市名称
                    sp += "<span class='txt' id='rc_" + c + "'>";
                    sp +=
                            "<i style='width:50px;'>" + n + "</i><input type='hidden' name='regionCodes' value='" + c
                                    + "' />";
                    sp +=
                            "<i style='width:180px;'>发展人编码：<input id='developerCode_" + c + "' name='developerCode_"
                                    + c + "' regionName='" + n + "' style='width:100px;' type='text'/></i>";
                    sp +=
                            '<a href="javascript:void(0)" onclick="delItem(\'rc_\', \'' + c
                                    + '\')">删除</a></span><span id="developerSpan_' + c
                                    + '"  style="color:red;">只能输入51开头的10位数字</span><br>';
                    $("#region_span").append(sp);
                    sp = "";
                }
            }
            );
            // 隐藏层
            $(this).parents(".area").removeClass("on");
        })
    }
    );
    // 商城全选
    $("#mallCodeAll").click(function() {
        if ("checked" == $("#mallCodeAll").attr("checked")) {// 全选
            $("input[name='mallCodes']").each(function() {
                $("input[name='mallCodes']").attr("checked", "checked");
            });
        }
        else {
            $("input[name='mallCodes']").each(function() {
                $("input[name='mallCodes']").removeAttr("checked");
            });
        }
    });
    // 支付方式全选
    $("#payModeAll").click(function() {
        if ("checked" == $("#payModeAll").attr("checked")) {// 全选
            $("input[name='payModes']").each(function() {
                $("input[name='payModes']").attr("checked", "checked");
            });
        }
        else {
            $("input[name='payModes']").each(function() {
                $("input[name='payModes']").removeAttr("checked");
            });
        }
    });
    $('#licensingTab').click(function() {
        $("#licensing").datagrid({
            url : "channel/getLicensingList.do?channelId=" + $("#channelId").val(),
            fit : true,
            nowrap : true,
            fitColumns : true,
            pagination : true,
            rownumbers : true,
            pageSize : 10,
            pageList : [10, 20, 30, 40, 50],
            idField : "licensingId",
            columns : [[{
                        field : "licensingName",
                        align : "center",
                        width : 20,
                        title : "协议名称"
                    }, {
                        field : "contracting",
                        align : "center",
                        width : 10,
                        title : "状态"
                    }, {
                        field : "control",
                        align : "center",
                        width : 20,
                        title : "操作",
                        formatter : function(value, rowData, rowIndex) {
                            var array = [];
                            array
                                    .push('<a href="javascript:void(0);" onclick="showLicensing(\''
                                            + rowData.licensingContent
                                            + '\',\''
                                            + rowData.licensingId
                                            + '\',\''
                                            + rowData.contracting
                                            + '\');" class="operButton" title="查看"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="查看" /></a>');
                            return array.join('');
                        }
                    }]],
            onLoadSuccess : function(data) {
                $("#licensing").datagrid('clearSelections');
            }
        }
        );
    }
    );
}
);
function showLicensing(licensingContent, licensingId, contracting) {
    $.dialog({
        title : '授权协议',
        content : $('#detailDiv').html(),
        width : '700px',
        height : '480px',
        ok : function() {
            if (contracting == '未签') {
                if (! $('#ck_tongyi').is(":checked")) {
                    showDialog('签订协议需要选择同意协议内容！', 'error', null);
                    return false;
                }
                $.ajax({
                    type : 'POST',
                    url : rootPath + '/channel/licensing.do',
                    data : {
                        licensingId : licensingId,
                        channelId : $("#channelId").val()
                    },
                    datatype : 'json',
                    success : function(msg) {
                        if (msg.flag) {
                            showDialog(msg.msg, 'success', back);
                        }
                        else {
                            showDialog(msg.msg, 'error', null);
                        }
                    },
                    error : function() {
                        showDialog("操作失败！", 'error', null);
                    }
                });
            }
            else {
                return true;
            }
        },
        cancel : function() {
            return true;
        }
    });
    if (contracting == '未签') {
        $("#tongyi").show();
    }
    else {
        $("#tongyi").hide();
    }
    $("#licensingContent").attr("src", "resources/js/channel/"+licensingContent+".html");
}
// ///////////////////////////////// 渠道类型树层 start //////////////////////////////////////////////////
function checkIsSon(e, treeNode, treeId) {
    if (treeNode.isParent) {
        showDialog('请选择子节点渠道', 'error', null);
        hideMenu('det_channelTypeId','channelTypeContent');
        return false;
    }
}
function onClick1(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("channelTypeTree");
    zTree.checkNode(treeNode, ! treeNode.checked, null, true);
    return false;
}
function onCheck1(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("channelTypeTree"), nodes = zTree.getCheckedNodes(true), v = "", id = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
        id += nodes[i].id + ",";
    }
    if (v.length > 0)
        v = v.substring(0, v.length - 1);
    if (id.length > 0)
        id = id.substring(0, id.length - 1);
    $("#det_channelTypeId").val(v);
    $("#channelTypeId").val(id);
    setChannelMarkByChannelTypeId(id);//根据渠道类型id给渠道标离赋值
    hideMenu('det_channelTypeId','channelTypeContent');
}

//根据渠道类型id给渠道标离赋值
function setChannelMarkByChannelTypeId(channelTypeId){
	$.ajax({
        type : 'POST',
        url : rootPath + '/channelType/getChannelMarkNameByChannelTypeId.do',
        data : 'channelTypeId=' + channelTypeId,
        datatype : 'json',
        success : function(result) {
            if (result && result.channelMarkName) {
            	$("#channelMark").val(result.channelMarkName);
            }
            else {
            }
        }
    });
}
// //////上级渠道/////////
function onClickParentChannel(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("parentChannelTree");
    zTree.checkNode(treeNode, ! treeNode.checked, null, true);
    return false;
}
function onCheckParentChannel(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("parentChannelTree"), nodes = zTree.getCheckedNodes(true), v = "", id = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
        id += nodes[i].id + ",";
    }
    if (v.length > 0)
        v = v.substring(0, v.length - 1);
    if (id.length > 0)
        id = id.substring(0, id.length - 1);
    $("#det_parentChannelId").val(v);
    $("#parentChannelId").val(id);
    hideMenu('det_channelTypeId','channelTypeContent');
}
// //////展示//////////
function showMenu(arg1, arg2) {
    var cityObj = $("#" + arg1);
    var cityOffset = $("#" + arg1).offset();
    $("#" + arg2).slideDown("fast");
    $("body").bind("mousedown", function(event) {
        onBodyDown(arg1, arg2, event)
    });
}
function hideMenu(div1, div2) {
    $("#" + div2).fadeOut("fast");
    $("body").unbind("mousedown", function(event) {
        onBodyDown(div1, div2, event)
    });
}
function onBodyDown(div1, div2, event) {
    if (! (event.target.id == "menuBtn" || event.target.id == div1 || event.target.id == div2 || $(event.target)
            .parents("#" + div2).length > 0)) {
        hideMenu(div1, div2);
    }
}
// ///////////////////////////////
/**
* 渠道数据新增/修改
*/
function submitForm() {
	
	var channelTypeId = $('#channelTypeId').val();
    if (null == channelTypeId || '' == channelTypeId) {
        showDialog('渠道类型不能为空', 'error', null);
        return false;
    }
    var channelNameEle = $('#channelName')[0];
    clearSpace(channelNameEle);
    var channelName = $('#channelName').val();
    if (null == channelName || '' == channelName) {
        showDialog('渠道名称不能为空', 'error', function() {
            $('#channelName').focus();
        });
        return false;
    }
    else if (channelName.length > 100) {
        showDialog('渠道名称长度不能大于100', 'error', function() {
            $('#channelName').focus();
        });
        return false;
    }
    
    
    var _type = $('#_type').val();
    if (_type == '0') {// 表示新增
    	
    	
        
        
        var channelAccountEle = $('#channelAccount')[0];
        clearSpace(channelAccountEle);
        var channelAccount = $('#channelAccount').val();
        if (null == channelAccount || '' == channelAccount) {
            showDialog('渠道账号不能为空', 'error', function() {
                $('#channelAccount').focus();
            });
            return false;
        }
        var accountPwd = $('#accountPwd').val();
        if (null == accountPwd || '' == accountPwd) {
            showDialog('密码不能为空', 'error', function() {
                $('#accountPwd').focus();
            });
            return false;
        }
        else if (accountPwd.indexOf(' ') != - 1) {
            showDialog('密码不能包含空格', 'error', function() {
                $('#accountPwd').focus();
            });
            return false;
        }
        else if (accountPwd.length < 6 || accountPwd.length > 12) {
            showDialog('密码长度限制6-12位', 'error', function() {
                $('#accountPwd').focus();
            });
            return false;
        }
    }
    
    var channelDesc = $('#channelDesc').val();
    if (channelDesc.length > 640) {
        showDialog('渠道描述长度不能大于640', 'error', function() {
            $('#channelDesc').focus();
        });
        return false;
    }
    /*
    var cbusinessCircle = $('#cbusinessCircle').val();
    if (null == cbusinessCircle || cbusinessCircle == '') {
        showDialog('收货地址不能为空', 'error', function() {
            $('#cbusinessCircle').focus();
        });
        return false;
    }
    var region_codes = $('input[name="region_codes"]:checked');
    if (region_codes.length < 1) {
        showDialog('请选择代理地市', 'error', null);
        return false;
    }
    */
    /* if(param.WCS_ONE==param.parentChannelGrade||param.WCS_TWO=param.parentChannelGrade){ */
    /*if ("" == param.parentChannelId || "-1" == param.parentChannelId
            || ('' != param.parentChannelGrade && param.WCS_ONE == param.parentChannelGrade)) {
        var developerCode = $('input[name^="developerCode_"]');
        var flag = true;
        for (var i = 0, len = developerCode.length; i < len; i++) {
            if (! /^51\d{8}$/.test(developerCode.get(i).value)) {
                showDialog($(developerCode.get(i)).attr('regionName') + '发展人编码错误,请按规定填写!', 'error', function() {
                    $(developerCode.get(i)).focus();
                });
                flag = false;
                break;
            }
        }
        if (! flag) {
            return false;
        }
    }*/
    
    
    /*
    var deliveryModes = $('input[name="deliveryModes"]:checked');
    if (deliveryModes.length < 1) {
        showDialog('请选择提货方式', 'error', null);
        return false;
    }
    var payModes = $('input[name="payModes"]:checked');
    if (payModes.length < 1) {
        showDialog('请选择支付方式', 'error', null);
        return false;
    }
    */
    var mallCodes = $('input[name="mallCodes"]:checked');
    if (mallCodes.length < 1) {
        showDialog('所属站点不能为空', 'error', null);
        return false;
    }
    
    var linkman = $('#linkman').val();
    if (null == linkman || '' == linkman) {
        showDialog('联系人不能为空', 'error', function() {
            $('#linkman').focus();
        });
        return false;
    }
    var sex = $('#sex').val();
    if (null == sex || '' == sex) {
        showDialog('性别不能为空', 'error', function() {
            $('#sex').focus();
        });
        return false;
    }
    
    var certType = $('#certType').val();
    if (null == certType || '' == certType) {
        showDialog('证件类型不能为空', 'error', function() {
            $('#certType').focus();
        });
        return false;
    }
    
    var certNo = $('#certNo').val();
    if (null == certNo || '' == certNo) {
        showDialog('证件号码不能为空', 'error', function() {
            $('#certNo').focus();
        });
        return false;
    }
    
    var linkmanTel = $('#linkmanTel').val();
    if (null == linkmanTel || '' == linkmanTel) {
        showDialog('联系电话不能为空', 'error', function() {
            $('#linkmanTel').focus();
        });
        return false;
    }else{
    	if(!checkIsMobile(linkmanTel)){
    		  showDialog('联系电话格式不正确，请重新填写！（号码格式：0189+6位数字）', 'error', function() {
    	            $('#linkmanTel').focus();
    	        });
    	        return false;
    	}
    }
    var postCode = $('#postCode').val();
    if ((postCode != null || webName != '') && !postCode.length > 8) {
        showDialog('邮编不能超过8个字节！', 'error', function() {
            $('#postCode').focus();
        });
        return false;
    }
    
  //email验证
	var email = $('#email').val();
    if((!checkEmail(email)) && (email != "") && (email != null)){
		showDialog('email格式不正确', 'error', function() {
            $('#email').focus();
        });
	return false;
	}
    var webName = $('#webName').val();
    if ((webName != null || webName != '') && webName.length > 50) {
        showDialog('网站名称不能超过50汉字长度！', 'error', function() {
            $('#webName').focus();
        });
        return false;
    }
    var webDomain = $('#webDomain').val();
    if (webDomain != null && webDomain != '' && webDomain.length > 50) {
        showDialog('网站域名不能超过50汉字长度！', 'error', function() {
            $('#webDomain').focus();
        });
        return false;
    }
    
    if (webDomain != null && webDomain != '' && (!IsURL(webDomain))){
        showDialog('网站域名格式不正确！', 'error', function() {
            $('#webDomain').focus();
        });
        return false;
    }
    var webDomain = $('#webDomain').val();
    var bankAccountType = $('#bankAccountType').val();
    var bankAccountName = $('#bankAccountName').val();
    var bankAccount = $('#bankAccount').val();
    var channelForm = $('#channelForm');
    var type = $('#_type').val();
    var channelId = "";
    if ($('#channelId').val()) {
        channelId = $('#channelId').val();
    }
    $.ajax({
        type : 'POST',
        url : rootPath + '/channel/checkChannelAccountName.do',
        data : 'webName=' + webName + '&webDomain=' + webDomain + '&bankAccountType=' + bankAccountType
                + '&bankAccountName=' + bankAccountName + '&bankAccount=' + bankAccount + '&channelId=' + channelId
                + '&channelAccount=' + $('#channelAccount').val() + '&channelName=' + $('#channelName').val()
                + '&type=' + type,
        datatype : 'json',
        success : function(msg) {
            if (msg.flag) {
                // var initTips = $.dialog.tips('数据保存中...', 3000, 'loading.gif').lock();
                $.ajax({
                    type : 'POST',
                    url : rootPath + '/channel/addOrModChannel.do',
                    data : channelForm.serialize() + '&type=' + type,
                    datatype : 'json',
                    success : function(msg) {
                        // 操作成功
                        // initTips.close();
                        if (msg.flag) {
                            showDialog(msg.msg, 'success', back);
                        }
                        else {
                            showDialog(msg.msg, 'error', null);
                        }
                    }
                });
            }
            else {
                // initTips.close();
                showDialog(msg.msg, 'error', null);
            }
        }
    });
}
function back() {
    window.location.href = rootPath + '/channel/toChannel.do';
}
/**
 * 打开弹出层
 * @param title 弹出层显示标题
 * @param operType 操作模块
 * @param channelId 渠道ID
 * @param type 操作子模块
 */
function operWin(title, operType, channelId, type) {
    var params = "?operType=" + operType + "&channelId=" + channelId + "&type=" + type;
    var url = "url:channel/openWindow.do" + params;
    $.dialog({
        title : title,
        zIndex : 2000,
        lock : true,
        drag : false,
        resize : false,
        width : '550px',
        height : '470px',
        content : url
    });
}
/**
 * 删除元素
 */
function delItem(pre, id) {
    $("#" + pre + id).remove();
    $("#developerSpan_" + id).remove();
}

/**
 * 检查s_value是否是手机号码格式
 * @param s_value
 * @returns {Boolean}
 */
function checkIsMobile(s_value){
	return /^((\(\d{3}\))|(\d{3}\-))?0\d{9}$/.test(s_value);
}

//邮箱验证
function  checkEmail(email) {
    var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
	return re.test(email);
}
//网址验证
function IsURL(str_url){
    var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
    + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@
    + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
    + "|" // 允许IP和DOMAIN（域名）
    + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.
    + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名
    + "[a-z]{2,6})" // first level domain- .com or .museum
    + "(:[0-9]{1,4})?" // 端口- :80
    + "((/?)|" // a slash isn't required if there is no file name
    + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    var re=new RegExp(strRegex);
    //re.test()
    if (re.test(str_url)){
        return (true);
    }else{
        return (false);
    }
}
//去掉左右空格
function trim(domObj){
	domObj.value=$.trim(domObj.value);
	}