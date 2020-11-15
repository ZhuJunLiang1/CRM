package com.zjl.crm.settings.web.controller;

import com.zjl.crm.settings.domain.Dept;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.settings.service.DeptService;
import com.zjl.crm.settings.service.UserService;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.MD5Util;
import com.zjl.crm.utils.RandomValidateCode;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/settings/user")
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private DeptService deptService;

    @PostMapping("/login.do")
    @ResponseBody
    public Map<String,Object> login(HttpServletRequest request,String loginAct,String loginPwd,String code){
        Map<String,Object> map = new HashMap<>();
        //密码明文形式转换为MD5密文形式
        loginPwd = MD5Util.getMD5(loginPwd);
        //浏览器端IP地址
        String ip = request.getRemoteAddr();
        String checkCode = (String) request.getSession().getAttribute("randomcode_key");
        if (!code.equals(checkCode)){
            map.put("success",false);
            map.put("msg","验证码错误");
            return map;
        }
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

    @PostMapping("/register.do")
    @ResponseBody
    public Map<String,Object> register(HttpServletRequest request,User user,String code,String dept){
        Map<String,Object> map = new HashMap<>();
        String checkCode = (String) request.getSession().getAttribute("randomcode_key");
        if (!code.equals(checkCode)){
            map.put("success",false);
            map.put("msg","验证码错误");
            return map;
        }

        String deptNo = deptService.getDeptNoByName(dept);
        if (deptNo == "" || deptNo == null){
            map.put("success",false);
            map.put("msg","部门名称输入错误");
            return map;
        }

        User user1 = userService.getUserByLoginAct(user.getLoginAct());
        if (!(user1 == null || user1.equals(""))){
            map.put("success",false);
            map.put("msg","用户名已存在");
            return map;
        }

        user.setId(UUIDUtil.getUUID());
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        //默认账户不锁定
        user.setLockState("1");
        user.setCreateTime(DateTimeUtil.getSysTime());
        user.setCreateBy(user.getName());
        user.setDeptno(deptNo);
        Map<String,Object> message = userService.register(user);
        return message;
    }

    @RequestMapping("/logout.do")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session == null){
            return "redirect:/index.jsp";
        }
        session.removeAttribute("user");
        return "redirect:/index.jsp";
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
    @GetMapping("/pageList.do")
    @ResponseBody
    public PageinationVO pageList(User user,Integer pageNo,Integer pageSize,String startDate,String endDate){
        Map<String,Object> map = new HashMap<>();
        Integer skipCount = (pageNo-1)*pageSize;
        map.put("user",user);
        map.put("skipCount",skipCount);
        map.put("startDate",startDate);
        map.put("endDate",endDate);
        map.put("pageSize",pageSize);
        PageinationVO vo = userService.pageList(map);
        return vo;
    }
    @PostMapping("/delete.do")
    @ResponseBody
    public Map<String,Boolean> delete(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = userService.delete(ids);
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @GetMapping("/getDept.do")
    @ResponseBody
    public List<Dept> getDept(){
        return userService.getDept();
    }

    @PostMapping("/save.do")
    @ResponseBody
    public Map<String,Boolean> save(String loginPwd,User user,HttpServletRequest request){
        user.setId(UUIDUtil.getUUID());
        loginPwd = MD5Util.getMD5(loginPwd);
        user.setLoginPwd(loginPwd);
        user.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        user.setCreateTime(DateTimeUtil.getSysTime());
        return userService.save(user);
    }

    @GetMapping("/detail.do")
    @ResponseBody
    public ModelAndView detail(String id){
        ModelAndView mv = new ModelAndView();
        User user = userService.getUserById(id);
        mv.addObject("user",user);
        mv.setViewName("forward:/workbench/settings/user/detail.jsp");
        return mv;
    }
    @GetMapping("/getDeptName.do")
    @ResponseBody
    public List<String> getDeptName(String name){
        return deptService.getDeptName(name);
    }

    @PostMapping("/update.do")
    @ResponseBody
    public Map<String,Boolean> update(String id,String dept,String loginPwd,User user,HttpServletRequest request){
        String deptno = deptService.getDeptNoByName(dept);
        if(loginPwd == userService.getUserById(id).getLoginPwd()){
            user.setLoginPwd(loginPwd);
        }else {
            loginPwd = MD5Util.getMD5(loginPwd);
            user.setLoginPwd(loginPwd);
        }
        user.setDeptno(deptno);
        user.setEditBy(((User)request.getSession().getAttribute("user")).getName());
        user.setEditTime(DateTimeUtil.getSysTime());
        return userService.update(user);
    }
    @GetMapping("/getDetailById")
    @ResponseBody
    public User getDetailById(String id){
        return userService.getUserById(id);
    }

    @GetMapping("/getCheckCode.do")
    public void checkCode(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("image/jpeg");
        response.setHeader("pragma","no-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expire",0);

        RandomValidateCode randomValidateCode = new RandomValidateCode();
        try {
            randomValidateCode.getRandcode(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
