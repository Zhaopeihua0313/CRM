package com.alex.crm.service;

import com.alex.crm.domain.Role;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;
import java.util.List;

public interface IRoleService {

    void saveOrUpdate(Role role, Long[] ids);

    void delete(Long id);

    Role get(Long id);

    PageInfo query(QueryObject qo);

    List<Role> list();

}
