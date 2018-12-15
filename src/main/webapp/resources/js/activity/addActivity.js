var jcrop_api;
var idAll;
var idOne;
$(document).ready(function() {
    // CKEDITOR.replace('vipPageContent');
    if (CKEDITOR.instances['vipPageContent']) {
        CKEDITOR.instances['vipPageContent'].destroy(true);
    }
    // filebrowserImageUploadUrl:文件上传路径
    CKEDITOR.replace('vipPageContent', {
        height : 200,
        filebrowserImageUploadUrl : rootPath + '/sale/ckeditUpload.do'
    });
    $("#myBtn").click(function() {
        var actVipPageId = $("#actVipPageId").val();
        var actVipPageTitle = $('#actVipPageTitle').val();
        if (null == actVipPageTitle || actVipPageTitle == '') {
            $.dialog.alert('活动名称不能为空！');
            $('#actVipPageTitle').focus();
            return false;
        }
        var accessType = $("#accessType").val();
        if (null == accessType || accessType == "") {
            $.dialog.alert('接入方式不能为空！');
            $('#accessType').focus();
            return false;
        }
        var actVipPageType = $("#actVipPageType").val();
        if (null == actVipPageType || actVipPageType == "") {
            $.dialog.alert('活动类型不能为空！');
            $('#actVipPageType').focus();
            return false;
        }
        var vipPageContent = CKEDITOR.instances.vipPageContent.getData();
        // 获取正确的文本框内的值
        var start = vipPageContent.indexOf('<p>');
        var end = vipPageContent.indexOf('</p>');
        var vipPageContentTmp = vipPageContent.substring(start + 3, end);
        if (null == vipPageContentTmp || vipPageContentTmp == '') {
            $.dialog.alert('活动页内容不能为空！');
            $('#vipPageContent').focus();
            return false;
        }
        $.ajax({
            type : 'POST',
            url : 'activity/saveAct.do',
            data : {
                actVipPageId : actVipPageId,
                actVipPageTitle : actVipPageTitle,
                accessType : accessType,
                vipPageContent : vipPageContent,
                actVipPageType : actVipPageType
            },
            datatype : 'json',
            success : function(msg) {
                if (msg.flag) {
                    $.dialog({
                        title : '提示',
                        content : msg.msg,
                        ok : function() {
                            window.location.href = rootPath + "/activity/init.do";
                            return true;
                        }
                    });
                }
                else {
                    $.dialog({
                        title : '提示',
                        content : msg.msg,
                        ok : function() {
                            return true;
                        }
                    });
                }
            }
        });
    });
});
/**
 * 上传文件
 * @param fileElement
 * @return
 */
