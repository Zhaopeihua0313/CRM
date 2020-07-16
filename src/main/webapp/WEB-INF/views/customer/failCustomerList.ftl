<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>客户池</title>
    <#include "../common/link.ftl">
    <script>
        $(function () {

            //吸纳客户
            $(".absorbBtn").click(function () {
                var json = $(this).data("json");
                $.messager.confirm("温馨提示", "是否确认吸纳员工：" + json.name + " ?", function () {
                    $.post("/customer/updateStatus.do", {"status" : 0, "id" : json.id} , function (data) {
                        handlerMessage(data);
                    });
                });
            });

            //客户移交操作并记录
            var newSellerSelectElement = $("#newSellerDiv select[name='newSeller.id']").clone(); //页面加载完毕后保存原有元素副本
            $(".transferBtn").click(function () {
                var json = $(this).data("json"); //获取到绑定在编辑按钮上的json数据并转换为js对象
                $("#transferEditForm input[name='customer.id']").val(json.id); //回显客户id
                $("#transferEditForm input[name=customerName]").val(json.name); //回显客户姓名
                $("#transferEditForm input[name='oldSeller.id']").val(json.oldSellerId); //回显客户id
                $("#newSellerDiv select[name='newSeller.id']").remove(); //清除原有元素
                $("#newSellerDiv").append(newSellerSelectElement.clone()); //重新添加元素
                $("#newSellerDiv select option[value=" + json.oldSellerId + "]").remove(); //移除旧客户的option
                $("#transferEditForm input[name=oldSellerName]").val(json.oldSellerName); //回显旧销售员姓名
                $("#transferModal").modal("show");
            });

            //提交表单
            $("#transferSubmitBtn").click(function () {
                if ($("#newSellerDiv select[name='newSeller.id']").val() == -1){
                    $.messager.alert("请选择新销售人员！");
                    return;
                }
                //（针对button按钮用, 把表单转换为异步形式并马上提交）
                $("#transferEditForm").ajaxSubmit(function (data) {
                    handlerMessage(data);
                });
            });

            //重置表单
            $("#transferReset").click(function () {
                $("#transferEditForm textarea[name=reason]").val("");
                $("#transferEditForm select[name='newSeller.id']").val("-1");
            });

        });
    </script>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="failCustomer"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>失败客户</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px" id="searchForm" action="/customer/failCustomerList.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">关键字:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" value="${qo.keyword!}" placeholder="请输入姓名/手机号">
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
                            <th>操作</th>
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
                                <td>
                                    <a class="btn btn-primary btn-xs absorbBtn" data-json='${entity.json}'>
                                        <span class="glyphicon glyphicon-pencil"></span> 吸纳
                                    </a>
                                    <a class="btn btn-warning btn-xs transferBtn" data-json='${entity.json}'>
                                        <span class="glyphicon glyphicon-pencil"></span> 移交
                                    </a>
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

<!-- 客户移交模态框 -->
<div class="modal fade" id="transferModal" tabindex="-1" role="dialog" aria-labelledby="transferModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="font-size: 30px;">&times;</span></button>
                <h4 class="modal-title" id="transferModalLabel">客户移交</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTransfer/saveOrUpdate.do" method="post" id="transferEditForm">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="customerName" class="col-sm-3 control-label">客户姓名：</label>
                        <div class="col-sm-6">
                            <input type="hidden" name="customer.id">
                            <input type="text" class="form-control" id="customerName" name="customerName" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="oldSellerName" class="col-sm-3 control-label">旧营销人员：</label>
                        <div class="col-sm-6">
                            <input type="hidden" name="oldSeller.id">
                            <input type="text" class="form-control" id="oldSellerName" name="oldSellerName" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="newSeller" class="col-sm-3 control-label">新营销人员：</label>
                        <div class="col-sm-6" id="newSellerDiv">
                            <select class="form-control" id="newSellerId" name="newSeller.id">
                                <option value="-1">请选择</option>
                                <#list emps! as e>
                                    <option value="${(e.id)!}">${(e.name)!}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="reason" class="col-sm-3 control-label">移交原因：</label>
                        <div class="col-sm-6">
                            <textarea placeholder="请输入移交原因" class="form-control" id="reason" name="reason"  style="resize: none;"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="transferSubmitBtn" type="button" class="btn btn-primary">保存</button>
                <button id="transferReset" type="button" class="btn btn-default">重置</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>

