package com.alex.crm.web.controller;

import com.alex.crm.mapper.CustomerChartMapper;
import com.alex.crm.query.CustomerChartQueryObject;
import com.alex.crm.service.ICustomerChartService;
import com.alibaba.fastjson.JSON;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customerChart")
public class CustomerChartController {

    @Autowired
    private ICustomerChartService customerChartService;

    @RequiresPermissions(value = {"潜在客户报表", "customerChart:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list (Model model, @ModelAttribute("qo") CustomerChartQueryObject qo) {
        model.addAttribute("result", customerChartService.queryChart(qo));
        return "customer_chart/list";
    }

    @Autowired
    private CustomerChartMapper customerChartMapper;

    @RequiresPermissions(value = {"潜在客户柱状图", "customerChart:barChart"}, logical = Logical.OR)
    @RequestMapping("/barChart")
    public String barChart (Model model, @ModelAttribute("qo") CustomerChartQueryObject qo) {
        List<Map<String, Object>> maps = customerChartMapper.selectChart(qo);
        ArrayList<Object> xList = new ArrayList<>();
        ArrayList<Object> yList = new ArrayList<>();
        for (Map<String, Object> map : maps){
            xList.add(map.get("groupType"));
            yList.add(map.get("number"));
        }
        model.addAttribute("xList", JSON.toJSONString(xList));
        model.addAttribute("yList", JSON.toJSONString(yList));
        model.addAttribute("groupTypeName", qo.getGroupTypeName());
        return "customer_chart/bar_chart";
    }

    @RequiresPermissions(value = {"潜在客户饼图", "customerChart:pieChart"}, logical = Logical.OR)
    @RequestMapping("/pieChart")
    public String pieChart (Model model, @ModelAttribute("qo") CustomerChartQueryObject qo) {
        List<Map<String, Object>> maps = customerChartMapper.selectChart(qo);
        ArrayList<Object> labels = new ArrayList<>();
        ArrayList<Object> data = new ArrayList<>();
        for (Map<String, Object> map : maps){
            labels.add(map.get("groupType"));
            HashMap<String, Object> tempMap = new HashMap<>();
            tempMap.put("name", map.get("groupType"));
            tempMap.put("value", map.get("number"));
            data.add(tempMap);
        }
        model.addAttribute("labels", JSON.toJSONString(labels));
        model.addAttribute("data", JSON.toJSONString(data));
        model.addAttribute("groupTypeName", qo.getGroupTypeName());
        return "customer_chart/pie_chart";
    }

}
