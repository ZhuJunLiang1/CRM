package com.zjl.crm.workbench.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class ContactsActivityRelation implements Serializable {
	private static final long serialVersionUID = 3408763644330934984L;
	private String id;
	private String contactsId;
	private String activityId;
}
