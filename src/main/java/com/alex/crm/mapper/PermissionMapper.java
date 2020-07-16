package com.alex.crm.mapper;

import com.alex.crm.domain.Permission;
import com.alex.crm.query.QueryObject;
import java.util.List;

public interface PermissionMapper {

    int insert(Permission permission);

    int deleteByPrimaryKey(Long id);

    List<Permission> selectAll();

    List<Permission> selectList(QueryObject qo);

    List<String> selectAllExpression();

    int deleteRoleAndPermissionRelationByPermissionId(Long id); //删除中间表的关联关系

    List<String> selectPermissionsByEmployeeId(Long id); //根据员工id查询其所有权限

}