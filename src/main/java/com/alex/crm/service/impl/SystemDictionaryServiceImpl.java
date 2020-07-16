package com.alex.crm.service.impl;

import com.alex.crm.domain.SystemDictionary;
import com.alex.crm.mapper.SystemDictionaryMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.ISystemDictionaryService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SystemDictionaryServiceImpl implements ISystemDictionaryService {

    @Autowired
    private SystemDictionaryMapper systemDictionaryMapper;

    @Override
    public void saveOrUpdate(SystemDictionary systemDictionary) {
        if(systemDictionary.getId() == null){
            systemDictionaryMapper.insert(systemDictionary);
        }else {
            systemDictionaryMapper.updateByPrimaryKey(systemDictionary);
        }
    }

    @Override
    public void delete(Long id) {
        systemDictionaryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public SystemDictionary get(Long id) {
        return systemDictionaryMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<SystemDictionary> list = systemDictionaryMapper.selectList(qo);
        return new PageInfo(list);
    }

    @Override
    public List<SystemDictionary> list() {
        return systemDictionaryMapper.selectAll();
    }

}