function uploadFile() {
    var initTips = $.dialog.tips('图片上传中...', 60000, 'loading.gif');
    $('#photoBtn').attr('disabled', "disalbed");
    $('#uploadForm').attr("enctype", "multipart/form-data");
    $("#uploadForm").ajaxSubmit({
        type : "post",
        url : 'activity/uploadFileRequestOne.do',
        dataType : "json",
        success : function(result) {
            $('#uploadForm').attr("enctype", "application/x-www-form-urlencoded");
            if (result) {
                if (result.flag == 'true') {
                    initTips.close();
                    showDialog('图片上传成功!', 'success');
                    var pathOne = result.picUrl + "/" + result.photoPath;
                    $('#photoBtn').attr('disabled', "disalbed");
                    $('#photoFile').attr('disabled', "disalbed");
                    $('#target').attr('src', pathOne);
                    $('#photoId').val(result.photoPath);
                    $("#testOne").show();
                    photoFunction();
                }
                else {
                    initTips.close();
                    $('#photoBtn').removeAttr('disabled');
                    showDialog('图片上传失败!', 'error');
                }
            }
        },
        error : function(result) {
            initTips.close();
            $('#photoBtn').removeAttr('disabled');
            $('#uploadForm').attr("enctype", "application/x-www-form-urlencoded");
            showDialog('后台程序报错!', 'error');
        }
    });
    return false;
}
function photoFunction() {
    $('#target').Jcrop({
        onChange : showCoords,
        onSelect : showCoords,
        onRelease : clearCoords
    }, function() {
        jcrop_api = this;
    });
    $('#coords').on('change', 'input', function(e) {
        var x1 = $('#x1').val(), x2 = $('#x2').val(), y1 = $('#y1').val(), y2 = $('#y2').val();
        jcrop_api.setSelect([x1, y1, x2, y2]);
    });
    function showCoords(c) {
        $('#x1').val(c.x);
        $('#y1').val(c.y);
        $('#x2').val(c.x2);
        $('#y2').val(c.y2);
        $('#w').val(c.w);
        $('#h').val(c.h);
    }
    function clearCoords() {
        $('#coords input').val('');
    }
    $('#saveBtn').click(function() {
        if (idAll) {
            var DivText = $("#" + idAll);
            DivText.attr('data-x1', $("#x1").val());
            DivText.attr('data-x2', $("#x2").val());
            DivText.attr('data-y1', $("#y1").val());
            DivText.attr('data-y2', $("#y2").val());
            DivText.attr('data-url', $("#urlText").val());
            DivText.html($("#urlText").val());
            var divTextTwo = $("#" + "area_" + idOne);
            var str = $('#x1').val() + "," + $('#y1').val() + "," + $('#x2').val() + "," + $('#y2').val() + ",";
            divTextTwo.attr('coords', str);
            divTextTwo.attr('href', $("#urlText").val());
            divTextTwo.attr('imgW', jcrop_api.getBounds());
            jcrop_api.release();
            $('#saveBtn').val("保存数据");
            $('#testBtn').val("修改数据");
            $('#testBtOver').val("结束");
            idAll = null;
            idOne = null;
        }
        else {
            var $urlDiv = $('#urlDiv').children("div");
            var index = $urlDiv.length;
            if ($("#urlText").val() == "") {
                showDialog("请填写热点链接", 'error');
            }
            else {
                var htmlText = [];
                htmlText.push("<div class='urlDivOne' id='p_", index + 1, "'");
                htmlText.push("data-x1='", $('#x1').val(), "'");
                htmlText.push("data-x2='", $('#x2').val(), "'");
                htmlText.push("data-y1='", $('#y1').val(), "'");
                htmlText.push("data-y2='", $('#y2').val(), "'");
                htmlText.push("data-url=", $("#urlText").val());
                htmlText.push(">");
                htmlText.push($("#urlText").val());
                htmlText.push("</div>");
                $('#urlDiv').append(htmlText.join(""));
                htmlText = [];
                htmlText.push(
                    "<area shape='rect' coords='",
                    $('#x1').val(),
                    ",",
                    $('#y1').val(),
                    ",",
                    $('#x2').val(),
                    ",",
                    $('#y2').val(),
                    "' href ='",
                    $("#urlText").val(),
                    "' id='area_",
                    index + 1,
                    "' imgW='",
                    jcrop_api.getBounds(),
                    "'/>"
                );
                $('#testmap').append(htmlText.join(""));
                var htmlTextOne = [];
                htmlTextOne.push($("#testArea").val());
                for (var i = 0; i < htmlText.length; i++) {
                    htmlTextOne.push(htmlText[i]);
                }
                $('#testArea').val(htmlTextOne);
                jcrop_api.release();
                $('#saveBtn').val("保存数据");
                $('#testBtn').val("修改数据");
                $('#testBtOver').val("结束");
            }
            idAll = null;
            idOne = null;
        }
    }
    );
    $('#testBtn').click(function() {
        jcrop_api.destroy();
        var htmlText = [];
        $(".urlDivOne").click(function() {
            $('#target').Jcrop({
                onChange : showCoords,
                onSelect : showCoords,
                onRelease : clearCoords
            }, function() {
                jcrop_api = this;
            });
            var x1 = $(this).attr('data-x1');
            var x2 = $(this).attr('data-x2');
            var y1 = $(this).attr('data-y1');
            var y2 = $(this).attr('data-y2');
            jcrop_api.setSelect([x1, y1, x2, y2]);
            var text = $(this).html();
            $('#urlText').val(text);
            idAll = $(this).attr('id');
            idOne = idAll.substring(2, 3);
        });
    });
    $('#testBtOver').click(function() {
        $("#target").attr("onload", "imgShow()");
        $("#hotDiv").hide();
        $("#inline").hide();
        $("#btGroup").hide();
        jcrop_api.destroy();
        $("#target").attr("onload","imgShow()");
        var script = [];
        script.push('<script>');
        script.push('function imgShow(){');
        script.push('var targetW = $("#target").width();');
        script.push('var targetH = $("#target").height();');
        script.push('$("#testmap area").each(function() {');
        script.push('var coordStr = $(this).attr("coords");');
        script.push('var imgW = $(this).attr("imgW").split(",")[0];');
        script.push('var imgH = $(this).attr("imgW").split(",")[1];');
        script.push('var parmsW = parseInt(targetW) / parseInt(imgW);');
        script.push('var parmsH = parseInt(targetH) / parseInt(imgH);');
        script.push('var coordTmp = [];');
        script.push('$.each(coordStr.split(","), function(i, n) {');
        script.push('coordTmp.push(n * (i%2==0?parmsW:parmsH));');
        script.push('});');
        script.push('$(this).attr("coords", coordTmp.join(","));');
        script.push('});');
        script.push('}');
        script.push('</script>');
        CKEDITOR.instances.vipPageContent.setData($("#hotDiv").html() + script.join(""));
    });
}