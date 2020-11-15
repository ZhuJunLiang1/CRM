package com.zjl.crm.workbench.web.controller;

import com.zjl.crm.settings.domain.User;
import com.zjl.crm.settings.service.UserService;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.Activity;
import com.zjl.crm.workbench.domain.ActivityRemark;
import com.zjl.crm.workbench.service.ActivityService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/workbench/activity")
public class ActivityController {
    @Resource
    private ActivityService activityService;
    @Resource
    private UserService userService;

    @RequestMapping(value = "/getUserList.do",method = RequestMethod.GET)
    @ResponseBody
    public List<User> getUserList(){
        List<User> userList = userService.getUserList();
        return userList;
    }
    @RequestMapping(value = "/save.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> save(Activity activity,HttpServletRequest request){
        String id = UUIDUtil.getUUID();
        //系统当前时间
        String createTime = DateTimeUtil.getSysTime();
        //创建人 当前登录用户
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        activity.setId(id);
        activity.setCreateTime(createTime);
        activity.setCreateBy(createBy);
        boolean flag = activityService.save(activity);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/pageList.do",method = RequestMethod.GET)
    @ResponseBody
    public PageinationVO pageList(Activity activity,Integer pageNo,Integer pageSize){
        Map<String,Object> map = new HashMap<>();
        Integer skipCount = (pageNo-1)*pageSize;
        map.put("activity",activity);
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        PageinationVO<Activity> vo = activityService.pageList(map);
        return vo;
    }
    @RequestMapping(value = "/delete.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> delete(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = activityService.delete(ids);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/getUserListAndActivity.do",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> getUserListAndActivity(String id){
        /*
            controller 调用service方法，返回值应该是什么， 就从Service要什么
         */
        Map<String,Object> map = activityService.getUserListAndActivity(id);
        return map;
    }
    @RequestMapping(value = "/update.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> update(Activity activity, HttpServletRequest request){
        //系统当前时间
        String editTime = DateTimeUtil.getSysTime();
        //修改人 当前登录用户
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        activity.setEditTime(editTime);
        activity.setEditBy(editBy);
        boolean flag = activityService.update(activity);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @RequestMapping(value = "/detail.do",method = RequestMethod.GET)
    public ModelAndView detail(String id){
        ModelAndView mv = new ModelAndView();
        Activity activity = activityService.detail(id);
        mv.addObject("activity",activity);
        mv.setViewName("/workbench/activity/detail.jsp");
        return mv;
    }

    //详情页编辑按钮的更新操作
    @RequestMapping(value = "/detail1.do",method = RequestMethod.GET)
    @ResponseBody
    public Activity detail1(String id){
        return activityService.detail(id);
    }

    @RequestMapping(value = "/getRemarkListById.do",method = RequestMethod.GET)
    @ResponseBody
    public List<ActivityRemark> getRemarkListById(String activityId){
        List<ActivityRemark> remarkList = activityService.getRemarkListById(activityId);
        return remarkList;
    }
    @RequestMapping(value = "/deleteRemark.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> deleteRemark(String id){
        boolean flag = activityService.deleteRemark(id);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/saveRemark.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveRemark(ActivityRemark activityRemark,HttpServletRequest request){
        activityRemark.setId(UUIDUtil.getUUID());
        activityRemark.setCreateTime(DateTimeUtil.getSysTime());
        activityRemark.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        activityRemark.setEditFlag("0");
        boolean flag = activityService.saveRemark(activityRemark);
        Map<String,Object> map = new HashMap<>();
        map.put("activityRemark",activityRemark);
        map.put("success",flag);
        return map;
    }
    @RequestMapping(value = "/updateRemark.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> updateRemark(ActivityRemark activityRemark,HttpServletRequest request){
        activityRemark.setEditTime(DateTimeUtil.getSysTime());
        activityRemark.setEditBy(((User)request.getSession().getAttribute("user")).getName());
        activityRemark.setEditFlag("1");
        Map<String,Object> map = new HashMap<>();
        boolean flag = activityService.updateRemark(activityRemark);
        map.put("success",flag);
        map.put("activityRemark",activityRemark);
        return map;
    }
    @RequestMapping(value = "/getCharts.do",method = RequestMethod.GET)
    @ResponseBody
    public Map<String ,Object> getCharts(){
        return activityService.getCharts();
    }


}
