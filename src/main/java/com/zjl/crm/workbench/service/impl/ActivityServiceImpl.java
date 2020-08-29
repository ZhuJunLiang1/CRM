package com.zjl.crm.workbench.service.impl;

import com.zjl.crm.settings.dao.UserDao;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.dao.ActivityDao;
import com.zjl.crm.workbench.dao.ActivityRemarkDao;
import com.zjl.crm.workbench.domain.Activity;
import com.zjl.crm.workbench.domain.ActivityRemark;
import com.zjl.crm.workbench.service.ActivityService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActivityServiceImpl implements ActivityService {
    @Resource
    private ActivityDao activityDao;
    @Resource
    private ActivityRemarkDao activityRemarkDao;
    @Resource
    private UserDao userDao;

    @Override
    public boolean save(Activity activity) {
        boolean flag = true;
        int count = activityDao.save(activity);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public PageinationVO<Activity> pageList(Map<String, Object> map) {
        //取得total
        int total = activityDao.getTotalByCondition(map);
        //取得dataList 封装到vo 返回
        List<Activity> dataList = activityDao.getActivityListByCondition(map);
        PageinationVO<Activity> vo = new PageinationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }
    @Transactional
    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        //关联的备注
        //级联删除备注  查询出需要删除备注的数量
        int count1 = activityRemarkDao.getCountByAids(ids);
        //删除备注影响行数
        int count2 = activityRemarkDao.deleteByAids(ids);
        if(count1 != count2){
            flag = false;
        }
        //删除市场活动
        int count3 = activityDao.delete(ids);
        if(count3 != ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndActivity(String id) {
        //取uList
        List<User> uList = userDao.getUserList();
        //取activity
        Activity activity = activityDao.getById(id);
        //封装进map 中
        Map<String,Object> map = new HashMap<>();
        map.put("uList",uList);
        map.put("activity",activity);
        return map;
    }

    @Override
    public boolean update(Activity activity) {
        boolean flag = true;
        int count = activityDao.update(activity);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Activity detail(String id) {
        Activity activity = activityDao.detail(id);
        return activity;
    }

    @Override
    public List<ActivityRemark> getRemarkListById(String activityId) {
        List<ActivityRemark> remarkList = activityRemarkDao.getRemarkListById(activityId);
        return remarkList;
    }

    @Override
    public boolean deleteRemark(String id) {
        boolean flag = true;
        int count = activityRemarkDao.deleteById(id);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean saveRemark(ActivityRemark activityRemark) {
        boolean flag = true;
        int count = activityRemarkDao.saveRemark(activityRemark);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public boolean updateRemark(ActivityRemark activityRemark) {
        boolean flag = true;
        int count = activityRemarkDao.updateRemark(activityRemark);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public List<Activity> getActivityListByClueId(String clueId) {
        List<Activity> activityList = activityDao.getActivityListByClueId(clueId);
        return activityList;
    }

    @Override
    public List<Activity> getActivityListByNameAndNotByClueId(Map<String, Object> map) {
        List<Activity> activityList = activityDao.getActivityListByNameAndNotByClueId(map);
        return activityList;
    }

    @Override
    public List<Activity> getActivityListByName(String activityName) {
        List<Activity> activityList = activityDao.getActivityListByName(activityName);
        return activityList;
    }

    @Override
    public String getIdByName(String activityId) {
        return activityDao.getIdByName(activityId);
    }
    @Override
    public Map<String, Object> getCharts() {
        int total = activityDao.getTotal();
        List<Map<String,Object>> dataList = activityDao.getCharts();
        Map<String, Object> map = new HashMap<>();
        List<String> activityList = activityDao.getActivitySourceList();
        List<Integer> countList = activityDao.getCountList();
        map.put("total",total);
        map.put("dataList",dataList);
        map.put("activityList",activityList);
        map.put("countList",countList);
        return map;
    }
}
