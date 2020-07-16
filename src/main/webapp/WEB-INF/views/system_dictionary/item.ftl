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
                $("#editForm input[id=catalog_title]").val($(".dicDir[data-pid='${qo.parentId}']").text());
                $("#systemDictionaryItemModalLabel").text("字典明细新增");
                $("#systemDictionaryItemModal").modal("show");
            });
            //更新, 模态框回显数据
            $(".update").click(function () {
                var json = $(this).data("json");
                $("#editForm input[name=id]").val(json.id);
                $("#editForm input[id=catalog_title]").val($(".dicDir[data-pid='${qo.parentId}']").text());
                $("#editForm input[name=title]").val(json.title);
                $("#editForm input[name=sequence]").val(json.sequence);
                $("#systemDictionaryItemModalLabel").text("字典明细编辑");
                $("#systemDictionaryItemModal").modal("show");
            });

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
                var id = $(this).data("id");
                $.messager.confirm("温馨提示", "是否确认删除?", function () {
                    $.post("/systemDictionaryItem/delete.do", {"id" : id} , function (data) {
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
    <#assign currentMenu="systemDictionaryItem"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>字典明细</h1>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-xs-2">
                    <div class="panel panel-info">
                        <div class="panel-heading"><strong>字典目录</strong></div>
                        <ul class="list-group" id="dicDirUl">
                            <#list dics! as d>
                                <li class="list-group-item"><a class="dicDir" data-pid="${d.id}" href="/systemDictionaryItem/list.do?parentId=${d.id}">${d.title}</a></li>
                            </#list>
                            <script>
                                $(".dicDir[data-pid='${qo.parentId}']").closest("li").addClass("active");
                                $(".dicDir[data-pid='${qo.parentId}']").css("color","white")
                            </script>
                        </ul>
                    </div>
                </div>
                <div class="col-xs-10">
                    <div class="box">
                        <!--高级查询--->
                        <form class="form-inline" style="margin: 10px" id="searchForm" action="/systemDictionaryItem/list.do" method="post">
                            <input type="hidden" name="currentPage" id="currentPage" value="1">
                            <input type="hidden" name="parentId" value="${(qo.parentId)!}">
                            <@shiro.hasPermission name="systemDictionaryItem:saveOrUpdate">
                                <a class="btn btn-success btn-input save"><span class="glyphicon glyphicon-plus"></span>添加</a>
                            </@shiro.hasPermission>
                        </form>
                        <!--编写内容-->
                        <div class="box-body table-responsive no-padding ">
                            <table class="table table-hover table-bordered">
                                <tr>
                                    <th>编号</th>
                                    <th>标题</th>
                                    <th>序号</th>
                                    <th>操作</th>
                                </tr>
                                <#list (result.list)! as entity>
                                    <tr>
                                        <td>${entity_index + 1}</td>
                                        <td>${entity.title!}</td>
                                        <td>${entity.sequence!}</td>
                                        <td>
                                            <@shiro.hasPermission name="systemDictionaryItem:saveOrUpdate">
                                                <a class="btn btn-info btn-xs btn-input update" data-json='${entity.json}'>
                                                    <span class="glyphicon glyphicon-pencil"></span> 编辑
                                                </a>
                                            </@shiro.hasPermission>
                                            <@shiro.hasPermission name="systemDictionaryItem:delete">
                                                <a class="btn btn-danger btn-xs btn-delete" data-id="${entity.id}">
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
                </div>
            </div>
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>

<div class="modal fade" id="systemDictionaryItemModal" tabindex="-1" role="dialog" aria-labelledby="systemDictionaryItemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="font-size: 30px;">×</span></button>
                <h4 class="modal-title" id="systemDictionaryItemModalLabel"></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/systemDictionaryItem/saveOrUpdate.do?parentId=${(qo.parentId)!}" method="post" id="editForm">
                    <input type="hidden" name="id">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="catalog_title" class="col-sm-2 control-label">字典目录</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="catalog_title" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="title" class="col-sm-2 control-label">明细标题：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="title" name="title" placeholder="请输入标题名">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="sequence" class="col-sm-2 control-label">明细序号：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="sequence" name="sequence" placeholder="请输入序号">
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

