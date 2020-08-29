package com.zjl.crm.settings.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class DicValue implements Serializable {
    private static final long serialVersionUID = -2762629718762230149L;
    private String id;
    private String value;
    private String text;
    private String orderNo;
    private String typeCode;
}
