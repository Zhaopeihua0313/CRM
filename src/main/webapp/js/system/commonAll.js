//抽取的重复js片段
function handlerMessage(data) {
    if (data.success){
        $.messager.confirm("温馨提示", "操作成功", function () {
            window.location.reload(); //重新载入当前页面
        });
        /*//定时刷新
        $.messager.alert("温馨提示", "操作成功, 2秒后自动刷新");
        window.setTimeout(function () {
            window.location.reload(); //重新载入当前页面
        }, 2000);*/
    }else {
        $.messager.alert("温馨提示", data.msg);
    }
}

$.messager.model = {
    ok : {text: "确定", classed: "btn-primary"},
    cancel : {text: "取消", classed: "btn-default"}
}

//禁止提交数组时带[], 批量删除用到
$.ajaxSettings.traditional = true;