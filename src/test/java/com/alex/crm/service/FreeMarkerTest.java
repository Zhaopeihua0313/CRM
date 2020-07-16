package com.alex.crm.service;

import freemarker.template.Configuration;
import freemarker.template.Template;
import org.junit.Test;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.HashMap;

public class FreeMarkerTest {

    @Test
    public void testFreemarker(){
        //要显示的数据
        HashMap<String, Object> map = new HashMap<>();
        map.put("name", "张三");

        //Freemarker配置类
        Configuration configuration = new Configuration(Configuration.VERSION_2_3_23);
        try {
            configuration.setDirectoryForTemplateLoading(new File("template")); //指定模版所在的目录
            Template template = configuration.getTemplate("hello.ftl", "UTF-8"); //指定要使用的模版文件及其编码方式
            //合成结果
            FileOutputStream outputStream = new FileOutputStream("hello.html");
            template.process(map, new OutputStreamWriter(outputStream));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
