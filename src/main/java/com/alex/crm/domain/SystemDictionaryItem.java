package com.alex.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import java.util.HashMap;
import java.util.Map;

/**
 * 字典明细
 */
@Getter
@Setter
public class SystemDictionaryItem extends BaseDomain {

    private Long parentId; //目录id

    private String title; //明细标题

    private Integer sequence; //序号

    //提供json属性返回json字符串
    public String getJson(){
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("title", title);
        map.put("sequence", sequence);
        return JSON.toJSONString(map);
    }

}