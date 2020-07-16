package com.alex.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import java.util.HashMap;
import java.util.Map;

/**
 * 字典目录
 */
@Getter
@Setter
public class SystemDictionary extends BaseDomain {

    private String sn; //编号

    private String title; //标题

    private String intro; //简介

    //提供json属性返回json字符串
    public String getJson(){
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("title", title);
        map.put("sn", sn);
        map.put("intro", intro);
        return JSON.toJSONString(map);
    }

}