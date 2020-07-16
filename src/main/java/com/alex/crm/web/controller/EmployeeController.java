package com.alex.crm.web.controller;

import com.alex.crm.domain.Employee;
import com.alex.crm.query.EmployeeQueryObject;
import com.alex.crm.service.IDepartmentService;
import com.alex.crm.service.IEmployeeService;
import com.alex.crm.service.IRoleService;
import com.alex.crm.utils.JsonResult;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private IEmployeeService employeeService;

    @Autowired
    private IDepartmentService departmentService;

    @Autowired
    private IRoleService roleService;

    @RequiresPermissions(value = {"员工列表", "employee:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") EmployeeQueryObject qo) {
        model.addAttribute("result", employeeService.query(qo)); //将员工列表信息共享到待跳转的页面
        model.addAttribute("depts", departmentService.list()); //将部门信息共享到待跳转的页面
        return "employee/list"; //进行DQL操作后跳转到列表页
    }

    @RequiresPermissions(value = {"编辑员工", "employee:input"}, logical = Logical.OR)
    @RequestMapping("/input")
    public String input (Model model, Long id) {
        if (id != null){
            model.addAttribute("employee", employeeService.get(id)); //将员工信息共享到待跳转的页面
        }
        model.addAttribute("depts", departmentService.list()); //将部门信息共享到待跳转的页面
        model.addAttribute("roles", roleService.list()); //将角色信息共享到待跳转的页面
        return "employee/input"; //跳转到编辑信息页面
    }

    @RequiresPermissions(value = {"新增员工/更新员工", "employee:saveOrUpdate"}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate (Employee employee, @RequestParam("ids") Long[] rids) {
        JsonResult json = new JsonResult();
        try {
            employeeService.saveOrUpdate(employee, rids);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequiresPermissions(value = {"删除员工", "employee:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete (Long id) {
        JsonResult json = new JsonResult();
        try {
            employeeService.delete(id);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequiresPermissions(value = {"批量删除员工", "employee:batchDelete"}, logical = Logical.OR)
    @RequestMapping("/batchDelete")
    @ResponseBody
    public JsonResult batchDelete (@RequestParam("ids") Long[] eids) {
        JsonResult json = new JsonResult();
        try {
            employeeService.batchDelete(eids);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequiresPermissions(value = {"员工导出", "employee:exportXls"}, logical = Logical.OR)
    @RequestMapping("/exportXls")
    public void exportXls (HttpServletResponse response) {
        response.setHeader("Content-Disposition","attachment;filename=employee.xls");
        try {
            Workbook wb = employeeService.exportXls();
            wb.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequiresPermissions(value = {"员工导入", "employee:importXls"}, logical = Logical.OR)
    @RequestMapping("/importXls")
    @ResponseBody
    public JsonResult importXls (MultipartFile file) {
        JsonResult json = new JsonResult();
        try {
            employeeService.importXls(file);
            return json;
        } catch (IOException e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequestMapping("/checkName")
    @ResponseBody
    //员工编辑页面的用户名实时校验方法
    public boolean checkName (String name) {
        Employee employee = employeeService.getByName(name);
        return employee==null; //如果员工对象为空则返回false
    }

}
