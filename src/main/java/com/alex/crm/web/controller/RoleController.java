package com.alex.crm.web.controller;

import com.alex.crm.domain.Role;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.IPermissionService;
import com.alex.crm.service.IRoleService;
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
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IPermissionService permissionService;

    @RequiresPermissions(value = {"角色列表", "role:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") QueryObject qo) {
        model.addAttribute("result", roleService.query(qo)); //将员工列表信息共享到待跳转的页面
        return "role/list"; //进行DQL操作后跳转到列表页
    }

    @RequiresPermissions(value = {"编辑角色", "role:input"}, logical = Logical.OR)
    @RequestMapping("/input")
    public String input (Model model, Long id) {
        model.addAttribute("permissions", permissionService.list());
        if (id != null){
            model.addAttribute("role", roleService.get(id)); //将员工信息共享到待跳转的页面
        }
        return "role/input"; //跳转到编辑信息页面
    }

    @RequiresPermissions(value = {"新增角色/更新角色", "role:saveOrUpdate"}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate (Role role, Long ids[]) {
        JsonResult json = new JsonResult();
        try {
            roleService.saveOrUpdate(role, ids);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequiresPermissions(value = {"删除角色", "role:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete (Long id) {
        JsonResult json = new JsonResult();
        try {
            roleService.delete(id);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

}
