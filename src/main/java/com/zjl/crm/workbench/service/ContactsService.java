package com.zjl.crm.workbench.service;

import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.Activity;
import com.zjl.crm.workbench.domain.Contacts;
import com.zjl.crm.workbench.domain.ContactsRemark;
import com.zjl.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface ContactsService {
    PageinationVO<Contacts> pageList(Map<String, Object> map);

    boolean delete(String[] ids);

    boolean save(Contacts contacts,String customerName);

    Map<String, Object> getUserListAndContacts(String id);

    Map<String, Object> update(Contacts contacts,String customerName);

    Contacts detail(String id);

    Map<String, Object> deleteById(String id);

    List<ContactsRemark> getRemarkListByContactsId(String contactsId);

    Map<String, Object> deleteRemarkById(String id);

    Map<String, Object> saveRemark(ContactsRemark contactsRemark);

    Map<String, Object> updateRemark(ContactsRemark contactsRemark);

    List<Tran> getTranListByContactsId(String contactsId);

    Map<String, Object> deleteTranById(String id);

    List<Activity> getActivityListByContactsId(String contactsId);

    Map<String, Object> unbundActivity(String activityId, String contactsId);

    List<Activity> getActivityListByNameAndNotByContactsId(Map<String,Object> map);

    boolean bund(String contactsId, String[] aids);
    List<Contacts> getContactsListByName(String contactsName);

    boolean addContact(Contacts contacts);

    String getIdByName(String contactsId);
}
