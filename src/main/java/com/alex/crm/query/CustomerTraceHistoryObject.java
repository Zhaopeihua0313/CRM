package com.alex.crm.query;

import lombok.Getter;
import lombok.Setter;
import org.springframework.util.StringUtils;

@Getter
@Setter
public class CustomerTraceHistoryObject extends QueryObject {

    //跟进类型
    private Integer type = -1;

    //关键字查询
    private String keyword;

    public String getKeyword() {
        return StringUtils.hasLength(keyword) ? keyword : null;
    }

}
