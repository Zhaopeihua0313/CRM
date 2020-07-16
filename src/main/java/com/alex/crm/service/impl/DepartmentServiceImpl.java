package com.alex.crm.service.impl;

import com.alex.crm.domain.Department;
import com.alex.crm.mapper.DepartmentMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.IDepartmentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DepartmentServiceImpl implements IDepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public void saveOrUpdate(Department department) {
        if(department.getId() != null){
            departmentMapper.updateByPrimaryKey(department);
        }else {
            departmentMapper.insert(department);
        }
    }

    @Override
    public void delete(Long id) {
        departmentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Department get(Long id) {
        return departmentMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<Department> list = departmentMapper.selectList(qo);
        return new PageInfo(list);
    }

    @Override
    public List<Department> list() {
        return departmentMapper.selectAll();
    }

}
