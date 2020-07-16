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
                $("#systemDictionaryModalLabel").text("字典目录新增");
                $("#systemDictionaryModal").modal("show");
            });
            //更新, 模态框回显数据
            $(".update").click(function () {
                var json = $(this).data("json");
                $("#editForm input[name=id]").val(json.id);
                $("#editForm input[name=title]").val(json.title);
                $("#editForm input[name=intro]").val(json.intro);
                $("#editForm input[name=sn]").val(json.sn);
                $("#systemDictionaryModalLabel").text("字典目录编辑");
                $("#systemDictionaryModal").modal("show");
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
                    $.post("/systemDictionary/delete.do", {"id" : id} , function (data) {
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
    <#assign currentMenu="systemDictionary"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>字典目录</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px" id="searchForm" action="/systemDictionary/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <@shiro.hasPermission name="systemDictionary:saveOrUpdate">
                        <a class="btn btn-success btn-input save"><span class="glyphicon glyphicon-plus"></span>添加</a>
                    </@shiro.hasPermission>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>编号</th>
                            <th>标题</th>
                            <th>编码</th>
                            <th>简介</th>
                            <th>操作</th>
                        </tr>
                        <#list (result.list)! as entity>
                            <tr>
                                <td>${entity_index + 1}</td>
                                <td>${entity.title!}</td>
                                <td>${entity.sn!}</td>
                                <td>${entity.intro!}</td>
                                <td>
                                    <@shiro.hasPermission name="systemDictionary:saveOrUpdate">
                                        <a class="btn btn-info btn-xs btn-input update" data-json='${entity.json}'>
                                            <span class="glyphicon glyphicon-pencil"></span> 编辑
                                        </a>
                                    </@shiro.hasPermission>
                                    <@shiro.hasPermission name="systemDictionary:delete">
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
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>

<div class="modal fade" id="systemDictionaryModal" tabindex="-1" role="dialog" aria-labelledby="systemDictionaryModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="systemDictionaryModalLabel"></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/systemDictionary/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" name="id">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="title" class="col-sm-2 control-label">标题：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="title" name="title" placeholder="请输入标题名">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="intro" class="col-sm-2 control-label">简介：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="intro" name="intro" placeholder="请输入简介">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="sn" class="col-sm-2 control-label">编码：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="sn" name="sn" placeholder="请输入编码">
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

