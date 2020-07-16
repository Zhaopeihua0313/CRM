<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>潜在客户</title>
    <#include "../common/link.ftl">
    <script src="/js/plugins/My97DatePicker/WdatePicker.js"></script>
    <script>
        $(function () {

            //绑定My97DatePicker日期插件
            $("#traceTime").focus(function () {
                WdatePicker({
                    //dateFmt:'yyyy-MM-dd HH:mm:ss',
                    readOnly:true,
                    maxDate:new Date()
                });
            });

            //==============================
            //新增/编辑潜在客户
            //新增
            $(".save").click(function () {
                $("#editForm input").val("");
                $("#editForm select").val("-1");
                $("#customerModalLabel").text("潜在客户新增");
                $("#customerModal").modal("show");
            });
            //更新, 模态框回显数据
            $(".update").click(function () {
                var json = $(this).data("json");
                $("#editForm input[name=id]").val(json.id);
                $("#editForm input[name=customerName]").val(json.name);
                $("#editForm input[name=age]").val(json.age);
                $("#editForm select[name=gender]").val(json.gender);
                $("#editForm input[name=tel]").val(json.tel);
                $("#editForm input[name=qq]").val(json.qq);
                $("#editForm select[name='job.id']").val(json.jobId);
                $("#editForm select[name='source.id']").val(json.sourceId);
                $("#customerModalLabel").text("潜在客户编辑");
                $("#customerModal").modal("show");
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
                $("#editForm select").val("-1");
            });

            //==============================
            //客户跟进操作并记录
            $(".traceBtn").click(function () {
                var json = $(this).data("json"); //获取到绑定在编辑按钮上的json数据并转换为js对象
                $("#traceEditForm input[name='customer.id']").val(json.id); //回显客户id
                $("#traceEditForm input[name=customerName]").val(json.name); //回显客户姓名
                $("#traceModal").modal("show");
            });

            //提交表单
            $("#traceSubmitBtn").click(function () {
                //（针对button按钮用, 把表单转换为异步形式并马上提交）
                $("#traceEditForm").ajaxSubmit(function (data) {
                    handlerMessage(data);
                });
            });

            //重置表单
            $("#traceReset").click(function () {
                $("#traceEditForm input[name=traceTime]").val("");
                $("#traceEditForm input[name=traceDetails]").val("");
                $("#traceEditForm textarea[name=remark]").val("");
                $("#traceEditForm select").val("-1");
            });

            //==============================
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

            //==============================
            //修改客户状态
            $(".statusBtn").click(function () {
                var json = $(this).data("json"); //获取到绑定在编辑按钮上的json数据并转换为js对象
                $("#changeStatusEditForm input[name=id]").val(json.id); //回显客户id
                $("#changeStatusEditForm input[name=customerName]").val(json.name); //回显客户姓名
                $("#changeStatusEditForm select[name=status]").val(json.status); //回显客户当前状态
                $("#changeStatusModal").modal("show");
            });

            //提交表单
            $("#changeStatusSubmitBtn").click(function () {
                //（针对button按钮用, 把表单转换为异步形式并马上提交）
                $("#changeStatusEditForm").ajaxSubmit(function (data) {
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
    <#assign currentMenu="potentialCustomer"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>潜在客户管理</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px" id="searchForm" action="/customer/potentialCustomerList.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">关键字:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" value="${qo.keyword!}" placeholder="请输入姓名/手机号">
                    </div>
                    <@shiro.hasAnyRoles name="ADMIN, MM">
                        <div class="form-group">
                            <label for="dept"> 销售员:</label>
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
                    <@shiro.hasAnyRoles name="ADMIN, MM">
                        <a class="btn btn-success btn-input save" type="button"><span class="glyphicon glyphicon-plus"></span>添加</a>
                    </@shiro.hasAnyRoles>
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
                                    <a class="btn btn-info btn-xs btn-input update" data-json='${entity.json}'>
                                        <span class="glyphicon glyphicon-pencil"></span> 编辑
                                    </a>
                                    <a class="btn btn-primary btn-xs traceBtn" data-json='${entity.json}'>
                                        <span class="glyphicon glyphicon-heart"></span> 跟进
                                    </a>
                                    <a class="btn btn-warning btn-xs transferBtn" data-json='${entity.json}'>
                                        <span class="glyphicon glyphicon-share-alt"></span> 移交
                                    </a>
                                    <a class="btn btn-danger btn-xs statusBtn" data-json='${entity.json}'>
                                        <span class="glyphicon glyphicon-cog"></span> 修改状态
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

<!-- 新增潜在客户模态框 -->
<div class="modal fade" id="customerModal" tabindex="-1" role="dialog" aria-labelledby="customerModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="font-size: 30px;">&times;</span></button>
                <h4 class="modal-title" id="customerModalLabel"></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customer/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" name="id">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="customerName" class="col-sm-3 control-label">客户姓名：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="customerName" name="customerName" placeholder="请输入客户名称">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="age" class="col-sm-3 control-label">客户年龄：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="age" name="age" placeholder="请输入客户年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="gender" class="col-sm-3 control-label">客户性别：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="gender" name="gender">
                                <option value="-1">请选择</option>
                                <option value="0">女</option>
                                <option value="1">男</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="tel" class="col-sm-3 control-label">客户电话：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="tel" name="tel" placeholder="请输入客户电话">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="qq" class="col-sm-3 control-label">客户QQ：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="qq" name="qq" placeholder="请输入客户QQ">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="job" class="col-sm-3 control-label">客户工作：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="job" name="job.id">
                                <option value="-1">请选择</option>
                                <#list jobs! as job>
                                    <option value="${(job.id)!}">${(job.title)!}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="source" class="col-sm-3 control-label">客户来源：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="source" name="source.id">
                                <option value="-1">请选择</option>
                                <#list sources! as source>
                                    <option value="${(source.id)!}">${(source.title)!}</option>
                                </#list>
                            </select>
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

<!-- 新增客户跟进模态框 -->
<div class="modal fade" id="traceModal" tabindex="-1" role="dialog" aria-labelledby="traceModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="font-size: 30px;">&times;</span></button>
                <h4 class="modal-title" id="traceModalLabel">客户跟进</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTraceHistory/saveOrUpdate.do" method="post" id="traceEditForm">
                    <input type="hidden" name="type" value="0">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="customerName" class="col-sm-3 control-label">客户姓名：</label>
                        <div class="col-sm-6">
                            <input type="hidden" name="customer.id">
                            <input type="text" class="form-control" id="customerName" name="customerName" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="traceTime" class="col-sm-3 control-label">跟进时间：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="traceTime" name="traceTime" placeholder="请选择跟进时间">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="traceDetails" class="col-sm-3 control-label">跟进内容：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="traceDetails" name="traceDetails" placeholder="请输入跟进记录">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="traceType" class="col-sm-3 control-label">跟进方式：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="traceType" name="traceType.id">
                                <option value="-1">请选择</option>
                                <#list traceTypes! as t>
                                    <option value="${(t.id)!}">${(t.title)!}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="traceResult" class="col-sm-3 control-label">跟进结果：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="traceResult" name="traceResult">
                                <option value="-1">请选择</option>
                                <option value="0">差</option>
                                <option value="1">中</option>
                                <option value="2">优</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="remark" class="col-sm-3 control-label">备注：</label>
                        <div class="col-sm-6">
                            <textarea placeholder="请输入备注信息" class="form-control" id="remark" name="remark"  style="resize: none;"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="traceSubmitBtn" type="button" class="btn btn-primary">保存</button>
                <button id="traceReset" type="button" class="btn btn-default">重置</button>
            </div>
        </div>
    </div>
</div>

<!-- 新增客户移交模态框 -->
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

<!-- 修改状态模态框 -->
<div class="modal fade" id="changeStatusModal" tabindex="-1" role="dialog" aria-labelledby="changeStatusModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="font-size: 30px;">&times;</span></button>
                <h4 class="modal-title" id="changeStatusModalLabel">修改客户状态</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customer/updateStatus.do" method="post" id="changeStatusEditForm">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="customerName" class="col-sm-3 control-label">客户姓名：</label>
                        <div class="col-sm-6">
                            <input type="hidden" name="id">
                            <input type="text" class="form-control" id="customerName" name="customerName" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="oldSellerName" class="col-sm-3 control-label">客户状态：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="status" name="status">
                                <option value="0">潜在客户</option>
                                <option value="1">正式客户</option>
                                <option value="2">客户池客户</option>
                                <option value="3">开发失败客户</option>
                                <option value="4">流失客户</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="changeStatusSubmitBtn" type="button" class="btn btn-primary">保存</button>
                <button id="changeStatusReset" type="button" class="btn btn-default">重置</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>

