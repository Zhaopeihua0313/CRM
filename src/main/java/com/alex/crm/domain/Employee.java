package com.alex.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
public class Employee extends BaseDomain {

    private String name;

    private String password;

    private String email;

    private Integer age;

    private boolean admin;

    private Department dept;

    private List<Role> roles = new ArrayList<>();

    //提供json属性返回json字符串
    public String getJson(){
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        return JSON.toJSONString(map);
    }

}