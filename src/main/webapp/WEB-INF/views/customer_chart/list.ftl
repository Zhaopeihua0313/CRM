<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>潜在客户报表</title>
    <#include "../common/link.ftl">
    <script src="/js/plugins/My97DatePicker/WdatePicker.js"></script>
    <script>
        $(function () {

            //绑定My97DatePicker日期插件
            $("#beginTime").focus(function () {
                WdatePicker({
                    //dateFmt:'yyyy-MM-dd HH:mm:ss',
                    readOnly:true,
                    //限制日期选择范围
                    maxDate:"#F{$dp.$D('endTime') || '%y-%M-%d'}"
                });
            });

            //绑定My97DatePicker日期插件
            $("#endTime").focus(function () {
                WdatePicker({
                    //dateFmt:'yyyy-MM-dd HH:mm:ss',
                    readOnly:true,
                    //限制日期选择范围
                    minDate:"#F{$dp.$D('beginTime')}",
                    maxDate:"%y-%M-%d"
                });
            });

            $(".chart_btn").click(function () {
                var url = $(this).data("url"); //获取到绑定在按钮上的url地址

                //方法一:调用bootstrap提供的方法，远程加载url的内容，不建议，在后面的 bootstrap 4版本中已被删除
                /*$("#chartModal").removeData("bs.modal"); //清空模态框缓存数据
                $("#chartModal").modal({
                    remote:url + "?" + $("#searchForm").serialize(),
                });*/

                //方法二, 调用jQuery自身提供的load方法, 建议
                $("#modalContent").load(
                    url,
                    $("#searchForm").serialize() //获取指定表单中的所有参数
                );
                $("#chartModal").modal("show");

            });

        });
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="customerChart"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>潜在客户报表</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" style="margin: 10px" id="searchForm" action="/customerChart/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">员工姓名:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" placeholder="请输入员工姓名" value="${(qo.keyword)!}">
                    </div>
                    <div class="form-group">
                        <label for="date">时间段查询:</label>
                        <input type="text" class="form-control" style="width: 136px" id="beginTime" name="beginDate" value="${(qo.beginDate?string('yyyy-MM-dd HH:mm:ss'))!}" placeholder="请选择开始时间"> -
                        <input type="text" class="form-control" style="width: 136px" id="endTime" name="endDate" value="${(qo.endDate?string('yyyy-MM-dd HH:mm:ss'))!}" placeholder="请选择结束时间">
                    </div>
                    <div class="form-group">
                        <label for="groupType">分组类型:</label>
                        <select class="form-control" id="groupType" name="groupType">
                            <option value="e.name" selected>员工</option>
                            <option value="DATE_FORMAT(c.input_time, '%Y')">年</option>
                            <option value="DATE_FORMAT(c.input_time, '%Y-%m')">月</option>
                            <option value="DATE_FORMAT(c.input_time, '%Y-%m-%d')">日</option>
                        </select>
                        <script>
                            $("#groupType").val("${qo.groupType}");
                        </script>
                        <button type="submit" id="btn_query" class="btn btn-primary">
                            <span class="glyphicon glyphicon-search"></span> 查询
                        </button>
                        <button type="button" class="btn btn-info chart_btn" data-url="/customerChart/barChart.do">
                            <span class="glyphicon glyphicon-stats"></span> 柱状图
                        </button>
                        <button type="button" class="btn btn-warning chart_btn" data-url="/customerChart/pieChart.do">
                            <span class="glyphicon glyphicon-dashboard"></span> 饼状图
                        </button>
                    </div>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>分组类型</th>
                            <th>潜在客户新增数</th>
                        </tr>
                        <#list (result.list)! as entity>
                            <tr>
                                <td>${(entity.groupType)!}</td>
                                <td>${(entity.number)!} </td>
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

<!-- 图表模态框 -->
<div class="modal fade" id="chartModal" tabindex="-1" role="dialog" aria-labelledby="changeStatusModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div id="modalContent" class="modal-content">
        </div>
    </div>
</div>

</body>
</html>

