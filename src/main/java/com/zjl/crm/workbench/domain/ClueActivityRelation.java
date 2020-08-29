package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class ClueActivityRelation implements Serializable {
	private static final long serialVersionUID = 2775996076634231328L;
	private String id;
	private String clueId;
	private String activityId;
}
