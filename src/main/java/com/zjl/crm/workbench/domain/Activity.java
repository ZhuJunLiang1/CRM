package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class Activity implements Serializable {
    private static final long serialVersionUID = 84621016364158803L;
    private String id;  //主键
    private String owner;  //所有者
    private String name;  // 市场活动名称
    private String startDate;  // 开始时间  年月日
    private String endDate;  //结束日期
    private String cost;  // 成本
    private String description;  //描述
    private String createTime;  //创建时间 年月日 时分秒
    private String createBy;  //创建人
    private String editTime;  //修改时间 年月日 时分秒
    private String editBy;  //修改人
}
