<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>跟进历史</title>
    <#include "../common/link.ftl">
    <script>

        //转换Date为yy-MM-dd的字符串格式
        function dateToString(date){
            var year = date.getFullYear();
            var month = (date.getMonth() + 1).toString();
            var day = date.getDate().toString();
            var hours = date.getHours().toString();
            var minutes = date.getMinutes().toString();
            var seconds = date.getSeconds().toString();
            if (month.length == 1) {
                month = "0" + month;
            }
            if (day.length == 1) {
                day = "0" + day;
            }
            var d = "";
            if(hours != "0" || minutes != "0" || seconds != "0"){
                if (hours.length == 1) {
                    hours = "0" + hours;
                }
                if (minutes.length == 1) {
                    minutes = "0" + minutes;
                }
                if (seconds.length == 1) {
                    seconds = "0" + seconds;
                }
                d = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
            }else {
                d = year + "-" + month + "-" + day;
            }
            console.log(d);
            return d;
        }

        $(function () {

            //更新, 模态框回显数据
            $(".update").click(function () {
                var json = $(this).data("json");
                $("#editForm input[name=id]").val(json.id); //记录当前id
                $("#editForm input[name=type]").val(json.type); //记录当前type
                $("#editForm input[name=name]").val(json.customerName);
                $("#editForm input[name=traceTime]").val(dateToString(new Date(json.traceTime)));
                $("#editForm input[name=traceDetails]").val(json.traceDetails);
                $("#editForm select[name='traceType.id']").val(json.traceTypeId);
                $("#editForm select[name=traceResult]").val(json.traceResult);
                $("#editForm input[name='inputUser.id']").val(json.inputUserId);
                $("#editForm input[name=inputUserName]").val(json.inputUserName);
                $("#editForm input[name=inputTime]").val(dateToString(new Date(json.inputTime)));
                $("#editForm textarea[name=remark]").text(json.remark);
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
                $("#editForm input[name=traceDetails]").val("");
                $("#editForm select[name='traceType.id']").val("-1");
                $("#editForm select[name=traceResult]").val("-1");
                $("#editForm textarea[name=remark]").text("");
            });

        });

    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="customerTraceHistory"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>跟进历史管理</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px" id="searchForm" action="/customerTraceHistory/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">关键字:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" value="${qo.keyword!}" placeholder="请输入客户姓名">
                    </div>
                    <div class="form-group">
                        <label for="type"> 跟进类型:</label>
                        <select class="form-control" id="type" name="type">
                            <option value="-1">全部</option>
                            <option value="0">潜在客户</option>
                            <option value="1">正式客户</option>
                        </select>
                        <script>
                            $("#type").val(${qo.type!});
                        </script>
                    </div>
                    <button type="submit" id="btn_query" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> 查询</button>
                    <#--<@shiro.hasAnyRoles name="ADMIN, MM">
                    </@shiro.hasAnyRoles>-->
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>编号</th>
                            <th>客户姓名</th>
                            <th>跟进日期</th>
                            <th>跟进内容</th>
                            <th>跟进方式</th>
                            <th>跟进结果</th>
                            <th>录入人</th>
                            <th>录入时间</th>
                            <th>备注</th>
                            <th>跟进类型</th>
                            <th>操作</th>
                        </tr>
                        <#list (result.list)! as entity>
                            <tr>
                                <td>${entity_index + 1}</td>
                                <td>${(entity.customer.name)!}</td>
                                <td>${(entity.traceTime?string("yyyy-MM-dd"))!} </td>
                                <td>${entity.traceDetails!}</td>
                                <td>${(entity.traceType.title)!}</td>
                                <td>
                                    <#if entity.traceResult! == -1></#if>
                                    <#if entity.traceResult! == 0>差</#if>
                                    <#if entity.traceResult! == 1>中</#if>
                                    <#if entity.traceResult! == 2>优</#if>
                                </td>
                                <td>${(entity.inputUser.name)!}</td>
                                <td>${(entity.inputTime?string("yyyy-MM-dd HH:mm:ss"))!}</td>
                                <td>${entity.remark!}</td>
                                <td>
                                    <#if entity.type! == 0>潜在客户开发</#if>
                                    <#if entity.type! == 1>正式客户跟进</#if>
                                </td>
                                <td>
                                    <@shiro.hasAnyRoles name="ADMIN, OC, MM">
                                        <a class="btn btn-info btn-xs btn-input update" data-json='${entity.json}'>
                                            <span class="glyphicon glyphicon-pencil"></span> 编辑
                                        </a>
                                    </@shiro.hasAnyRoles>
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

<div class="modal fade" id="customerModal" tabindex="-1" role="dialog" aria-labelledby="customerModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="font-size: 30px;">&times;</span></button>
                <h4 class="modal-title" id="customerModalLabel">跟进历史编辑</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTraceHistory/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" name="id">
                    <input type="hidden" name="type">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="name" class="col-sm-3 control-label">客户姓名：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="traceTime" class="col-sm-3 control-label">跟进时间：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="traceTime" name="traceTime" readonly>
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
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="inputUserName" class="col-sm-3 control-label">录入人：</label>
                        <div class="col-sm-6">
                            <input type="hidden" class="form-control" id="inputUserId" name="inputUser.id" >
                            <input type="text" class="form-control" id="inputUserName" name="inputUserName" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="inputTime" class="col-sm-3 control-label">录入时间：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="inputTime" name="inputTime" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="remark" class="col-sm-3 control-label">备注：</label>
                        <div class="col-sm-6">
                            <textarea class="form-control" id="remark" name="remark"  style="resize: none;"></textarea>
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

