package com.alex.crm.mapper;

import com.alex.crm.domain.Department;
import com.alex.crm.query.QueryObject;
import java.util.List;

public interface DepartmentMapper {

    int deleteByPrimaryKey(Long id);

    int insert(Department department);

    Department selectByPrimaryKey(Long id);

    List<Department> selectAll(); //查询所有调用的持久层方法

    int updateByPrimaryKey(Department department);

    List<Department> selectList(QueryObject qo); //查询分页列表调用的持久层方法

}