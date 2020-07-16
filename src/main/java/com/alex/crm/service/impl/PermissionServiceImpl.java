package com.alex.crm.service.impl;

import com.alex.crm.domain.Permission;
import com.alex.crm.mapper.PermissionMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.IPermissionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@Service
public class PermissionServiceImpl implements IPermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    @Autowired
    private ApplicationContext ctx;

    @Override
    public void delete(Long id) {
        permissionMapper.deleteByPrimaryKey(id);
        permissionMapper.deleteRoleAndPermissionRelationByPermissionId(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<Permission> list = permissionMapper.selectList(qo);
        return new PageInfo(list);
    }

    @Override
    public List<Permission> list() {
        return permissionMapper.selectAll();
    }

    @Override
    //把所有的Controller中贴了权限注解的方法，转换成权限对象，并保存到数据库中
    public void load() {
        List<String> expressions = permissionMapper.selectAllExpression(); //查询所有的权限表达式
        Map<String, Object> map = ctx.getBeansWithAnnotation(Controller.class); //通过ApplicationContext对象获取带有Controller注解的所有Bean
        Collection<Object> values = map.values(); //获取所有的Controller控制器
        //遍历每个Controller，获取字节码对象，再获取该字节码中所有的方法
        for (Object controller : values) {
            Class<?> clazz = controller.getClass().getSuperclass(); //获取代理类的父类的字节码对象(即原Controller的字节码对象)
            Method[] methods = clazz.getDeclaredMethods(); //每个Controller中的所有方法，包括私有方法
            for (Method method : methods) { //遍历每个方法
                RequiresPermissions annotation = method.getAnnotation(RequiresPermissions.class); //获取每个方法中指定的注解
                if (annotation != null){ //判断方法上是否贴有权限注解
                    String name = annotation.value()[0]; //获取权限的名字
                    String expression = annotation.value()[1]; //获取权限的表达式
                    if (!expressions.contains(expression)){ //如果数据库中不存在当前表达式，才进行后续操作
                        //封装成权限对象
                        Permission permission = new Permission();
                        permission.setName(name);
                        permission.setExpression(expression);
                        permissionMapper.insert(permission); //插入权限到数据库
                    }
                }
            }
        }
    }

}
