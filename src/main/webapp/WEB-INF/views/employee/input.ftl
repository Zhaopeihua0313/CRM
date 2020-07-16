<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>员工管理</title>
    <#include "../common/link.ftl">
    <script>

        function moveSelected(src, target) {
            $("." + target).append($("." + src + " option:selected"));
        }

        function moveAll(src, target) {
            $("." + target).append($("." + src + " option"));
        }

        $(function () {

            var titleText = $(".content-header h1:first");
            <#if !employee??>
                titleText.text("员工新增");
            <#else>
                titleText.text("员工编辑");
            </#if>

            //根据当前登录用户是否是超级管理员判断角色分配功能是否显示
            var roleDiv;
            $("#admin").click(function () {
                if ($("#admin").prop("checked")){ //判断是否是勾选状态
                    roleDiv = $("#role").detach();
                }else {
                    $("#adminDiv").after(roleDiv);
                }
            });

            if ($("#admin").prop("checked")){
                roleDiv = $("#role").detach();
            }

            //JQuery Validate插件验证表单
            $("#editForm").validate({
                rules:{
                    <#if !employee??>
                        name:{
                            required:true, //必填字段
                            rangelength:[2, 10], //输入长度限制
                            remote:"/employee/checkName.do" //Ajax请求资源路径
                        },
                    </#if>
                    password:{
                        required:true
                    },
                    repassword:{
                        required:true,
                        equalTo:"#password"
                    },
                    email:{
                        email:true
                    },
                    age:{
                        digits:true,
                        range:[18, 60]
                    }
                },
                messages:{
                    name:{
                        required:"必填",
                        rangelength:"长度必须在{0}-{1}之间",
                        remote:"用户名已存在"
                    },
                    password:{
                        required:"必填"
                    },
                    repassword:{
                        required:"必填",
                        equalTo:"必须与密码保持一致"
                    },
                    email:{
                        email:"电子邮件地址格式不正确"
                    },
                    age:{
                        digits:"必须是整数",
                        range:"数值必须在{0}-{1}之间"
                    }
                },
                errorClass:"text-danger",
                /*submitHandler:function() {
                    $("#editForm").ajaxSubmit(function () {

                    });
                }*/
            });

            $("#submitBtn").click(function () {
                $(".selfRoles option").prop("selected", true);
                var rid = $(".selfRoles option:selected");
                if (rid.length == 0){
                    $.messager.alert("员工角色不能为空，请最少为员工分配一个角色！");
                    return;
                }
            });

            //异步提交表单
            $("#editForm").ajaxForm(function (data) {
                if (data.success){
                    $.messager.confirm("温馨提示", "操作成功", function () {
                        window.location.href = "/employee/list.do";
                    });
                }else {
                    $.messager.alert("温馨提示", data.msg);
                }
            });

        })

    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu = "employee">
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                <#if !employee??>
                    员工新增
                <#else>
                    员工编辑
                </#if>
            </h1>
        </section>
        <section class="content">
            <div class="box">
                <form class="form-horizontal" action="/employee/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" value="${(employee.id)!}" name="id" >
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="name" class="col-sm-2 control-label">用户名：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name" value="${(employee.name)!}" placeholder="请输入用户名" <#if employee??>readonly</#if>><#-- 编辑的时候不显示密码，新增才显示 -->
                        </div>
                    </div>
                    <#if !employee??> <#-- 编辑的时候不显示密码，新增才显示 -->
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">密码：</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="repassword" class="col-sm-2 control-label">验证密码：</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="repassword" name="repassword" placeholder="再输入一遍密码">
                            </div>
                        </div>
                    </#if>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">电子邮箱：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="email" name="email" value="${(employee.email)!}" placeholder="请输入邮箱">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">年龄：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="age" name="age" value="${(employee.age)!}" placeholder="请输入年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept" class="col-sm-2 control-label">部门：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="dept" name="dept.id">
                                <#list depts! as d>
                                    <option value="${(d.id)!}">${(d.name)!}</option>
                                </#list>
                            </select>
                            <script>
                                $("#dept").val(${(employee.dept.id)!});
                            </script>
                        </div>
                    </div>
                    <div class="form-group" id="adminDiv">
                        <label for="admin" class="col-sm-2 control-label">超级管理员：</label>
                        <div class="col-sm-6"style="margin-left: 15px;">
                            <input type="checkbox" id="admin" name="admin" class="checkbox">
                            <#if (employee.admin)!false>
                                <script>
                                    $("#admin").prop("checked", true); //如果是超级管理员则选中复选框
                                </script>
                            </#if>
                        </div>
                    </div>
                    <div class="form-group " id="role">
                        <label for="role" class="col-sm-2 control-label">分配角色：</label><br/>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-2 col-sm-offset-2">
                                <select multiple class="form-control allRoles" size="15">
                                    <#list roles! as r>
                                        <option value="${r.id}">${(r.name)!}</option>
                                    </#list>
                                </select>
                            </div>

                            <div class="col-sm-1" style="margin-top: 60px;" align="center">
                                <div>

                                    <a type="button" class="btn btn-primary" style="margin-top: 10px" title="右移动"
                                       onclick="moveSelected('allRoles', 'selfRoles')">
                                        <span class="glyphicon glyphicon-menu-right"></span>
                                    </a>
                                </div>
                                <div>
                                    <a type="button" class="btn btn-primary " style="margin-top: 10px" title="左移动"
                                       onclick="moveSelected('selfRoles', 'allRoles')">
                                        <span class="glyphicon glyphicon-menu-left"></span>
                                    </a>
                                </div>
                                <div>
                                    <a type="button" class="btn btn-primary " style="margin-top: 10px" title="全右移动"
                                       onclick="moveAll('allRoles', 'selfRoles')">
                                        <span class="glyphicon glyphicon-forward"></span>
                                    </a>
                                </div>
                                <div>
                                    <a type="button" class="btn btn-primary " style="margin-top: 10px" title="全左移动"
                                       onclick="moveAll('selfRoles', 'allRoles')">
                                        <span class="glyphicon glyphicon-backward"></span>
                                    </a>
                                </div>
                            </div>

                            <div class="col-sm-2">
                                <select multiple class="form-control selfRoles" size="15" name="ids">
                                    <#list (employee.roles)! as r>
                                        <option value="${r.id}">${(r.name)!}</option>
                                    </#list>
                                </select>
                                <script>
                                    //去掉重复的option
                                    var ids = [];
                                    $(".selfRoles option").each(function (index, ele) {
                                        ids.push($(ele).val());
                                    });
                                    $(".allRoles option").each(function (index, ele) {
                                        if ($.inArray(ele.value, ids) != -1) {
                                            $(ele).remove();
                                        }
                                    })
                                </script>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-6">
                            <button id="submitBtn" type="submit" class="btn btn-primary">保存</button>
                            <button type="reset" class="btn btn-danger">重置</button>
                        </div>
                    </div>
                </form>

            </div>
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>
</body>
</html>
