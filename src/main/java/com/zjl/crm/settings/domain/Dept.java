package com.zjl.crm.settings.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class Dept implements Serializable{
    private static final long serialVersionUID = -1645005937095857391L;
    private String no;
    private String name;
    private String manager;
    private String phone;
    private String description;
}
