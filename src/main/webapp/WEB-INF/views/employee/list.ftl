<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>员工管理</title>
    <#include "../common/link.ftl">
    <script>
        $(function () {

            //全选复选框时间
            $("#checkAll").click(function () {
                $(".cb").prop("checked", $("#checkAll").prop("checked"));
            });

            //复选框选择状态随已选中的复选框个数改变
            $(".cb").click(function () {
                $("#checkAll").prop("checked", $(".cb:checked").length == $(".cb").length);
            });

            $(".btn_delete").click(function () {
                var json = $(this).data("json");
                $.messager.confirm("温馨提示", "是否确认删除员工：" + json.name + " ?", function () {
                    $.post("/employee/delete.do", {"id" : json.id} , function (data) {
                        handlerMessage(data);
                    });
                });
            });

            //判断是否选中要删除的数据是否为空并发送批量删除的异步请求
            $("#batchDelete").click(function () {
                if ($(".cb:checked").length == 0){
                    $.messager.alert("温馨提示", "没有选中任何数据");
                    return;
                }
                $.messager.confirm("温馨提示", "是否确认批量删除员工?", function () {
                    var arr = $(".cb:checked");
                    var ids = $.map(arr, function (ele) {
                        return $(ele).data("id");
                    });
                    /*var ids = [];
                    $.each(arr, function (index, ele) {
                        ids.push($(ele).data("id"));
                    });*/
                    $.post("/employee/batchDelete.do", {"ids": ids}, handlerMessage); //直接赋值给回调函数一个函数名的写法
                });
            });

            $("#importXls").click(function () {
                $("#departmentModal").modal("show");
            });

            $("#submitBtn").click(function () {
                $("#editForm").ajaxSubmit(function (data) {
                    handlerMessage(data);
                });
            });

        });
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="employee"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>员工管理</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <div style="margin: 10px;">
                    <form class="form-inline" style="margin: 10px" id="searchForm" action="/employee/list.do" method="post">
                        <input type="hidden" name="currentPage" id="currentPage" value="1">
                        <div class="form-group">
                            <label for="keyword">关键字:</label>
                            <input type="text" class="form-control" id="keyword" name="keyword" value="${qo.keyword!}" placeholder="请输入姓名/邮箱">
                        </div>
                        <div class="form-group">
                            <label for="dept"> 部门:</label>
                            <select class="form-control" id="dept" name="deptId">
                                <option value="-1">全部</option>
                                <#list depts! as d>
                                    <option value="${d.id}">${d.name!}</option>
                                </#list>
                            </select>
                            <script>
                                $("#dept").val(${qo.deptId}); //回显选择的部门  <#-- $("#dept option[value='${qo.deptId}']").prop("selected", true); -->
                            </script>
                        </div>
                        <button id="btn_query" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> 查询</button>
                        <@shiro.hasPermission name="employee:saveOrUpdate">
                            <a href="/employee/input.do" class="btn btn-success btn_redirect">
                                <span class="glyphicon glyphicon-plus"></span> 添加
                            </a>
                        </@shiro.hasPermission>
                        <@shiro.hasPermission name="employee:delete">
                            <a id="batchDelete" class="btn btn-danger btn_redirect">
                                <span class="glyphicon glyphicon-trash"></span> 批量删除
                            </a>
                        </@shiro.hasPermission>
                        <@shiro.hasPermission name="employee:exportXls">
                            <a href="/employee/exportXls.do" id="exportXls" class="btn btn-warning btn_redirect">
                                <span class="glyphicon glyphicon-export"></span> 导出
                            </a>
                        </@shiro.hasPermission>
                        <@shiro.hasPermission name="employee:importXls">
                            <a id="importXls" class="btn btn-warning btn_redirect">
                                <span class="glyphicon glyphicon-import"></span> 导入
                            </a>
                        </@shiro.hasPermission>
                    </form>
                </div>
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <thead>
                        <tr>
                            <th><input id="checkAll" type="checkbox"></th>
                            <th>编号</th>
                            <th>名称</th>
                            <th>email</th>
                            <th>年龄</th>
                            <th>部门</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <#list (result.list)! as entity>
                            <tr>
                                <td><input type="checkbox" class="cb" data-id="${entity.id}"></td>
                                <td>${entity_index + 1}</td>
                                <td>${entity.name!}</td>
                                <td>${entity.email!}</td>
                                <td>${entity.age!}</td>
                                <td>${(entity.dept.name)!}</td>
                                <td>
                                    <@shiro.hasPermission name="employee:saveOrUpdate">
                                        <a href="/employee/input.do?id=${entity.id}" class="btn btn-info btn-xs btn_redirect">
                                            <span class="glyphicon glyphicon-pencil"></span> 编辑
                                        </a>
                                    </@shiro.hasPermission>
                                    <@shiro.hasPermission name="employee:delete">
                                        <a class="btn btn-danger btn-xs btn_delete" data-json='${entity.json}'>
                                            <span class="glyphicon glyphicon-trash"></span> 删除
                                        </a>
                                    </@shiro.hasPermission>
                                </td>
                            </tr>
                        </#list>
                    </table>
                </div>
                <!--分页-->
                <#include "../common/page.ftl">
            </div>
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>

<div class="modal fade" id="departmentModal" tabindex="-1" role="dialog" aria-labelledby="departmentModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="departmentModalLabel">员工导入</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/employee/importXls.do" method="post" id="editForm" enctype="multipart/form-data">
                    <input type="hidden" value="" name="id">
                    <div class="form-group" style="margin-top: 10px;">
                        <div class="col-sm-6">
                            <input type="file" id="name" name="file" accept="application/vnd.ms-excel">
                            <br>
                            <a href="/template/employee_import.xls" id="importXls" class="btn btn-success">
                                <span class="glyphicon glyphicon-import"></span> 模版下载
                            </a>
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
</div>

</body>
</html>
