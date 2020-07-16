package com.alex.crm.service;

import com.alex.crm.domain.Customer;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

public interface ICustomerService {

    void saveOrUpdate(Customer customer);

    PageInfo query(QueryObject qo);

    void updateStatus(Integer status, Long id);

}
