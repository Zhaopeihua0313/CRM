<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>移交历史</title>
    <#include "../common/link.ftl">
    <script>
        $(function () {
            $("#btn_query").click(function () {
                //（针对button按钮用, 把表单转换为异步形式并马上提交）
                $("#editForm").ajaxForm(function (data) {
                    handlerMessage(data);
                });
            });
        })
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="customerTransfer"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>跟进历史管理</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px;"  id="searchForm" action="/customerTransfer/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">关键字:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" value="${qo.keyword!}" placeholder="请输入客户姓名">
                    </div>
                    <button type="submit" id="btn_query" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> 查询</button>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>编号</th>
                            <th>客户姓名</th>
                            <th>操作日期</th>
                            <th>操作人</th>
                            <th>旧营销人员</th>
                            <th>新营销人员</th>
                            <th>移交原因</th>
                        </tr>
                        <#list (result.list)! as entity>
                            <tr>
                                <td>${entity_index + 1}</td>
                                <td>${(entity.customer.name)!}</td>
                                <td>${(entity.operateTime?string("yyyy-MM-dd HH:mm:ss"))!} </td>
                                <td>${(entity.operator.name)!}</td>
                                <td>${(entity.oldSeller.name)!}</td>
                                <td>${(entity.newSeller.name)!}</td>
                                <td>${entity.reason!}</td>
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

