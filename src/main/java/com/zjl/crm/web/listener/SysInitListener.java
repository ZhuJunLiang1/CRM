package com.zjl.crm.web.listener;

import com.zjl.crm.settings.domain.DicValue;
import com.zjl.crm.settings.service.DicService;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

public class SysInitListener implements ServletContextListener {
    /*
        监听上下文域对象的方法，只要对象创建完毕后，马上执行该方法。
        servletContextEvent 能够取得监听的对象，
                例如监听的是上下文域对象，通过该参数可以获得上下文域对象
     */
//    @Resource
//    DicService dicService;
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext application = servletContextEvent.getServletContext();
        WebApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(application);
        DicService dicService = (DicService) applicationContext.getBean("dicServiceImpl");
//        DicService dicService = new DicServiceImpl();
        //取数据字典
        /*
            向业务层要7个List
            7个List打包为一个map
             map.put("application",dvList1);
             map.put("clueState",dvList2);
             map.put("clueState",dvList2);
             ----------
         */
        Map<String, List< DicValue >> map = dicService.getAll();
        //将map中 解析为上下文域对象保存的键值对
        Set<String> set = map.keySet();
        for (String key : set){
            application.setAttribute(key,map.get(key));
        }
        //---------------------------------处理Stage2Possibility.properties文件
        //解析该文件，将该属性文件中的键值对关系处理成为java中的键值对关系（map）
        Map<String,String> pMap = new HashMap<>();
        ResourceBundle rb = ResourceBundle.getBundle("config/Stage2Possibility");
        Enumeration<String> e = rb.getKeys();
        while (e.hasMoreElements()){
            String key = e.nextElement();
            String value = rb.getString(key);
            pMap.put(key,value);
        }
        application.setAttribute("pMap",pMap);
        //将pMap放入 application中

    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
