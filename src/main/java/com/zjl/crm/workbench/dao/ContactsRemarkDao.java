package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.ContactsRemark;

import java.util.List;

public interface ContactsRemarkDao {

    int save(ContactsRemark contactsRemark);

    int getCountByContactsIds(String[] ids);

    int deleteByContactsIds(String[] ids);

    List<ContactsRemark> getRemarkListByContactsId(String contactsId);

    int deleteRemarkById(String id);

    int updateRemark(ContactsRemark contactsRemark);
}
