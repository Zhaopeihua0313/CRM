package com.alex.crm.shiro;

import com.alex.crm.utils.JsonResult;
import com.alibaba.fastjson.JSON;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.stereotype.Component;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component("crmFormAuthenticationFilter")
public class CRMFormAuthenticationFilter extends FormAuthenticationFilter {

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();
        // 将系统当前登陆用户信息放入session
        session.setAttribute("EMP_IN_SESSION", subject.getSession());
        JsonResult json = new JsonResult();
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JSON.toJSONString(json));
        return false; //过滤器中不放行
    }

    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        JsonResult json = new JsonResult();
        response.setContentType("application/json;charset=utf-8");
        e.printStackTrace();
        if (e instanceof UnknownAccountException){
            json.mark("用户名不存在");
        }else if (e instanceof IncorrectCredentialsException){
            json.mark("密码错误");
        }
        try {
            response.getWriter().write(JSON.toJSONString(json));
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return false; //过滤器中不放行
    }
}
