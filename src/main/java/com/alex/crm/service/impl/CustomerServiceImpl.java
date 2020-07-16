package com.alex.crm.service.impl;

import com.alex.crm.domain.Customer;
import com.alex.crm.domain.Employee;
import com.alex.crm.mapper.CustomerMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.ICustomerService;
import com.alex.crm.utils.UserContext;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CustomerServiceImpl implements ICustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public void saveOrUpdate(Customer customer) {
        if(customer.getId() != null){
            customerMapper.updateByPrimaryKey(customer);
        }else {
            //设置录入人，销售员为当前登录用户
            Employee employee = UserContext.getCurrentUser();
            customer.setSeller(employee);
            customer.setInputUser(employee);
            customerMapper.insert(customer);
        }
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<Customer> list = customerMapper.selectList(qo);
        return new PageInfo(list);
    }

    @Override
    public void updateStatus(Integer status, Long id) {
        customerMapper.updateStatusByPrimaryKey(status, id);
    }

}
