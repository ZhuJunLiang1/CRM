package com.zjl.crm.settings.test;

import com.zjl.crm.utils.MD5Util;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class Test1 {
    @Test
   public void test01(){
        String config = "config/applicationContext.xml";
        ApplicationContext ac = new ClassPathXmlApplicationContext(config);

        String pwd = "bjiowad";
        String pwd1 = MD5Util.getMD5(pwd);
        System.out.println(pwd1);
   }
}
