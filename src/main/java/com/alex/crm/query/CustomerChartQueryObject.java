package com.alex.crm.query;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.util.StringUtils;
import java.util.Date;

@Getter
@Setter
public class CustomerChartQueryObject extends QueryObject {

    //分组类型
    private String groupType = "e.name";

    //开始时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date beginDate;

    //结束时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    //关键字查询
    private String keyword;

    public String getKeyword() {
        return StringUtils.hasLength(keyword) ? keyword : null;
    }

    public String getGroupTypeName(){
        String temp = "员工";
        //常量写在前面是为了防止变量为null而抛出NPL异常
        if ("DATE_FORMAT(c.input_time, '%Y')".equals(groupType)){
            temp = "年";
        }else if ("DATE_FORMAT(c.input_time, '%Y-%m')".equals(groupType)){
            temp = "月";
        }else if ("DATE_FORMAT(c.input_time, '%Y-%m-%d')".equals(groupType)){
            temp = "日";
        }
        return temp;
    }

}
