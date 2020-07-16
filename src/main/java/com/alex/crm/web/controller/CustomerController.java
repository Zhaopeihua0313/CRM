package com.alex.crm.web.controller;

import com.alex.crm.domain.Customer;
import com.alex.crm.query.CustomerQueryObject;
import com.alex.crm.service.ICustomerService;
import com.alex.crm.service.IEmployeeService;
import com.alex.crm.service.ISystemDictionaryItemService;
import com.alex.crm.utils.JsonResult;
import com.alex.crm.utils.UserContext;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IEmployeeService employeeService;

    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;

    //客户列表
    @RequiresPermissions(value = {"客户列表", "customer:customerList"}, logical = Logical.OR)
    @RequestMapping("/customerList")
    public String customerList (Model model, @ModelAttribute("qo") CustomerQueryObject qo) {
        if (qo.getStatus() == null){
            //如果客户状态为空，则显示所有客户
            qo.setStatus(-1);
        }
        model.addAttribute("result", customerService.query(qo));
        //只查市场专员MY以及市场经理MM角色的员工
        model.addAttribute("emps", employeeService.queryEmployeeByRoleSn("MM", "MY"));
        return "customer/customerList";
    }

    //潜在客户
    @RequiresPermissions(value = {"潜在客户列表", "customer:potentialCustomerList"}, logical = Logical.OR)
    @RequestMapping("/potentialCustomerList")
    public String potentialCustomerList (Model model, @ModelAttribute("qo") CustomerQueryObject qo) {
        //只查询状态为潜在客户的数据
        qo.setStatus(Customer.STATUS_POTENTIAL);
        //判断是否是管理员和经理
        Subject subject = SecurityUtils.getSubject();
        if (!(subject.hasRole("ADMIN") || subject.hasRole("MM"))){
            //如果不是管理员或者客户经理，则只能查询当前登录用户的数据
            qo.setSellerId(UserContext.getCurrentUser().getId());
        }
        model.addAttribute("result", customerService.query(qo));
        //只查市场专员MY以及市场经理MM角色的员工
        model.addAttribute("emps", employeeService.queryEmployeeByRoleSn("MM", "MY"));
        //查询职业下拉框数据
        model.addAttribute("jobs", systemDictionaryItemService.querySystemDictionaryItemBySystemDictionarySn("job"));
        //查询来源下拉框数据
        model.addAttribute("sources", systemDictionaryItemService.querySystemDictionaryItemBySystemDictionarySn("source"));
        //查询跟进类型下拉框数据
        model.addAttribute("traceTypes", systemDictionaryItemService.querySystemDictionaryItemBySystemDictionarySn("traceType"));
        return "customer/potentialCustomerList"; //进行DQL操作后跳转到列表页
    }

    @RequiresPermissions(value = {"新增潜在客户/更新潜在客户", "customer:saveOrUpdate"}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate (Customer customer) {
        JsonResult json = new JsonResult();
        try {
            customerService.saveOrUpdate(customer);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequiresPermissions(value = {"更新潜在客户状态", "customer:updateStatus"}, logical = Logical.OR)
    @RequestMapping("/updateStatus")
    @ResponseBody
    public JsonResult updateStatus (Integer status, Long id) {
        JsonResult json = new JsonResult();
        try {
            customerService.updateStatus(status, id);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    //客户池
    @RequiresPermissions(value = {"客户池列表", "customer:poolCustomerList"}, logical = Logical.OR)
    @RequestMapping("/poolCustomerList")
    public String poolCustomerList (Model model, @ModelAttribute("qo") CustomerQueryObject qo) {
        qo.setStatus(Customer.STATUS_POOL);
        model.addAttribute("result", customerService.query(qo));
        //只查市场专员MY以及市场经理MM角色的员工
        model.addAttribute("emps", employeeService.queryEmployeeByRoleSn("MM", "MY"));
        return "customer/poolCustomerList";
    }

    //失败客户
    @RequiresPermissions(value = {"失败客户列表", "customer:failCustomerList"}, logical = Logical.OR)
    @RequestMapping("/failCustomerList")
    public String failCustomerList (Model model, @ModelAttribute("qo") CustomerQueryObject qo) {
        qo.setStatus(Customer.STATUS_FAIL);
        model.addAttribute("result", customerService.query(qo));
        //只查市场专员MY以及市场经理MM角色的员工
        model.addAttribute("emps", employeeService.queryEmployeeByRoleSn("MM", "MY"));
        return "customer/failCustomerList";
    }

    //正式客户
    @RequiresPermissions(value = {"正式客户列表", "customer:formalCustomerList"}, logical = Logical.OR)
    @RequestMapping("/formalCustomerList")
    public String formalCustomerList (Model model, @ModelAttribute("qo") CustomerQueryObject qo) {
        qo.setStatus(Customer.STATUS_FORMAL);
        model.addAttribute("result", customerService.query(qo));
        //只查市场专员MY以及市场经理MM角色的员工
        model.addAttribute("emps", employeeService.queryEmployeeByRoleSn("MM", "MY"));
        return "customer/formalCustomerList";
    }

    //流失客户
    @RequiresPermissions(value = {"流失客户列表", "customer:lostCustomerList"}, logical = Logical.OR)
    @RequestMapping("/lostCustomerList")
    public String lostCustomerList (Model model, @ModelAttribute("qo") CustomerQueryObject qo) {
        qo.setStatus(Customer.STATUS_LOST);
        model.addAttribute("result", customerService.query(qo));
        //只查市场专员MY以及市场经理MM角色的员工
        model.addAttribute("emps", employeeService.queryEmployeeByRoleSn("MM", "MY"));
        return "customer/lostCustomerList";
    }

}
