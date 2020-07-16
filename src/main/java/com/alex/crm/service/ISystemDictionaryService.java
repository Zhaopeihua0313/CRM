package com.alex.crm.service;

import com.alex.crm.domain.SystemDictionary;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;
import java.util.List;

public interface ISystemDictionaryService {

    void saveOrUpdate(SystemDictionary systemDictionary);

    void delete(Long id);

    SystemDictionary get(Long id);

    PageInfo query(QueryObject qo);

    List<SystemDictionary> list();

}
