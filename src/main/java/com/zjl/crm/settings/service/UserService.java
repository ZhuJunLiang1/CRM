package com.zjl.crm.settings.service;

import com.zjl.crm.exception.AccountErrorException;
import com.zjl.crm.exception.LoginException;
import com.zjl.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    User login(String loginAct, String loginPwd, String ip) throws LoginException;

    List<User> getUserList();

    User getUserById(String userId);

    boolean changePwd(String secNewPwd,String userId);
}
