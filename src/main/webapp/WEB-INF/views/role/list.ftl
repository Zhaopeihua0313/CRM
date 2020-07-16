<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>角色管理</title>
    <#include "../common/link.ftl">
    <script>

        $(function () {

            $(".btn-delete").click(function () {
                var json = $(this).data("json");
                $.messager.confirm("温馨提示", "是否确认删除角色：" + json.name + " ?", function () {
                    $.post("/role/delete.do", {"id" : json.id} , function (data) {
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
    <#assign currentMenu="role"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>角色管理</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <div style="margin: 10px;">
                    <!--高级查询--->
                    <form class="form-inline" style="margin: 10px" id="searchForm" action="/role/list.do" method="post">
                        <input type="hidden" name="currentPage" id="currentPage" value="1">
                        <@shiro.hasPermission name="role:saveOrUpdate">
                            <a href="/role/input.do" class="btn btn-success btn_redirect"><span class="glyphicon glyphicon-plus"></span> 添加</a>
                        </@shiro.hasPermission>
                    </form>

                    <table class="table table-striped table-hover" >
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>角色名称</th>
                            <th>角色编号</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <#list (result.list)! as entity>
                           <tr>
                               <td>${entity_index + 1}</td>
                               <td>${entity.name!}</td>
                               <td>${entity.sn!}</td>
                               <td>
                                   <@shiro.hasPermission name="role:saveOrUpdate">
                                       <a href="/role/input.do?id=${entity.id}" class="btn btn-info btn-xs btn_redirect">
                                           <span class="glyphicon glyphicon-pencil"></span> 编辑
                                       </a>
                                   </@shiro.hasPermission>
                                   <@shiro.hasPermission name="role:delete">
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
            </div>
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>
</body>
</html>
