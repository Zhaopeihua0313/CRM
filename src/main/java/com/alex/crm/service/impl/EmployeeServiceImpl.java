package com.alex.crm.service.impl;

import com.alex.crm.domain.Employee;
import com.alex.crm.mapper.EmployeeMapper;
import com.alex.crm.query.QueryObject;
import com.alex.crm.service.IEmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.List;

@Service
public class EmployeeServiceImpl implements IEmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    /*@Autowired
    private EhCacheManager ehCacheManager;*/

    @Override
    public void saveOrUpdate(Employee employee, Long[] rids) {
        if(employee.getId() == null){
            //MD5加密用户密码
            Md5Hash md5Hash = new Md5Hash(employee.getPassword(), employee.getName(), 1);
            employee.setPassword(md5Hash.toString());
            employeeMapper.insert(employee);
        }else {
            employeeMapper.deleteEmployeeAndRoleRelationByEmployeeId(employee.getId()); //处理中间表，删除关系
            employeeMapper.updateByPrimaryKey(employee);
            //ehCacheManager.getCacheManager().clearAll(); //更新员工信息后，清空所有人的缓存
        }
        if (rids != null && rids.length > 0){
            for(Long rid : rids) { //处理中间表，关联关系
                employeeMapper.insertRelation(employee.getId(), rid);
            }
        }
    }

    @Override
    public void delete(Long id) {
        employeeMapper.deleteByPrimaryKey(id);
        employeeMapper.deleteEmployeeAndRoleRelationByEmployeeId(id); //处理中间表，删除关系
    }

    @Override
    public Employee get(Long id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<Employee> list = employeeMapper.selectList(qo);
        return new PageInfo(list);
    }

    @Override
    public List<Employee> list() {
        return employeeMapper.selectAll();
    }

    @Override
    public Employee getByName(String name) {
        Employee employee = employeeMapper.selectEmployeeByUsername(name);
        return employee;
    }

    @Override
    public void batchDelete(Long[] eids) {
        employeeMapper.batchDeleteEmployee(eids);
        employeeMapper.deleteEmployeeAndRoleRelationsByEmployeeIds(eids);
    }

    @Override
    public Workbook exportXls() {
        //查询员工数据
        List<Employee> employees = employeeMapper.selectAll();
        //创建一个工作薄
        Workbook wb = new HSSFWorkbook();
        //创建一页纸并输入该页纸的名字
        Sheet sheet = wb.createSheet("员工信息表");
        //创建列标题
        Row row = sheet.createRow(0);
        row.createCell(0).setCellValue("姓名");
        row.createCell(1).setCellValue("邮箱");
        row.createCell(2).setCellValue("年龄");
        for (int i = 0; i < employees.size(); i++){
            row = sheet.createRow(i+1); //创建数据行
            Employee employee = employees.get(i);
            if (employee.getName() != null){
                row.createCell(0).setCellValue(employee.getName());
            }
            if (employee.getEmail() != null){
                row.createCell(1).setCellValue(employee.getEmail());
            }
            if (employee.getAge() != null){
                row.createCell(2).setCellValue(employee.getAge());
            }
        }
        return wb;
    }

    @Override
    public Workbook importXls(MultipartFile file) throws IOException {
        Workbook wb = null;
            //读取工作薄
            wb = new HSSFWorkbook(file.getInputStream());
            //读一页纸
            Sheet sheet = wb.getSheetAt(0);
            //获取总行数
            int lastRowNum = sheet.getLastRowNum();
            for (int i = 1; i <= lastRowNum; i++){ //行数从0开始，第一行不用读取
                Row row = sheet.getRow(i);
                Employee employee = new Employee();
                employee.setName(row.getCell(0).getStringCellValue());
                employee.setEmail(row.getCell(1).getStringCellValue());
                Cell cell = row.getCell(2);
                Integer age = null;
                //判断非String单元格可能的数据类型，根绝结果来选择对应的处理方法
                switch (cell.getCellTypeEnum()){
                    case STRING:
                        age = Integer.valueOf(cell.getStringCellValue());
                        break;
                    case NUMERIC:
                        age = (int) cell.getNumericCellValue();
                        break;
                }
                employee.setAge(age);
                //设置默认密码，否则会报NPL
                employee.setPassword("123");
                this.saveOrUpdate(employee, null);
            }
        return wb;
    }

    @Override
    public List<Employee> queryEmployeeByRoleSn(String... sns) {
        List<Employee> employees = employeeMapper.selectEmployeeByRoleSn(sns);
        return employees;
    }

}
