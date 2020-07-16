package com.alex.crm.service;

import com.alex.crm.domain.Permission;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface IPermissionService {

    void delete(Long id);

    PageInfo query(QueryObject qo);

    List<Permission> list();

    void load(); //重新加载权限

}
