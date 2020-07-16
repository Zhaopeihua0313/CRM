package com.alex.crm.service;

import com.alex.crm.domain.CustomerTransfer;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

public interface ICustomerTransferService {

    void save(CustomerTransfer customerTransfer);

    PageInfo query(QueryObject qo);

}
