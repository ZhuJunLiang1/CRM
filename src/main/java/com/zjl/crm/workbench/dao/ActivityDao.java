package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.Activity;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

public interface ActivityDao {
    int save(Activity activity);

    List<Activity> getActivityListByCondition(Map<String, Object> map);

    int getTotalByCondition(Map<String, Object> map);

    int delete(String[] ids);

    Activity getById(String id);

    int update(Activity activity);

    Activity detail(String id);

    List<Activity> getActivityListByClueId(String clueId);

    List<Activity> getActivityListByNameAndNotByClueId(Map<String, Object> map);

    List<Activity> getActivityListByName(String activityName);

    List<Activity> getActivityListByContactsId(String contactsId);

    List<Activity> getActivityListByNameAndNotByContactsId(Map<String, Object> map);

    String getIdByName(String activityId);

    int getTotal();

    List<Map<String, Object>> getCharts();

    List<String> getActivitySourceList();

    List<Integer> getCountList();
}
