package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.ContactsActivityRelation;

import java.util.Map;

public interface ContactsActivityRelationDao {

    int save(ContactsActivityRelation contactsActivityRelation);

    int getCountByContactsIds(String[] ids);

    int deleteByContactsIds(String[] ids);

    int unbundActivity(Map<String, Object> param);
}
