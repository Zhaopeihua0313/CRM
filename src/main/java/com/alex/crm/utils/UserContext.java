package com.alex.crm.utils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import com.alex.crm.domain.Employee;

public abstract class UserContext {

	/**
	 * 使用shiro的工具SecurityUtils获取当前登录用户
	 * @return
	 */
	public static Employee getCurrentUser() {  //获取员工Session
		Subject subject = SecurityUtils.getSubject();
		//Employee employee = principalCollection.getPrimaryPrincipal(); //另一种获得用户实体的方式
		Employee employee = (Employee) subject.getPrincipal();
		return employee;
	}

}
