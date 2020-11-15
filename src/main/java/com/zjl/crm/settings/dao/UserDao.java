package com.zjl.crm.settings.dao;

import com.zjl.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {

    User login(Map<String, String> map);

    List<User> getUserList();

    User getUserById(String userId);

    int changePwd(Map<String,String> map);

    int getTotalByCondition(Map<String, Object> map);

    List<User> getUserListByCondition(Map<String, Object> map);

    int delete(String[] ids);

    int save(User user);

    int update(User user);

    User getUserByLoginAct(String loginAct);
}
