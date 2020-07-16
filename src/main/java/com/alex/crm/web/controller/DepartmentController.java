package com.alex.crm.web.controller;

import com.alex.crm.domain.Department;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.IDepartmentService;
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
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private IDepartmentService departmentService;

    @RequiresPermissions(value = {"部门列表", "department:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") QueryObject qo) {
        model.addAttribute("result", departmentService.query(qo));
        return "department/list"; //进行DQL操作后跳转到列表页
    }

    @RequiresPermissions(value = {"新增部门/更新部门", "department:saveOrUpdate"}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    //@RequiredPermission(name = "部门新增/部门更新", expression = "department:saveOrUpdate") //另一种方式：直接将权限表达式写在注解上
    @ResponseBody
    public JsonResult saveOrUpdate (Department department) {
        JsonResult json = new JsonResult();
        try {
            departmentService.saveOrUpdate(department);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequiresPermissions(value = {"删除部门", "department:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete (Long id) {
        JsonResult json = new JsonResult();
        try {
            departmentService.delete(id);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }

    }

}
