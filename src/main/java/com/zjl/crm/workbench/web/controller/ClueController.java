package com.zjl.crm.workbench.web.controller;

import com.zjl.crm.settings.domain.User;
import com.zjl.crm.settings.service.UserService;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.*;
import com.zjl.crm.workbench.service.ActivityService;
import com.zjl.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@Controller
@RequestMapping("/workbench/clue")
public class ClueController {

    @Resource
    private ClueService clueService;
    @Resource
    private UserService userService;
    @Resource
    private ActivityService activityService;

    @RequestMapping(value = "/getUserList.do",method = RequestMethod.GET)
    @ResponseBody
    public List<User> getUserList(){
        List<User> userList = userService.getUserList();
        return userList;
    }
    @RequestMapping(value = "/save.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> save(Clue clue, HttpServletRequest request){
        clue.setId(UUIDUtil.getUUID());
        clue.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        clue.setCreateTime(DateTimeUtil.getSysTime());
        boolean flag = clueService.save(clue);
        Map<String,Object> map = new HashMap<>();
        map.put("clue",clue);
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/pageList.do",method = RequestMethod.GET)
    @ResponseBody
    public PageinationVO pageList(Clue clue,Integer pageNo,Integer pageSize){
        Map<String,Object> map = new HashMap<>();
        Integer skipCount = (pageNo-1)*pageSize;
        map.put("clue",clue);
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        PageinationVO<Clue> vo = clueService.pageList(map);
        return vo;
    }
    @RequestMapping(value = "/delete.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> delete(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = clueService.delete(ids);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/getUserListAndClue.do",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> getUserListAndClue(String id){
        /*
            controller 调用service方法，返回值应该是什么， 就从Service要什么
         */
        Map<String,Object> map = clueService.getUserListAndClue(id);
        return map;
    }
    @RequestMapping(value = "/update.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> update(Clue clue, HttpServletRequest request){
        //系统当前时间
        String editTime = DateTimeUtil.getSysTime();
        //修改人 当前登录用户
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        clue.setEditTime(editTime);
        clue.setEditBy(editBy);
        boolean flag = clueService.update(clue);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/detail.do",method = RequestMethod.GET)
    public ModelAndView detail(String id){
        ModelAndView mv = new ModelAndView();
        Clue clue = clueService.detail(id);
        mv.addObject("clue",clue);
        mv.setViewName("/workbench/clue/detail.jsp");
        return mv;
    }
    @RequestMapping(value = "/getRemarkListById.do",method = RequestMethod.GET)
    @ResponseBody
    public List<ClueRemark> getRemarkListById(String clueId){
        List<ClueRemark> remarkList = clueService.getRemarkListById(clueId);
        return remarkList;
    }
    @RequestMapping(value = "/deleteRemark.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> deleteRemark(String id){
        boolean flag = clueService.deleteRemark(id);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/saveRemark.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveRemark(ClueRemark clueRemark, HttpServletRequest request){
        clueRemark.setId(UUIDUtil.getUUID());
        clueRemark.setCreateTime(DateTimeUtil.getSysTime());
        clueRemark.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        clueRemark.setEditFlag("0");
        boolean flag = clueService.saveRemark(clueRemark);
        Map<String,Object> map = new HashMap<>();
        map.put("clueRemark",clueRemark);
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/updateRemark.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> updateRemark(ClueRemark clueRemark,HttpServletRequest request){
        clueRemark.setEditTime(DateTimeUtil.getSysTime());
        clueRemark.setEditBy(((User)request.getSession().getAttribute("user")).getName());
        clueRemark.setEditFlag("1");
        Map<String,Object> map = new HashMap<>();
        boolean flag = clueService.updateRemark(clueRemark);
        map.put("success",flag);
        map.put("clueRemark",clueRemark);
        return map;
    }
    @RequestMapping(value = "/getActivityListByClueId",method = RequestMethod.GET)
    @ResponseBody
    public List<Activity> getActivityListByClueId(String clueId){

        List<Activity> activityList = activityService.getActivityListByClueId(clueId);
        return activityList;
    }
    @RequestMapping(value = "/unbund",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> unbund(String id){
        boolean flag = clueService.unbund(id);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/getActivityListByNameAndNotByClueId.do",method = RequestMethod.GET)
    @ResponseBody
    public List<Activity> getActivityListByNameAndNotByClueId(String activityName,String clueId){
        Map<String,Object> map = new HashMap<>();
        map.put("activityName",activityName);
        map.put("clueId",clueId);
        List<Activity> activityList = activityService.getActivityListByNameAndNotByClueId(map);
        return activityList;
    }
    @RequestMapping(value = "/bund.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> bund(String clueId,HttpServletRequest request){
        String[] aids = request.getParameterValues("activityId");
        boolean flag = clueService.bund(clueId,aids);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/getActivityListByName.do",method = RequestMethod.GET)
    @ResponseBody
    public List<Activity> getActivityListByName(String activityName){
        List<Activity> activityList = activityService.getActivityListByName(activityName);
        return activityList;
    }
    @RequestMapping(value = "/convert.do",method = RequestMethod.POST)
    public ModelAndView convert(String clueId,String flag,Tran tran,HttpServletRequest request){
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        if("a".equals(flag)){
            tran.setId(UUIDUtil.getUUID());
            tran.setCreateTime(DateTimeUtil.getSysTime());
            tran.setCreateBy(createBy);
        }
        //为业务层传递参数 clueId  tran
        //tran可能为空
        boolean flag1 = clueService.convert(clueId,tran,createBy);
        ModelAndView mv = new ModelAndView();
        if (flag1){
            mv.setViewName("redirect:/workbench/clue/index.jsp");
        }
        return mv;
    }
    @RequestMapping(value = "/getCharts.do",method = RequestMethod.GET)
    @ResponseBody
    public Map<String ,Object> getCharts(){
        return clueService.getCharts();
    }
}
