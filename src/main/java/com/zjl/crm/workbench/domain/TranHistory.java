package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class TranHistory implements Serializable {
	private static final long serialVersionUID = -2490920664337954790L;
	private String id;
	private String stage;
	private String money;
	private String expectedDate;
	private String createTime;
	private String createBy;
	private String tranId;

	private String possibility;

}
