$(document).ready(function() {
    $('#logTable').datagrid({
        url : 'log/getList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'logId',
        columns : [[{
                    field : 'operId',
                    align : 'left',
                    width : 50,
                    title : '操作人员'
                }, {
                    field : 'loginTime',
                    align : 'left',
                    width : 50,
                    title : '登录时间',
                    formatter : function(value, rowData, rowIndex) {
                        return new Date(value).format('yyyy-MM-dd hh:mm:ss');
                    }
                }, {
                    field : 'logoutTime',
                    align : 'left',
                    width : 50,
                    title : '退出时间',
                    formatter : function(value, rowData, rowIndex) {
                        return new Date(value).format('yyyy-MM-dd hh:mm:ss');
                    }
                }, {
                    field : 'ipAddress',
                    align : 'left',
                    width : 50,
                    title : 'IP地址'
                }, {
                    field : 'macId',
                    align : 'left',
                    width : 50,
                    title : 'MAC地址'
                }, {
                    field : "control",
                    align : "center",
                    width : 20,
                    title : "操作",
                    formatter : function(value, rowData, rowIndex) {
                        var array = [];
                        if(SYS_USER_LOGIN_LOG_DETAIL){
                        	 array
                             .push('<a href="javascript:void(0);" onclick="detail(\''
                                     + rowData.logId
                                     + '\');" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
                        }
                       
                        return array.join('');
                    }
                }]],
        onLoadSuccess : function(data) {
            $('#logTable').datagrid('clearSelections');
        }
    }
    );
    $("#btn_search").click(function() {
        $('#logTable').datagrid('load', {
            operId : $("#operId").val(),
            startLoginTime : $("#startLoginTime").val(),
            endLoginTime : $("#endLoginTime").val(),
            startLogoutTime : $("#startLogoutTime").val(),
            endLogoutTime : $("#endLogoutTime").val()
        });
    });
}
);
// 详情
function detail(logId) {
    $("input[id^='det'],textarea[id^='det']").attr("disabled", "disabled");
    $("input[id^='det']").css({
        "color" : "#636363",
        "background" : "#EAEAEA"
    });
    $.dialog({
        title : '机构信息',
        left : 217,
        content : $("#div_detail").html(),
        cancel : function() {
            return true;
        }
    });
    $.ajax({
        type : 'POST',
        url : 'log/getDetail.do',
        data : {
            logId : logId
        },
        datatype : 'json',
        async : false,
        success : function(result) {
            $("#det_operId").val(result.operId);
            $("#det_loginTime").val(new Date(result.loginTime).format('yyyy-MM-dd hh:mm:ss'));
            $("#det_logoutTime").val(new Date(result.logoutTime).format('yyyy-MM-dd hh:mm:ss'));
            $("#det_ipAddress").val(result.ipAddress);
            $("#det_macId").val(result.macId);
            $("#det_remark").val(result.remark);
        }
    });
}