$(document).ready(function() {
    $('#smsTable').datagrid({
        url : 'sms/getList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'smsTemplateCode',
        columns : [[{
                    field : 'templateName',
                    align : 'left',
                    width : 50,
                    title : '模板名称'
                }, {
                    field : 'templateContent',
                    align : 'left',
                    width : 50,
                    title : '模板内容'
                }, {
                    field : 'control',
                    align : 'center',
                    width : 30,
                    title : '操作',
                    formatter : function(value, rowData, rowIndex) {
                        var array = [];
                        if ('0' == rowData.status) {
                            array
                                    .push('<a href="javascript:void(0);" onclick="detail(\''
                                            + rowData.smsTemplateCode
                                            + '\');" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="Details" /></a>');
                        }
                        else {
                            array
                                    .push('<a href="javascript:void(0);" onclick="detail(\''
                                            + rowData.smsTemplateCode
                                            + '\');" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="Details" /></a>');
                            if (SMS_TEMPLATE_UPD) {
                                array
                                        .push('<a href="javascript:void(0);" onclick="update(\''
                                                + rowData.smsTemplateCode
                                                + '\');" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="Edit" /></a>');
                            }
                            if (SMS_TEMPLATE_DEL) {
                                array
                                        .push('<a href="javascript:void(0);" onclick="del(\''
                                                + rowData.smsTemplateCode
                                                + '\');" class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="Disable" /></a>');
                            }
                        }
                        return array.join('');
                    }
                }]],
        onLoadSuccess : function(data) {
            $('#smsTable').datagrid('clearSelections');
        }
    }
    );
    $("#btn_search").click(function() {
        queryData();
    });
    $("#templateName").keyup(function(e) {
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which;
        if (code == 13) {
            queryData();
        }
    });
    $("#btn_add").click(function() {
        $("#det_code").val("");
        $("#det_name").val("");
        $("#det_content").val("");
        $("#det_code").removeAttr("disabled");
        $("#det_name").removeAttr("disabled");
        $("#det_content").removeAttr("disabled");
        $("#det_code,#det_name").css({
            "color" : "#000000",
            "background" : "#ffffff"
        });
        $.dialog({
            title : '新增模板',
            left : 217,
            content : $('#detailDiv').html(),
            ok : function() {
                return save();
            },
            cancel : function() {
                return true;
            }
        });
    });
}
);
function queryData() {
    $('#smsTable').datagrid('load', {
        templateName : $.trim($("#templateName").val())
    });
}
function detail(smsTemplateId) {
    $("#det_code").attr("disabled", "disabled");
    $("#det_name").attr("disabled", "disabled");
    $("#det_desc").attr("disabled", "disabled");
    $.dialog({
        title : '查看模板',
        left : 217,
        content : $("#detailDiv").html(),
        cancel : function() {
            return true;
        }
    });
    $.ajax({
        type : 'POST',
        url : 'sms/getDetail.do',
        data : {
            smsTemplateId : smsTemplateId
        },
        datatype : 'json',
        async : false,
        success : function(result) {
            $("#det_code").val(result.smsTemplateCode);
            $("#det_name").val(result.templateName);
            $("#det_content").val(result.templateContent);
        }
    });
}
function update(smsTemplateId) {
    $("#det_name").removeAttr("disabled");
    $("#det_content").removeAttr("disabled");
    $("#det_name").css({
        "color" : "#000000",
        "background" : "#ffffff"
    });
    $.dialog({
        title : '修改模板',
        left : 217,
        content : $("#detailDiv").html(),
        ok : function() {
            return save();
        },
        cancel : function() {
            return true;
        }
    });
    $.ajax({
        type : 'POST',
        url : 'sms/getDetail.do',
        data : {
            smsTemplateId : smsTemplateId
        },
        datatype : 'json',
        async : false,
        success : function(result) {
            $("#det_code").val(result.smsTemplateCode);
            $("#det_name").val(result.templateName);
            $("#det_content").val(result.templateContent);
        }
    });
}
function del(smsTemplateId) {
    $.messager.confirm('提示信息', '确定禁用模板信息?', function(r) {
        if (r) {
            $.ajax({
                type : 'POST',
                url : 'sms/delete.do',
                data : {
                    smsTemplateId : smsTemplateId
                },
                datatype : 'json',
                success : function(msg) {
                    if (msg.flag) {
                        $('#smsTable').datagrid('load', {});
                    }
                    $.messager.alert('提示信息', msg.msg, 'info');
                }
            });
        }
    });
}
function save() {
    var code = $("#det_code").val();
    if (code == "" || code == null) {
        $.messager.alert('提示信息', "模板编码不能为空！", 'info');
        return false;
    }
    var name = $("#det_name").val();
    if (name == "" || name == null) {
        $.messager.alert('提示信息', "模板名称不能为空！", 'info');
        return false;
    }
    var det_content = $("#det_content").val();
    if (det_content == "" || det_content == null) {
        $.messager.alert('提示信息', "模板内容不能为空！", 'info');
        return false;
    }
    $.ajax({
        type : 'POST',
        url : 'sms/update.do',
        data : {
            smsTemplateId : code,
            templateName : name,
            templateContent : det_content
        },
        datatype : 'json',
        success : function(msg) {
            if (msg.flag) {
                $('#smsTable').datagrid('load', {});
            }
            $('#detailDiv').dialog('close');
            $.dialog({
                content : msg.msg,
                ok : true
            });
        }
    });
}