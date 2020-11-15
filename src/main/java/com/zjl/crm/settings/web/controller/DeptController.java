package com.zjl.crm.settings.web.controller;

import com.zjl.crm.settings.domain.Dept;
import com.zjl.crm.settings.service.DeptService;
import com.zjl.crm.vo.PageinationVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/settings/dept")
public class DeptController {
    @Resource
    private DeptService deptService;

    @RequestMapping(value = "/pageList.do",method = RequestMethod.GET)
    @ResponseBody
    public PageinationVO pageList(Integer pageNo, Integer pageSize){
        Map<String,Object> map = new HashMap<>();
        Integer skipCount = (pageNo-1)*pageSize;
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        PageinationVO vo = deptService.pageList(map);
        return vo;
    }
    @RequestMapping(value = "/save.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> save(Dept dept){
        Map<String,Boolean> map = new HashMap<>();
        boolean flag = deptService.save(dept);
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/delete.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> delete(HttpServletRequest request){
        String nos[] = request.getParameterValues("no");
        boolean flag = deptService.delete(nos);
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/getDetailByNo.do",method = RequestMethod.GET)
    @ResponseBody
    public Dept getDetailByNo(String no){
        return deptService.getDetailByNo(no);
    }

    @RequestMapping(value = "/update.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> update(Dept dept){
        Map<String,Boolean> map = new HashMap<>();
        boolean flag = deptService.update(dept);
        map.put("success",flag);
        return map;
    }
}
