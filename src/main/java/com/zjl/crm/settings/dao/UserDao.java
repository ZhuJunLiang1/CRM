package com.zjl.crm.settings.dao;

import com.zjl.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {

    User login(Map<String, String> map);

    List<User> getUserList();

    User getUserById(String userId);

    int changePwd(Map<String,String> map);
}
