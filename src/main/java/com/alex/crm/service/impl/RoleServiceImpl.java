package com.alex.crm.service.impl;

import com.alex.crm.domain.Role;
import com.alex.crm.mapper.RoleMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.IRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RoleServiceImpl implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public void saveOrUpdate(Role role, Long[] ids) {
        if(role.getId() == null){
            roleMapper.insert(role);
        }else {
            roleMapper.updateByPrimaryKey(role);
            roleMapper.deleteRoleAndPermissionRelationByRoleId(role.getId());
        }
        if (ids != null && ids.length > 0){
            for (Long pid : ids){
                roleMapper.insertRelation(role.getId(), pid);
            }
        }
    }

    @Override
    public void delete(Long id) {
        roleMapper.deleteByPrimaryKey(id);
        roleMapper.deleteEmployeeAndRoleRelationByRoleId(id);
        roleMapper.deleteRoleAndPermissionRelationByRoleId(id);
    }

    @Override
    public Role get(Long id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<Role> list = roleMapper.selectList(qo);
        return new PageInfo(list);
    }

    @Override
    public List<Role> list() {
        return roleMapper.selectAll();
    }

}
