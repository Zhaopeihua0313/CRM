package com.alex.crm.web.controller;

import com.alex.crm.domain.SystemDictionary;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.ISystemDictionaryService;
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
@RequestMapping("/systemDictionary")
public class SystemDictionaryController {

    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequiresPermissions(value = {"数据字典目录列表", "systemDictionary:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") QueryObject qo) {
        model.addAttribute("result", systemDictionaryService.query(qo));
        return "system_dictionary/list";
    }

    @RequiresPermissions(value = {"新增数据字典目录/更新数据字典目录", "systemDictionary:saveOrUpdate"}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate (SystemDictionary systemDictionary) {
        JsonResult json = new JsonResult();
        try {
            systemDictionaryService.saveOrUpdate(systemDictionary);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequiresPermissions(value = {"删除数据字典目录", "systemDictionary:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete (Long id) {
        JsonResult json = new JsonResult();
        try {
            systemDictionaryService.delete(id);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }

    }

}
