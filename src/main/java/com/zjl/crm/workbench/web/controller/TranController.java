package com.zjl.crm.workbench.web.controller;

import com.zjl.crm.settings.domain.User;
import com.zjl.crm.settings.service.UserService;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.*;
import com.zjl.crm.workbench.service.ActivityService;
import com.zjl.crm.workbench.service.ContactsService;
import com.zjl.crm.workbench.service.CustomerService;
import com.zjl.crm.workbench.service.TranService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/workbench/transaction")
public class TranController {
    @Resource
    private TranService tranService;
    @Resource
    private UserService userService;
    @Resource
    private ActivityService activityService;
    @Resource
    private ContactsService contactsService;
    @Resource
    private CustomerService customerService;
    @RequestMapping("/add.do")
    public ModelAndView add(){
        List<User> uList = userService.getUserList();
        ModelAndView mv = new ModelAndView();
        mv.addObject("uList",uList);
        mv.setViewName("save.jsp");
        return mv;
    }
    @RequestMapping("/pageList.do")
    @ResponseBody
    public PageinationVO<Tran> pageList(Tran tran,Integer pageNo,Integer pageSize){
        Map<String,Object> map = new HashMap<>();
        Integer skipCount = (pageNo-1)*pageSize;
        map.put("tran",tran);
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        PageinationVO<Tran> vo = tranService.pageList(map);
        return vo;
    }
    @RequestMapping("/getActivityListByName.do")
    @ResponseBody
    public List<Activity> getActivityListByName(String activityName){
        return activityService.getActivityListByName(activityName);
    }
    @RequestMapping("/getContactsListByName.do")
    @ResponseBody
    public List<Contacts> getContactsListByName(String contactsName){
        return contactsService.getContactsListByName(contactsName);
    }
    @RequestMapping("/getCustomerName.do")
    @ResponseBody
    public List<String> getCustomerName(String name){
        return customerService.getCustomerName(name);
    }

    @RequestMapping("/save.do")
    public ModelAndView save(Tran tran, String customerName, HttpServletRequest request){
        tran.setId(UUIDUtil.getUUID());
        tran.setCreateTime(DateTimeUtil.getSysTime());
        tran.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        boolean flag = tranService.save(tran,customerName);
        ModelAndView mv = new ModelAndView();
        if(flag){
            mv.setViewName("redirect:index.jsp");
        }
        return mv;
    }
    @RequestMapping("/detail.do")
    public ModelAndView detail(String id, HttpServletRequest request){
        Tran tran = tranService.detail(id);
        String stage = tran.getStage();
        Map<String,String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        String possibility = pMap.get(stage);
        tran.setPossibility(possibility);
        ModelAndView mv = new ModelAndView();
        mv.addObject("tran",tran);
        mv.setViewName("detail.jsp");
        return mv;
    }
    @RequestMapping("/getHistoryListByTranId.do")
    @ResponseBody
    public List<TranHistory> getHistoryListByTranId(String tranId,HttpServletRequest request){
        List<TranHistory> tranHistoryList = tranService.getHistoryListByTranId(tranId);
        Map<String,String> pMap = (Map<String,String>) request.getServletContext().getAttribute("pMap");
        for(TranHistory tranHistory:tranHistoryList){
            String stage = tranHistory.getStage();
            String possibility = pMap.get(stage);
            tranHistory.setPossibility(possibility);
        }
        return tranHistoryList;
    }
    @RequestMapping("/getRemarkListByTranId.do")
    @ResponseBody
    public List<TranRemark> getRemarkListByTranId(String tranId){
        return tranService.getRemarkListByTranId(tranId);
    }
    @RequestMapping("/saveRemark.do")
    @ResponseBody
    public Map<String,Object> saveRemark(TranRemark tranRemark,HttpServletRequest request){
        tranRemark.setId(UUIDUtil.getUUID());
        tranRemark.setEditFlag("0");
        tranRemark.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        tranRemark.setCreateTime(DateTimeUtil.getSysTime());
        boolean flag = tranService.saveRemark(tranRemark);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        map.put("tranRemark",tranRemark);
        return map;
    }
    @RequestMapping("/updateRemark.do")
    @ResponseBody
    public Map<String,Object> updateRemark(TranRemark tranRemark,HttpServletRequest request){
        tranRemark.setEditTime(DateTimeUtil.getSysTime());
        tranRemark.setEditBy(((User)request.getSession().getAttribute("user")).getName());
        tranRemark.setEditFlag("1");
        Map<String,Object> map = new HashMap<>();
        boolean flag = tranService.updateRemark(tranRemark);
        map.put("success",flag);
        map.put("tranRemark",tranRemark);
        return map;
    }
    @RequestMapping("/deleteTranRemarkById.do")
    @ResponseBody
    public Map<String,Object> deleteTranRemarkById(String id){
        boolean flag = tranService.deleteTranRemarkById(id);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/changeStage.do")
    @ResponseBody
    public Map<String,Object> changeStage(Tran tran,HttpServletRequest request){
        tran.setEditTime(DateTimeUtil.getSysTime());
        tran.setEditBy(((User)request.getSession().getAttribute("user")).getName());
        boolean flag = tranService.changeStage(tran);
        Map<String,String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        tran.setPossibility(pMap.get(tran.getStage()));
        Map<String,Object> map = new HashMap<>();
        map.put("tran",tran);
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/delete.do")
    @ResponseBody
    public Map<String,Boolean> delete(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = tranService.delete(ids);
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/deleteFromDetail.do")
    @ResponseBody
    public Map<String,Boolean> deleteFromDetail(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = tranService.delete(ids);
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/edit.do")
    public ModelAndView edit(String id,HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        List<User> uList = userService.getUserList();
        Tran tran = tranService.detail(id);
        Map<String,String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        if(tran.getStage() != null || tran.getStage()!= ""){
            tran.setPossibility(pMap.get(tran.getStage()));
        }
        if(tran.getContactsId() != null || tran.getContactsId() != ""){
            String currentContactsId = contactsService.getIdByName(tran.getContactsId());
            mv.addObject("contactsId",currentContactsId);
        }
        if(tran.getActivityId() != null || tran.getActivityId() != ""){
            String currentActivityId = activityService.getIdByName(tran.getActivityId());
            mv.addObject("activityId",currentActivityId);
        }
        mv.addObject("uList",uList);
        mv.addObject("tran",tran);
        mv.setViewName("edit.jsp");
        return mv;
    }
    @RequestMapping("/update.do")
    @ResponseBody
    public ModelAndView update(Tran tran,String customerName,HttpServletRequest request){
        tran.setEditBy(((User)request.getSession().getAttribute("user")).getName());
        tran.setEditTime(DateTimeUtil.getSysTime());
        boolean flag = tranService.update(tran,customerName);
        ModelAndView mv = new ModelAndView();
        if(flag){
            mv.setViewName("redirect:index.jsp");
        }
        return mv;
    }
    @RequestMapping("/getCharts.do")
    @ResponseBody
    public Map<String ,Object> getCharts(){
        return tranService.getCharts();
    }
}
