package com.alex.crm.web.controller;

import com.alex.crm.query.QueryObject;
import com.alex.crm.service.IPermissionService;
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
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private IPermissionService permissionService;

    @RequiresPermissions(value = {"权限列表", "permission:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") QueryObject qo) {
        model.addAttribute("result", permissionService.query(qo)); //将员工列表信息共享到待跳转的页面
        return "permission/list"; //进行DQL操作后跳转到列表页
    }

    @RequiresPermissions(value = {"删除权限", "permission:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete (Long id) {
        JsonResult json = new JsonResult();
        try {
            permissionService.delete(id);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequestMapping("/reload")
    @ResponseBody
    public JsonResult reload () {
        JsonResult json = new JsonResult();
        try {
            permissionService.load();
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("重新加载权限失败！");
            return json;
        }
    }

}
