package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class ClueRemark implements Serializable {
	private static final long serialVersionUID = 7531856473064984835L;
	private String id;
	private String noteContent;
	private String createBy;
	private String createTime;
	private String editBy;
	private String editTime;
	private String editFlag;
	private String clueId;
}
