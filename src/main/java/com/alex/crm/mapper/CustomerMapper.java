package com.alex.crm.mapper;

import com.alex.crm.domain.Customer;
import com.alex.crm.query.QueryObject;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface CustomerMapper {

    int insert(Customer customer);

    int updateByPrimaryKey(Customer customer);

    List<Customer> selectList(QueryObject qo);

    void updateSeller(@Param("sellerId") Long sellerId, @Param("customerId") Long customerId);

    void updateStatusByPrimaryKey(@Param("status") Integer status, @Param("id") Long id);

}