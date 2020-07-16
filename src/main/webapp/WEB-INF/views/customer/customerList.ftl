<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>客户列表</title>
    <#include "../common/link.ftl">
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="customer"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>客户列表</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px" id="searchForm" action="/customer/customerList.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">关键字:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" value="${qo.keyword!}" placeholder="请输入姓名/手机号">
                    </div>
                    <div class="form-group">
                        <label for="status"> 状态:</label>
                        <select class="form-control" id="status" name="status">
                            <option value="-1">全部</option>
                            <option value="0">潜在客户</option>
                            <option value="1">正式客户</option>
                            <option value="2">客户池客户</option>
                            <option value="3">开发失败客户</option>
                            <option value="4">流失客户</option>
                        </select>
                        <script>
                            $("#status").val(${qo.status!}); //回显选择的员工
                        </script>
                    </div>
                    <@shiro.hasAnyRoles name="ADMIN, MM">
                        <div class="form-group">
                            <label for="seller"> 销售员:</label>
                            <select class="form-control" id="seller" name="sellerId">
                                <option value="-1">全部</option>
                                <#list emps! as e>
                                    <option value="${e.id}">${e.name!}</option>
                                </#list>
                            </select>
                            <script>
                                $("#seller").val(${qo.sellerId}); //回显选择的员工
                            </script>
                        </div>
                    </@shiro.hasAnyRoles>
                    <button type="submit" id="btn_query" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> 查询</button>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>编号</th>
                            <th>名称</th>
                            <th>年龄</th>
                            <th>性别</th>
                            <th>电话</th>
                            <th>QQ</th>
                            <th>职业</th>
                            <th>来源</th>
                            <th>销售员</th>
                            <th>状态</th>
                        </tr>
                        <#list (result.list)! as entity>
                            <tr>
                                <td>${entity_index + 1}</td>
                                <td>${entity.name!}</td>
                                <td>${entity.age!}</td>
                                <td>
                                    <#if entity.gender! == 0>女</#if>
                                    <#if entity.gender! == 1>男</#if>
                                </td>
                                <td>${entity.tel!}</td>
                                <td>${entity.qq!}</td>
                                <td>${(entity.job.title)!}</td>
                                <td>${(entity.source.title)!}</td>
                                <td>${(entity.seller.name)!}</td>
                                <td>${entity.statusName!}</td>
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

