package com.alex.crm.service;

import com.alex.crm.domain.SystemDictionaryItem;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;
import java.util.List;

public interface ISystemDictionaryItemService {

    void saveOrUpdate(SystemDictionaryItem systemDictionaryItem);

    void delete(Long id);

    SystemDictionaryItem get(Long id);

    PageInfo query(QueryObject qo);

    List<SystemDictionaryItem> querySystemDictionaryItemBySystemDictionarySn(String sn);

}
