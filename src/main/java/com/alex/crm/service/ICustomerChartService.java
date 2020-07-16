package com.alex.crm.service;

import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

public interface ICustomerChartService {

    PageInfo queryChart(QueryObject qo);

}
