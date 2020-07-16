package com.alex.crm.service.impl;

import com.alex.crm.mapper.CustomerChartMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.ICustomerChartService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class CustomerChartServiceImpl implements ICustomerChartService {

    @Autowired
    CustomerChartMapper customerChartMapper;

    @Override
    public PageInfo queryChart(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<Map<String, Object>> list = customerChartMapper.selectChart(qo);
        return new PageInfo(list);
    }

}
