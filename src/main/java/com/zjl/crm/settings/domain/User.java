package com.zjl.crm.settings.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class User implements Serializable {
    private static final long serialVersionUID = -6082137502962860535L;
    private String id;//编号 主键
    private String loginAct;//登录账号
    private String name;//用户的真实姓名
    private String loginPwd;//登录密码
    private String email;//邮箱
    private String expireTime;//失效时间19位 yyyy-MM-dd HH-mm-ss
    private String lockState;//锁定状态 0锁定  1启用
    private String deptno;//部门编号
    private String allowIps;//允许访问的ip地址
    private String createTime;//创建时间 19位 yyyy-MM-dd HH-mm-ss
    private String createBy;//创建人
    private String editTime;//修改时间 19位 yyyy-MM-dd HH-mm-ss
    private String editBy;//修改人
}
