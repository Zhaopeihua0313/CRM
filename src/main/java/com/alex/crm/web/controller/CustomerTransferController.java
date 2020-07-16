package com.alex.crm.web.controller;

import com.alex.crm.domain.CustomerTransfer;
import com.alex.crm.query.CustomerTransferObject;
import com.alex.crm.service.ICustomerTransferService;
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
@RequestMapping("/customerTransfer")
public class CustomerTransferController {

    @Autowired
    private ICustomerTransferService customerTransferService;

    @RequiresPermissions(value = {"移交历史列表", "customerTransfer:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") CustomerTransferObject qo) {
        model.addAttribute("result", customerTransferService.query(qo));
        return "customer_transfer/list";
    }

    @RequiresPermissions(value = {"新增移交历史", "customerTransfer:save"}, logical = Logical.OR)
    @RequestMapping("/save")
    @ResponseBody
    public JsonResult save (CustomerTransfer customerTransfer) {
        JsonResult json = new JsonResult();
        try {
            customerTransferService.save(customerTransfer);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

}

