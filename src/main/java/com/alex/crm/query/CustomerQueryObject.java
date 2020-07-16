package com.alex.crm.query;

import lombok.Getter;
import lombok.Setter;
import org.springframework.util.StringUtils;

@Getter
@Setter
public class CustomerQueryObject extends QueryObject {

    //客户状态
    private Integer status;

    //销售员的员工id
    private Long sellerId = -1L;

    //关键字查询
    private String keyword;

    public String getKeyword() {
        return StringUtils.hasLength(keyword) ? keyword : null;
    }

}
