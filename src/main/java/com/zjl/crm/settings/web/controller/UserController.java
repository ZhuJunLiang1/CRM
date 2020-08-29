package com.zjl.crm.settings.web.controller;

import com.zjl.crm.settings.domain.User;
import com.zjl.crm.settings.service.UserService;
import com.zjl.crm.utils.MD5Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/settings/user")
public class UserController {
    @Resource
    private UserService userService;

    @RequestMapping("/login.do")
    @ResponseBody
    public Map login(HttpServletRequest request,String loginAct,String loginPwd){
        Map<String,Object> map = new HashMap<>();
        //密码明文形式转换为MD5密文形式
        loginPwd = MD5Util.getMD5(loginPwd);
        //浏览器端IP地址
        String ip = request.getRemoteAddr();
        try{
            User user = userService.login(loginAct,loginPwd,ip);
            request.getSession().setAttribute("user",user);
            //之行到此，表示登陆成功
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            //登录失败
            String msg = e.getMessage();
            //作为controller 为ajax提供多项信息
            // 1 打包为map，mao解析为json串（一次使用）
            // 2 创建一个vo (大量使用)
            map.put("success",false);
            map.put("msg",msg);
        }finally {
            return map;
        }
    }
    @RequestMapping("/logout.do")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session == null){
            return "redirect:/index.html";
        }
        session.removeAttribute("user");
        return "redirect:/index.html";
    }
    @RequestMapping("/changePwd.do")
    @ResponseBody
    public Map<String,Object> changePwd(String userId,String oldPwd,String newPwd){
        Map<String,Object> map = new HashMap<>();
        String secOldPwd = MD5Util.getMD5(oldPwd);
        String secNewPwd = MD5Util.getMD5(newPwd);
        User user = userService.getUserById(userId);
        if(secOldPwd.equals(user.getLoginPwd())){
            boolean flag = userService.changePwd(secNewPwd,userId);
            if(!flag){
                map.put("success",flag);
                map.put("msg","修改密码失败");
            }
            map.put("success",flag);
        }else {
            map.put("success",false);
            map.put("msg","您输入的旧密码有误");
        }
        return map;
    }


}
