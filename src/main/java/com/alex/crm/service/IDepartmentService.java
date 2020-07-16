package com.alex.crm.service;

import com.alex.crm.domain.Department;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;
import java.util.List;

public interface IDepartmentService {

    void saveOrUpdate(Department department);

    void delete(Long id);

    Department get(Long id);

    PageInfo query(QueryObject qo);

    List<Department> list();

}
