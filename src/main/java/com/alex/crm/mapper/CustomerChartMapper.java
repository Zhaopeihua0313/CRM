package com.alex.crm.mapper;

import com.alex.crm.query.QueryObject;
import java.util.List;
import java.util.Map;

public interface CustomerChartMapper {

    List<Map<String, Object>> selectChart(QueryObject qo);

}