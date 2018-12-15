$(document).ready(function() {
    $('#dataTable').datagrid({
        url : 'actext/getList.do',
        fit : true,
        nowrap : true,
        fitColumns : true,
        pagination : true,
        rownumbers : true,
        pageSize : 10,
        pageList : [10, 20, 30, 40, 50],
        idField : 'actId',
        columns : [[{
                    field : 'actCode',
                    align : 'center',
                    width : 50,
                    title : '活动编码'
                }, {
                    field : 'actName',
                    align : 'center',
                    width : 50,
                    title : '活动名称'
                }, {
                    field : 'actSalesType',
                    align : 'center',
                    width : 50,
                    title : '活动类型',
                    formatter : function(value, rowData, rowIndex) {
                        return getActSalesTypeNameByCode(value);
                    }
                }, {
                    field : 'actBegindate',
                    align : 'center',
                    width : 50,
                    title : '开始时间',
                    formatter : function(value, rowData, rowIndex) {
                        if (value != "" && value != null) {
                            return new Date(value).format('yyyy-MM-dd hh:mm:ss');
                        }
                        else {
                            return "";
                        }
                    }
                }, {
                    field : 'actEnddate',
                    align : 'center',
                    width : 50,
                    title : '结束时间',
                    formatter : function(value, rowData, rowIndex) {
                        if (value != "" && value != null) {
                            return new Date(value).format('yyyy-MM-dd hh:mm:ss');
                        }
                        else {
                            return "";
                        }
                    }
                }, {
                    field : 'effectBegionDate',
                    align : 'center',
                    width : 50,
                    title : '生效时间',
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
                    title : '活动状态',
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
                                .push('<a href="javascript:void(0);" onclick="toDetail('
                                        + rowData.actId
                                        + ')" class="operButton" title="详情"><img src="resources/easyui13/themes/gray/images/button/btn_detail.gif" alt="详情" /></a>');
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
    $("#actName,#actSalesType,#startDate,#endDate,#status").keyup(function(e) {
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
        actCode : $.trim($('#actCode').val()),
        actName : $.trim($('#actName').val()),
        actSalesType : $.trim($('#actSalesType').val()),
        startDate : $.trim($("#startDate").val()),
        endDate : $.trim($("#endDate").val()),
        status : $.trim($("#status").val())
    });
}
function getActSalesTypeNameByCode(actSalesType) {
    var actSalesTypeJson = jQuery.parseJSON($("#WCS_ACT_TYPE_MAP_JSON").val());
    var actSalesTypeName = "";
    for (var t in actSalesTypeJson) {
        if (actSalesType == t) {
            actSalesTypeName = actSalesTypeJson[t];
            break;
        }
    }
    return actSalesTypeName;
}
function getStatusNameByCode(status) {
    var statusJson = jQuery.parseJSON($("#WCS_COMMON_STATUS_MAP_JSON").val());
    var statusName = "";
    for (var t in statusJson) {
        if (status == t) {
            statusName = statusJson[t];
            break;
        }
    }
    return statusName;
}
function toDetail(actId) {
    $.dialog({
        title : '活动详情',
        content : "url:actext/getDetail.do?actId=" + actId,
        width : 800,
        height : 500,
        lock : true,
        cancelVal : '关闭',
        cancel : true
    })
}