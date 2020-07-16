package com.alex.crm.service.impl;

import com.alex.crm.domain.CustomerTransfer;
import com.alex.crm.mapper.CustomerMapper;
import com.alex.crm.mapper.CustomerTransferMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.ICustomerTransferService;
import com.alex.crm.utils.UserContext;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CustomerTransferServiceImpl implements ICustomerTransferService {

    @Autowired
    private CustomerTransferMapper customerTransferMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public void save(CustomerTransfer customerTransfer) {
        customerTransfer.setOperator(UserContext.getCurrentUser()); //设置操作人为当前用户
        customerTransferMapper.insert(customerTransfer); //持久层插入新的移交历史
        customerMapper.updateSeller(customerTransfer.getNewSeller().getId(), customerTransfer.getCustomer().getId()); //持久层更新新的销售人员
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<CustomerTransfer> list = customerTransferMapper.selectList(qo);
        return new PageInfo(list);
    }

}
