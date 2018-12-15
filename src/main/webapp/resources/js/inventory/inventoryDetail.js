$(document).ready(function() {
});
function showRegionWin(stockId, stockSpaceType) {
    var url = "url:inventory/showRegionWin.do?stockSpaceId=" + stockId + "&stockSpaceType=" + stockSpaceType;
    $.dialog({
        title : "修改",
        max : false,
        min : false,
        zIndex : 2000,
        lock : true,
        drag : false,
        resize : false,
        content : url
    });
}
function modifyStockSpace(stockSpaceId) {
    $.dialog({
        title : "修改仓位适用范围",
        max : false,
        min : false,
        lock : true,
        drag : false,
        resize : false,
        content : 'url:inventory/modifyStockSpace.do?stockSpaceId=' + stockSpaceId
    });
}
function modifyStockNum(stockSpaceId, type) {
    $.dialog({
        title : type == "TRADE" ? "修改仓位对应商圈库存" : "修改渠道自有库存",
        max : false,
        min : false,
        lock : true,
        drag : false,
        resize : false,
        content : 'url:inventory/modifyStockNum.do?stockSpaceId=' + stockSpaceId
    });
}