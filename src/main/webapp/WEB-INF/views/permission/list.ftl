<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>权限管理</title>
    <#include "../common/link.ftl">
    <script>
        $(function () {

            $(".btn_reload").click(function () {
                $.get("/permission/reload.do", function (data) {
                    if (data.success){
                        window.location.reload(); //重新加载当前页面
                    }else {
                        alert(data.msg);
                    }
                });
            });

            $(".btn-delete").click(function () {
                var json = $(this).data("json");
                $.messager.confirm("温馨提示", "是否确认删除权限：" + json.name + " ?", function () {
                    $.post("/permission/delete.do", {"id" : json.id} , function (data) {
                        handlerMessage(data);
                    });
                });
            });

        });
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="permission"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>权限管理</h1>
        </section>
        <section class="content">
            <div class="box" >
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px" id="searchForm" action="/permission/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <a href="javascript:;" class="btn btn-success btn_reload" style="margin: 10px;">
                        <span class="glyphicon glyphicon-repeat"></span>  重新加载
                    </a>
                </form>

                <table class="table table-striped table-hover" >
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>权限名称</th>
                        <th>权限表达式</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <#list (result.list)! as entity>
                       <tr>
                           <td>${entity_index + 1}</td>
                           <td>${entity.name!}</td>
                           <td>${entity.expression!}</td>
                           <td>
                               <@shiro.hasPermission name="permission:delete">
                                   <a class="btn btn-danger btn-xs btn-delete" data-json='${entity.json}'>
                                       <span class="glyphicon glyphicon-trash"></span> 删除
                                   </a>
                               </@shiro.hasPermission>
                           </td>
                       </tr>
                    </#list>
                    </table>
                <!--分页-->
                <#include "../common/page.ftl">
            </div>
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>
</body>
</html>
