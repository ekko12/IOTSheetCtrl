$(document).ready(function() {
    $('#dataTable').datagrid({
        url : 'activity/getList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'actVipPageId',
        columns : [[{
                    field : 'actVipPageTitle',
                    align : 'left',
                    width : 50,
                    title : '活动页标题'
                }, {
                    field : 'accessType',
                    align : 'center',
                    width : 50,
                    title : '接入类型',
                    formatter : function(value, rowData, rowIndex) {
                        return getAccessTypeNameByCode(value);
                    }
                }, {
                    field : 'publishTime',
                    align : 'center',
                    width : 50,
                    title : '发布时间',
                    formatter : function(value, rowData, rowIndex) {
                        if (value != "" && value != null) {
                            return new Date(value).format('yyyy-MM-dd hh:mm:ss');
                        }
                        else {
                            return "";
                        }
                    }
                }, {
                    field : 'status',
                    align : 'center',
                    width : 50,
                    title : '状态',
                    formatter : function(value, rowData, rowIndex) {
                        return getStatusNameByCode(value);
                    }
                }, {
                    field : 'control',
                    align : 'center',
                    width : 30,
                    title : '操作',
                    formatter : function(value, rowData, rowIndex) {
                        var array = [];
                        array
                                .push('<a href="activity/addActivity.do?type=v&pkId='
                                        + rowData.actVipPageId
                                        + '" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
                        if ($("#WCS_ACT_INVAILD").val() != rowData.status) {
                        	if(ACT_VIP_LIST_UPD){
                            array
                                    .push('<a href="activity/addActivity.do?type=u&pkId='
                                            + rowData.actVipPageId
                                            + '" class="operButton" title="修改"><img src="resources/easyui13/themes/gray/images/button/btn_edit.gif" alt="修改" /></a>');
                        	}
                        	if(ACT_VIP_LIST_DEL){
                            array
                                    .push('<a href="javascript:void(0);" onclick="delActivity(\''
                                            + rowData.actVipPageId
                                            + '\');" class="operButton" title="禁用"><img src="resources/easyui13/themes/gray/images/button/btn_del.gif" alt="禁用" /></a>');
                        	}
                            if ($("#WCS_ACT_UNRELEASE").val() == rowData.status && ACT_VIP_LIST_PUD) {
                                array
                                        .push('<a href="javascript:void(0);" onclick="upActivity(\''
                                                + rowData.actVipPageId
                                                + '\');" class="operButton" title="发布"><img src="resources/easyui13/themes/gray/images/button/btn_grounding.gif" alt="发布" /></a>');
                            }
                            if ($("#WCS_ACT_RELEASE").val() == rowData.status && ACT_VIP_LIST_CANCEL_PUD) {
                                array
                                        .push('<a href="javascript:void(0);" onclick="dowActivity(\''
                                                + rowData.actVipPageId
                                                + '\');" class="operButton" title="取消发布"><img src="resources/easyui13/themes/gray/images/button/btn_undercarriage.gif" alt="取消发布" /></a>');
                            }
                        }
                        return array.join('');
                    }
                }]],
        onLoadSuccess : function(data) {
            $('#dataTable').datagrid('clearSelections');
        }
    }
    );
    $("#btn_search").click(function() {
        queryData();
    });
    $("#vipPageTitle,#status,#startDate,#endDate").keyup(function(e) {
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which;
        if (code == 13) {
            queryData();
        }
    });
}
);
function queryData() {
    var startDate = $.trim($("#startDate").val());
    var endDate = $.trim($("#endDate").val());
    if (startDate && endDate && startDate > endDate) {
        var tmp = startDate;
        $("#startDate").val(endDate);
        $("#endDate").val(tmp);
    }
    $('#dataTable').datagrid('load', {
        vipPageTitle : $.trim($('#vipPageTitle').val()),
        status : $.trim($('#status').val()),
        accessTypeId : $.trim($('#accessTypeId').val()),
        startDate : $.trim($("#startDate").val()),
        endDate : $.trim($("#endDate").val())
    });
}
// 删除活动页
function delActivity(actVipPageId) {
    $.dialog.confirm('是否确认禁用当前活动页?', function() {
        $.ajax({
            type : 'POST',
            url : 'activity/delete.do',
            data : {
                actVipPageId : actVipPageId
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
// 发布活动页
function upActivity(actVipPageId) {
    $.dialog.confirm('是否确认发布当前活动页?', function() {
        $.ajax({
            type : 'POST',
            url : 'activity/upActivity.do',
            data : {
                actVipPageId : actVipPageId
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
// 取消发布
function dowActivity(actVipPageId) {
    $.dialog.confirm('是否确认取消发布当前活动页?', function() {
        $.ajax({
            type : 'POST',
            url : 'activity/dowActivity.do',
            data : {
                actVipPageId : actVipPageId
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
function getStatusNameByCode(status) {
    var statusJson = jQuery.parseJSON($("#ACT_VIP_PAGE_STATUS_MAP_JSON").val());
    var statusName = "";
    for (var t in statusJson) {
        if (status == t) {
            statusName = statusJson[t];
            break;
        }
    }
    return statusName;
}
function getAccessTypeNameByCode(accessType) {
    var accessTypeJson = jQuery.parseJSON($("#WCS_ACCESS_TYPE_MAP_JSON").val());
    var accessTypeName = "";
    for (var t in accessTypeJson) {
        if (accessType == t) {
            accessTypeName = accessTypeJson[t];
            break;
        }
    }
    return accessTypeName;
}