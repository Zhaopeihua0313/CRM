<aside class="main-sidebar">
    <section class="sidebar">
        <ul class="sidebar-menu" data-widget="tree">
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-dashboard"></i> <span>系统管理</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <@shiro.hasPermission name="department:list">
                        <li name="department"><a href="/department/list.do"><i class="fa fa-circle-o"></i> 部门管理</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="employee:list">
                        <li name="employee"><a href="/employee/list.do"><i class="fa fa-circle-o"></i> 员工管理</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="permission:list">
                        <li name="permission"><a href="/permission/list.do"><i class="fa fa-circle-o"></i> 权限管理</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="role:list">
                        <li name="role"><a href="/role/list.do"><i class="fa fa-circle-o"></i> 角色管理</a></li>
                    </@shiro.hasPermission>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-files-o"></i>
                    <span>数据管理</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <@shiro.hasPermission name="systemDictionary:list">
                        <li name="systemDictionary"><a href="/systemDictionary/list.do"><i class="fa fa-circle-o"></i> 字典目录</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="systemDictionaryItem:list">
                        <li name="systemDictionaryItem"><a href="/systemDictionaryItem/list.do"><i class="fa fa-circle-o"></i> 字典明细</a></li>
                    </@shiro.hasPermission>
                </ul>
            </li>

            <li class="treeview">
                <a href="#">
                    <i class="fa fa-pie-chart"></i>
                    <span>客户管理</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <@shiro.hasPermission name="customer:customerList">
                        <li name="customer"><a href="/customer/customerList.do"><i class="fa fa-circle-o"></i> 客户列表</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="customer:potentialCustomerList">
                        <li name="potentialCustomer"><a href="/customer/potentialCustomerList.do"><i class="fa fa-circle-o"></i> 潜在客户</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="customerTraceHistory:poolCustomerList">
                        <li name="poolCustomer"><a href="/customer/poolCustomerList.do"><i class="fa fa-circle-o"></i> 客户池</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="customerTraceHistory:failCustomerList">
                        <li name="failCustomer"><a href="/customer/failCustomerList.do"><i class="fa fa-circle-o"></i> 失败客户</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="customerTraceHistory:formalCustomerList">
                        <li name="formalCustomer"><a href="/customer/formalCustomerList.do"><i class="fa fa-circle-o"></i> 正式客户</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="customerTraceHistory:lostCustomerList">
                        <li name="lostCustomer"><a href="/customer/lostCustomerList.do"><i class="fa fa-circle-o"></i> 流失客户</a></li>
                    </@shiro.hasPermission>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-edit"></i>
                    <span>客户历史</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <@shiro.hasPermission name="customerTraceHistory:list">
                        <li name="customerTraceHistory"><a href="/customerTraceHistory/list.do"><i class="fa fa-circle-o"></i> 跟进历史</a></li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="customerTransfer:list">
                        <li name="customerTransfer"><a href="/customerTransfer/list.do"><i class="fa fa-circle-o"></i> 移交历史</a></li>
                    </@shiro.hasPermission>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-laptop"></i>
                    <span>报表统计</span>
                    <span class="pull-right-container">
                      <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <@shiro.hasPermission name="customerChart:list">
                        <li name="customerChart"><a href="/customerChart/list.do"><i class="fa fa-circle-o"></i>潜在客户报表</a></li>
                    </@shiro.hasPermission>
                </ul>
            </li>

        </ul>
    </section>
</aside>

<script>
    $(function () {
        //菜单初始
        $('.sidebar-menu').tree();
        //菜单激活
        var cuLi = $(".treeview-menu li[name='${currentMenu!}']");
        cuLi.addClass("active");
        cuLi.closest(".treeview").addClass("active");
    })
</script>