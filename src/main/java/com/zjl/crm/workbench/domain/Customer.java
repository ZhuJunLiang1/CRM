package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class Customer implements Serializable {
	private static final long serialVersionUID = 6826524716857478741L;
	private String id;
	private String owner;
	private String name;
	private String website;
	private String phone;
	private String createBy;
	private String createTime;
	private String editBy;
	private String editTime;
	private String contactSummary;
	private String nextContactTime;
	private String description;
	private String address;
}
