package com.alex.crm.mapper;

import com.alex.crm.domain.Employee;
import com.alex.crm.query.QueryObject;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface EmployeeMapper {

    int deleteByPrimaryKey(Long id);

    int insert(Employee employee);

    Employee selectByPrimaryKey(Long id);

    int updateByPrimaryKey(Employee employee);

    List<Employee> selectAll(); //查询所有员工

    List<Employee> selectList(QueryObject qo); //查询分页列表

    //Employee selectByInfo(@Param("username") String username, @Param("password") String password);

    void insertRelation(@Param("eid") Long eid, @Param("rid") Long rid); //插入中间表的关联关系

    void deleteEmployeeAndRoleRelationByEmployeeId(Long eid); //删除中间表的关联关系

    Employee selectEmployeeByUsername(String name);

    void batchDeleteEmployee(Long[] eids);

    void deleteEmployeeAndRoleRelationsByEmployeeIds(Long[] eids);

    List<Employee> selectEmployeeByRoleSn(String... sns);

}
