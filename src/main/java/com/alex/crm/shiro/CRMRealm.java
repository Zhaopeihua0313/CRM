package com.alex.crm.shiro;

import com.alex.crm.domain.Employee;
import com.alex.crm.mapper.EmployeeMapper;
import com.alex.crm.mapper.PermissionMapper;
import com.alex.crm.mapper.RoleMapper;
import com.alex.crm.utils.UserContext;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.util.List;

//数据源类
@Component("crmRealm")
public class CRMRealm extends AuthorizingRealm {

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    RoleMapper roleMapper;

    @Autowired
    PermissionMapper permissionMapper;

    //注入属性
    @Autowired
    public void setCredentialsMatcher(CredentialsMatcher credentialsMatcher){
        super.setCredentialsMatcher(credentialsMatcher); //设置密码匹配器
    }

    /**
     * 提供用户认证数据（登录）
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //获取token令牌中的用户名（登陆的是时候填的）
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        String username = token.getUsername();
        //判断该用户名是否存在与数据库中
        Employee employee = employeeMapper.selectEmployeeByUsername(username);
        //判断该用户名是否存在于数据库
        if (employee == null){
            return null; //返回null代表账号不存在
        }
        return new SimpleAuthenticationInfo(employee, employee.getPassword(), ByteSource.Util.bytes(username), "crmRealm"); //realmName用来标志当前查询到的数据是从哪个数据源中查询到的
    }

    /**
     * 提供用户授权数据（权限）
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //创建包含当前登录用户拥有的角色和权限的简单权限信息对象
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        //获取当前登录用户
        Employee employee = UserContext.getCurrentUser();
        if (employee.isAdmin()){
            info.addRole("ADMIN"); //管理员角色
            info.addStringPermission("*:*");
            return info;
        }else {
            //查询用户拥有的权限数据
            List<String> permissions = permissionMapper.selectPermissionsByEmployeeId(employee.getId());
            info.addStringPermissions(permissions);
            //查询用户拥有的角色数据
            List<String> roles = roleMapper.selectSnByEmployeeId(employee.getId());
            info.addRoles(roles);
            return info;
        }
    }

    //清除当前登录用户的缓存
    /*public void clearCached(){
        PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
        super.clearCache(principals);
    }*/

}
