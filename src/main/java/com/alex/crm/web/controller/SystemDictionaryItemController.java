package com.alex.crm.web.controller;

import com.alex.crm.domain.SystemDictionaryItem;
import com.alex.crm.query.SystemDictionaryItemQueryObject;
import com.alex.crm.service.ISystemDictionaryItemService;
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
@RequestMapping("/systemDictionaryItem")
public class SystemDictionaryItemController {

    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;

    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequiresPermissions(value = {"数据字典明细列表", "systemDictionaryItem:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") SystemDictionaryItemQueryObject qo) {
        model.addAttribute("result", systemDictionaryItemService.query(qo));
        model.addAttribute("dics", systemDictionaryService.list());
        return "system_dictionary/item";
    }

    @RequiresPermissions(value = {"新增数据字典明细/更新数据字典明细", "systemDictionaryItem:saveOrUpdate"}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate (SystemDictionaryItem systemDictionaryItem) {
        JsonResult json = new JsonResult();
        try {
            systemDictionaryItemService.saveOrUpdate(systemDictionaryItem);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }
    }

    @RequiresPermissions(value = {"删除数据字典明细", "systemDictionaryItem:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete (Long id) {
        JsonResult json = new JsonResult();
        try {
            systemDictionaryItemService.delete(id);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.mark("操作失败！");
            return json;
        }

    }

}
