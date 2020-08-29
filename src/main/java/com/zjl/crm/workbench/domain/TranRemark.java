package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class TranRemark implements Serializable {
    private static final long serialVersionUID = 44051283693510304L;
    private String id;
    private String noteContent;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String editFlag;
    private String tranId;
}
