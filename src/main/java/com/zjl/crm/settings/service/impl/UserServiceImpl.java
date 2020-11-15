package com.zjl.crm.settings.service.impl;

import com.zjl.crm.exception.AccountErrorException;
import com.zjl.crm.exception.LoginException;
import com.zjl.crm.settings.dao.DeptDao;
import com.zjl.crm.settings.dao.UserDao;
import com.zjl.crm.settings.domain.Dept;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.settings.service.UserService;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.Activity;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;
    @Resource
    private DeptDao deptDao;

    @Override
    public User login(String loginAct, String loginPwd, String ip) throws LoginException {
        Map<String,String> map = new HashMap<>();
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
        //判断锁定状态
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
    public Map<String, Object> register(User user) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date now = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        calendar.add(Calendar.MONTH,+1);
        String date = sdf.format(calendar.getTime());
        //默认账户失效时间为一个月后
        user.setExpireTime(date);
        Map<String,Object> map = new HashMap<>();
        boolean flag = true;
        int count = userDao.save(user);
        if (count != 1){
            flag = false;
            map.put("msg","注册失败,请稍后再试");
        }
        map.put("success",flag);
        return map;
    }

    @Override
    public User getUserByLoginAct(String loginAct) {
        return userDao.getUserByLoginAct(loginAct);
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

    @Override
    public PageinationVO pageList(Map<String, Object> map) {
        //取得total
        int total = userDao.getTotalByCondition(map);
        //取得dataList 封装到vo 返回
        List<User> dataList = userDao.getUserListByCondition(map);
        PageinationVO<User> vo = new PageinationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        int count1 = userDao.delete(ids);
        if(count1 != ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public List<Dept> getDept() {
        return deptDao.getDept();
    }

    @Override
    public Map<String, Boolean> save(User user) {
        boolean flag = true;
        int count = userDao.save(user);
        if(count != 1){
            flag = false;
        }
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @Override
    public Map<String, Boolean> update(User user) {
        boolean flag = true;
        int count = userDao.update(user);
        if(count != 1){
            flag = false;
        }
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }


}
