package com.zjl.crm.settings.service;

import com.zjl.crm.exception.AccountErrorException;
import com.zjl.crm.exception.LoginException;
import com.zjl.crm.settings.domain.Dept;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.vo.PageinationVO;

import java.util.List;
import java.util.Map;

public interface UserService {

    User login(String loginAct, String loginPwd, String ip) throws LoginException;

    List<User> getUserList();

    User getUserById(String userId);

    boolean changePwd(String secNewPwd,String userId);

    PageinationVO pageList(Map<String, Object> map);

    boolean delete(String[] ids);

    List<Dept> getDept();

    Map<String, Boolean> save(User user);

    Map<String, Boolean> update(User user);

    Map<String, Object> register(User user);

    User getUserByLoginAct(String loginAct);
}
