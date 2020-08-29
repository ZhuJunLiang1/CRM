package com.zjl.crm.settings.service.impl;

import com.zjl.crm.exception.AccountErrorException;
import com.zjl.crm.exception.LoginException;
import com.zjl.crm.settings.dao.UserDao;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.settings.service.UserService;
import com.zjl.crm.utils.DateTimeUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    @Override
    public User login(String loginAct, String loginPwd, String ip) throws LoginException {
        Map<String,String> map = new HashMap<String,String>();
        map.put("loginAct",loginAct);
        map.put("loginPwd",loginPwd);
        User user = userDao.login(map);

        if(user == null){
            throw new AccountErrorException("账号密码错误");
        }
        //验证失效时间
        String expireTime = user.getExpireTime();
        String currentTime = DateTimeUtil.getSysTime();
        if(expireTime.compareTo(currentTime) < 0){
            throw new AccountErrorException("账号已失效");
        }
        //锁定状态
        String lockState = user.getLockState();
        if("0".equals(lockState)){
            throw new AccountErrorException("账号已锁定");
        }
        //判断IP范围
        String allowIps = user.getAllowIps();
        if(!allowIps.contains(ip)){
            throw new AccountErrorException("IP地址受限");
        }
        return user;

    }
    @Override
    public List<User> getUserList() {
        List<User> userList = userDao.getUserList();
        return userList;
    }

    @Override
    public User getUserById(String userId) {
        return userDao.getUserById(userId);
    }

    @Override
    public boolean changePwd(String secNewPwd,String userId) {
        boolean flag = true;
        Map<String,String> map = new HashMap<String,String>();
        map.put("secNewPwd",secNewPwd);
        map.put("userId",userId);
        int count = userDao.changePwd(map);
        if(count != 1){
            flag = false;
        }
        return flag;
    }
}
