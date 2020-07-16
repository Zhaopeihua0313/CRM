package com.alex.crm.web.controller;

import com.alex.crm.domain.CustomerTraceHistory;
import com.alex.crm.query.CustomerTraceHistoryObject;
import com.alex.crm.service.ICustomerTraceHistoryService;
import com.alex.crm.service.IEmployeeService;
import com.alex.crm.service.ISystemDictionaryItemService;
import com.alex.crm.utils.JsonResult;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/customerTraceHistory")
public class CustomerTraceHistoryController {

    @Autowired
    private ICustomerTraceHistoryService customerTraceHistoryService;

    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;

    @Autowired
    private IEmployeeService employeeService;

    @RequiresPermissions(value = {"跟进历史列表", "customerTraceHistory:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") CustomerTraceHistoryObject qo) {
        model.addAttribute("result", customerTraceHistoryService.query(qo));
        model.addAttribute("traceTypes", systemDictionaryItemService.querySystemDictionaryItemBySystemDictionarySn("traceType"));
        model.addAttribute("inputUsers", employeeService.queryEmployeeByRoleSn("MM", "MY"));
        return "customer_trace_history/list"; //进行DQL操作后跳转到列表页
    }

    @RequiresPermissions(value = {"新增跟进历史/更新跟进历史", "customerTraceHistory:saveOrUpdate"}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate (CustomerTraceHistory customerTraceHistory) {
        JsonResult json = new JsonResult();
        try {
            customerTraceHistoryService.saveOrUpdate(customerTraceHistory);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

}
