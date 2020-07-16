package com.alex.crm.mapper;

import com.alex.crm.domain.CustomerTraceHistory;
import com.alex.crm.query.QueryObject;
import java.util.List;

public interface CustomerTraceHistoryMapper {

    int insert(CustomerTraceHistory customerTraceHistory);

    int updateByPrimaryKey(CustomerTraceHistory customerTraceHistory);

    List<CustomerTraceHistory> selectList(QueryObject qo);

}