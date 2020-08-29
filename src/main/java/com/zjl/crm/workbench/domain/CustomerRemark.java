package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class CustomerRemark implements Serializable {
	private static final long serialVersionUID = -5032387430210060304L;
	private String id;
	private String noteContent;
	private String createTime;
	private String createBy;
	private String editTime;
	private String editBy;
	private String editFlag;
	private String customerId;
}
