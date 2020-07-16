package com.alex.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class CustomerTraceHistory extends BaseDomain {

    public static final int TYPE_COMMON = 0; //潜在客户跟进
    public static final int TYPE_NORMAL = 1; //正式客户开发

    //跟进时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date traceTime;

    //跟进内容
    private String traceDetails;

    //跟进方式
    private SystemDictionaryItem traceType;

    //跟进结果
    private Integer traceResult;

    //备注
    private String remark;

    //跟进客户
    private Customer customer;

    //录入人
    private Employee inputUser;

    //录入时间
    @DateTimeFormat(pattern = "yy-MM-dd HH:mm:ss")
    private Date inputTime;

    //跟进类型
    private Integer type;

    //提供json属性返回json字符串
    public String getJson(){
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("traceTime", traceTime);
        map.put("traceDetails", traceDetails);
        if (traceType != null){
            map.put("traceTypeId", traceType.getId());
        }else {
            map.put("traceTypeId", -1);
        }
        map.put("traceResult", traceResult);
        map.put("remark", remark);
        if (customer != null){
            map.put("customerId", customer.getId());
            map.put("customerName", customer.getName());
        }
        if (inputUser != null){
            map.put("inputUserId", inputUser.getId());
            map.put("inputUserName", inputUser.getName());
        }
        map.put("inputTime", inputTime);
        map.put("type", type);
        return JSON.toJSONString(map);
    }

}