package com.alex.crm.mapper;

import com.alex.crm.domain.SystemDictionary;
import com.alex.crm.query.QueryObject;
import java.util.List;

public interface SystemDictionaryMapper {

    int deleteByPrimaryKey(Long id);

    int insert(SystemDictionary systemDictionary);

    SystemDictionary selectByPrimaryKey(Long id);

    List<SystemDictionary> selectAll();

    int updateByPrimaryKey(SystemDictionary systemDictionary);

    List<SystemDictionary> selectList(QueryObject qo);

}