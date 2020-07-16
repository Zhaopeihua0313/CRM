package com.alex.crm.service;

import com.alex.crm.domain.CustomerTraceHistory;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

public interface ICustomerTraceHistoryService {

    void saveOrUpdate(CustomerTraceHistory customerTraceHistory);

    PageInfo query(QueryObject qo);

}
