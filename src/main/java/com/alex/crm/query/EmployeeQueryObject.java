package com.alex.crm.query;

import lombok.Getter;
import lombok.Setter;
import org.springframework.util.StringUtils;

@Getter
@Setter
public class EmployeeQueryObject extends QueryObject {

    private Long deptId = -1L; //部门id
    private String keyword; //关键字查询

    public String getKeyword() {
        return StringUtils.hasLength(keyword) ? keyword : null;
    }

}
