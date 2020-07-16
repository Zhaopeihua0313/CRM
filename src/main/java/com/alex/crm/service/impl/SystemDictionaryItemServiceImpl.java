package com.alex.crm.service.impl;

import com.alex.crm.domain.SystemDictionaryItem;
import com.alex.crm.mapper.SystemDictionaryItemMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.ISystemDictionaryItemService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SystemDictionaryItemServiceImpl implements ISystemDictionaryItemService {

    @Autowired
    private SystemDictionaryItemMapper systemDictionaryItemMapper;

    @Override
    public void saveOrUpdate(SystemDictionaryItem systemDictionaryItem) {
        if (systemDictionaryItem.getSequence() == null){
            int maxSequence = systemDictionaryItemMapper.selectMaxSequence(systemDictionaryItem.getParentId());
            systemDictionaryItem.setSequence(maxSequence + 1);
        }
        if(systemDictionaryItem.getId() == null){
            systemDictionaryItemMapper.insert(systemDictionaryItem);
        }else {
            systemDictionaryItemMapper.updateByPrimaryKey(systemDictionaryItem);
        }
    }

    @Override
    public void delete(Long id) {
        systemDictionaryItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public SystemDictionaryItem get(Long id) {
        return systemDictionaryItemMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<SystemDictionaryItem> list = systemDictionaryItemMapper.selectList(qo);
        return new PageInfo(list);
    }

    @Override
    public List<SystemDictionaryItem> querySystemDictionaryItemBySystemDictionarySn(String sn) {
        return systemDictionaryItemMapper.selectSystemDictionaryItemBySystemDictionarySn(sn);
    }

}
