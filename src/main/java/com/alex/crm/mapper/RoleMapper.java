package com.alex.crm.mapper;

import com.alex.crm.domain.Role;
import com.alex.crm.query.QueryObject;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface RoleMapper {

    int deleteByPrimaryKey(Long id);

    int insert(Role role);

    Role selectByPrimaryKey(Long id);

    List<Role> selectAll();

    int updateByPrimaryKey(Role role);

    List<Role> selectList(QueryObject qo);

    void insertRelation(@Param("rid") Long rid, @Param("pid") Long pid);

    void deleteEmployeeAndRoleRelationByRoleId(Long rid); //删除中间表的关联关系

    void deleteRoleAndPermissionRelationByRoleId(Long rid); //删除中间表的关联关系

    List<String> selectSnByEmployeeId(Long id);
}