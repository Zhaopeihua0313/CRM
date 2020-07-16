package com.alex.crm.service;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;
import org.junit.Test;

import java.util.Arrays;

public class ShiroTest {

    @Test
    public void testShiro(){
        //安全管理器工厂，默认支持ini配置文件
        IniSecurityManagerFactory factory = new IniSecurityManagerFactory("classpath:shiro.ini");
        //安全管理器实例对象
        SecurityManager securityManager = factory.getInstance();
        //把安全管理器注入到当前的环境中
        SecurityUtils.setSecurityManager(securityManager);
        //shiro登录认证功能
        //获取主体对象（用户）
        Subject subject = SecurityUtils.getSubject();
        //认证状态(false)
        System.out.println("认证状态=" + subject.isAuthenticated());
        //登录时要用的令牌
        UsernamePasswordToken token = new UsernamePasswordToken("lisi", "666");
        //执行登录
        subject.login(token);
        //查看认证状态(true)
        System.out.println("认证状态=" + subject.isAuthenticated());

        //判断用户是拥有该角色
        System.out.println(subject.hasRole("role1"));
        System.out.println(subject.hasRole("role2"));
        System.out.println(subject.hasAllRoles(Arrays.asList("role1", "role2")));

        //System.out.println("------------------------");
        //subject.checkRole("role1");

        //判断角色是拥有该权限
        System.out.println("------------------------");
        System.out.println(subject.isPermitted("user:update"));
        System.out.println(subject.isPermitted("user:delete"));

        System.out.println("------------------------");
        subject.checkPermission("user:delete");

        //执行登出
        subject.logout();
        //查看认证状态(false)
        System.out.println("认证状态=" + subject.isAuthenticated());
    }

}
