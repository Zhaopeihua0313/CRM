package com.alex.crm.service;

import com.alex.crm.domain.Employee;
import com.alex.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.List;

public interface IEmployeeService {

    void saveOrUpdate(Employee employee, Long[] rids);

    void delete(Long id);

    Employee get(Long id);

    PageInfo query(QueryObject qo);

    /*void login(String username, String password); //员工登录*/

    List<Employee> list();

    Employee getByName(String name);

    void batchDelete(Long[] eids);

    Workbook exportXls();

    Workbook importXls(MultipartFile file) throws IOException;

    List<Employee> queryEmployeeByRoleSn(String... sns);

}
