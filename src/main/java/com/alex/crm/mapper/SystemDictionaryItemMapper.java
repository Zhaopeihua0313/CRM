package com.alex.crm.mapper;

import com.alex.crm.domain.SystemDictionaryItem;
import com.alex.crm.query.QueryObject;
import java.util.List;

public interface SystemDictionaryItemMapper {

    int deleteByPrimaryKey(Long id);

    int insert(SystemDictionaryItem systemDictionaryItem);

    SystemDictionaryItem selectByPrimaryKey(Long id);

    List<SystemDictionaryItem> selectAll();

    int updateByPrimaryKey(SystemDictionaryItem record);

    List<SystemDictionaryItem> selectList(QueryObject qo);

    int selectMaxSequence(Long parentId);

    List<SystemDictionaryItem> selectSystemDictionaryItemBySystemDictionarySn(String sn);

}