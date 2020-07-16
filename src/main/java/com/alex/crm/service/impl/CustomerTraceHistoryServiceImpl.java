package com.alex.crm.service.impl;

import com.alex.crm.domain.CustomerTraceHistory;
import com.alex.crm.mapper.CustomerTraceHistoryMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.ICustomerTraceHistoryService;
import com.alex.crm.utils.UserContext;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CustomerTraceHistoryServiceImpl implements ICustomerTraceHistoryService {

    @Autowired
    private CustomerTraceHistoryMapper customerTraceHistoryMapper;

    @Override
    public void saveOrUpdate(CustomerTraceHistory customerTraceHistory) {
        if(customerTraceHistory.getId() == null){
            customerTraceHistory.setInputUser(UserContext.getCurrentUser());
            customerTraceHistoryMapper.insert(customerTraceHistory);
        }else {
            customerTraceHistoryMapper.updateByPrimaryKey(customerTraceHistory);
        }
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<CustomerTraceHistory> list = customerTraceHistoryMapper.selectList(qo);
        return new PageInfo(list);
    }

}
