package com.alex.crm.mapper;

import com.alex.crm.domain.CustomerTransfer;
import com.alex.crm.query.QueryObject;
import java.util.List;

public interface CustomerTransferMapper {

    int insert(CustomerTransfer customerTransfer);

    List<CustomerTransfer> selectList(QueryObject qo);

}