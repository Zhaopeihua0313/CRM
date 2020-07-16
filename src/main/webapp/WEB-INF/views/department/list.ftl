<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>部门管理</title>
    <#include "../common/link.ftl">
    <script>
        $(function () {

            //新增
            $(".save").click(function () {
                $("#editForm input").val("");
                $("#departmentModalLabel").text("部门新增");
                $("#departmentModal").modal("show");
            });
            //更新, 模态框回显数据
            $(".update").click(function () {
                var json = $(this).data("json");
                $("#editForm input[name=id]").val(json.id);
                $("#editForm input[name=name]").val(json.name);
                $("#editForm input[name=sn]").val(json.sn);
                $("#departmentModalLabel").text("部门编辑");
                $("#departmentModal").modal("show");
            });

            //异步提交表单
            //方式一（针对submit按钮用, 把表单转换为异步形式但不提交表单）
            /*$("#editForm").ajaxForm(function (data) {
                if (data.success){
                    window.location.reload();
                }else {
                    alert(data.msg);
                }
            });*/
            //方式二
            $("#submitBtn").click(function () {
                //（针对button按钮用, 把表单转换为异步形式并马上提交）
                $("#editForm").ajaxSubmit(function (data) {
                    handlerMessage(data);
                });
            });

            //重置表单
            $("#reset").click(function () {
                $("#editForm input").val("");
            });

            $(".btn-delete").click(function () {
                var json = $(this).data("json");
                $.messager.confirm("温馨提示", "是否确认删除部门：" + json.name + " ?", function () {
                    $.post("/department/delete.do", {"id" : json.id} , function (data) {
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
    <#assign currentMenu="department"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>部门管理</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px" id="searchForm" action="/department/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <@shiro.hasPermission name="department:saveOrUpdate">
                        <a class="btn btn-success btn-input save"><span class="glyphicon glyphicon-plus"></span>添加</a>
                    </@shiro.hasPermission>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>编号</th>
                            <th>部门名称</th>
                            <th>部门编号</th>
                            <th>操作</th>
                        </tr>
                        <#list (result.list)! as entity>
                            <tr>
                                <td>${entity_index + 1}</td>
                                <td>${entity.name!}</td>
                                <td>${entity.sn!}</td>
                                <td>
                                    <@shiro.hasPermission name="department:saveOrUpdate">
                                        <a class="btn btn-info btn-xs btn-input update" data-json='${entity.json}'>
                                            <span class="glyphicon glyphicon-pencil"></span> 编辑
                                        </a>
                                    </@shiro.hasPermission>
                                    <@shiro.hasPermission name="department:delete">
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

<div class="modal fade" id="departmentModal" tabindex="-1" role="dialog" aria-labelledby="departmentModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="font-size: 30px;">&times;</span></button>
                <h4 class="modal-title" id="departmentModalLabel"></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/department/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" value="" name="id">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="name" class="col-sm-2 control-label">名称：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name" value="" placeholder="请输入部门名">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="sn" class="col-sm-2 control-label">编码：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="sn" name="sn" value="" placeholder="请输入部门编码">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="submitBtn" type="button" class="btn btn-primary">保存</button>
                <button id="reset" type="button" class="btn btn-default">重置</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>

