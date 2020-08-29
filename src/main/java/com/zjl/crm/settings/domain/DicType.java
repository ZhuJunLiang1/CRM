package com.zjl.crm.settings.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class DicType implements Serializable {
    private static final long serialVersionUID = 2778083814096897302L;
    private String code;
    private String name;
    private String description;
}