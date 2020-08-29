package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class ActivityRemark implements Serializable {
    private static final long serialVersionUID = 66794710291392936L;
    private String id;
    private String noteContent; //备注信息
    private String createTime;
    private String createBy;
    private String editTime;
    private String editBy;
    private String editFlag; //是否修改过
    private String activityId;
}
