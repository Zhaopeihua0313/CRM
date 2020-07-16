package com.alex.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class Permission extends BaseDomain {

    private String name;

    private String expression;

    //提供json属性返回json字符串
    public String getJson(){
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        return JSON.toJSONString(map);
    }

}