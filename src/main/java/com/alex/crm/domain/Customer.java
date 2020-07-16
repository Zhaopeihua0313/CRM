package com.alex.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class Customer extends BaseDomain {

    public static final int STATUS_POTENTIAL = 0; //潜在客户
    public static final int STATUS_FORMAL = 1; //正式客户
    public static final int STATUS_POOL = 2; //客户池客户
    public static final int STATUS_FAIL = 3; //开发失败客户
    public static final int STATUS_LOST = 4; //流失客户

    //姓名
    private String name;

    //年龄
    private Integer age;

    //性别
    private Integer gender = 0;

    //电话
    private String tel;

    //QQ
    private String qq;

    //职业
    private SystemDictionaryItem job;

    //来源
    private SystemDictionaryItem source;

    //销售员
    private Employee seller;

    //录入人
    private Employee inputUser;

    //录入时间
    private Date inputTime;

    //状态
    private Integer status = STATUS_POTENTIAL;

    //提供json属性返回json字符串
    public String getJson(){
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        map.put("age", age);
        map.put("gender", gender);
        map.put("tel", tel);
        map.put("qq", qq);
        map.put("gender", gender);
        if (job != null){
            map.put("jobId", job.getId());
        }
        if (source != null){
            map.put("sourceId", source.getId());
        }
        if (seller != null){
            map.put("oldSellerId", seller.getId());
            map.put("oldSellerName", seller.getName());
        }
        map.put("status", status);
        return JSON.toJSONString(map);
    }

    public String getStatusName(){
        String temp = "潜在客户";
        switch (status){
            case STATUS_POOL:
                temp = "客户池客户";
                break;
            case STATUS_FORMAL:
                temp = "正式客户";
                break;
            case STATUS_FAIL:
                temp = "开发失败客户";
                break;
            case STATUS_LOST:
                temp = "流失客户";
                break;
        }
        return temp;
    }

}