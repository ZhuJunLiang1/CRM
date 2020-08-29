package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.Contacts;

import java.util.List;
import java.util.Map;

public interface ContactsDao {

    int save(Contacts contacts);

    List<Contacts> getContactsListByCustomerId(String customerId);

    int deleteContactById(String id);

    int addContact(Contacts contacts);

    int getTotalByCondition(Map<String, Object> map);

    List<Contacts> getContactsListByCondition(Map<String, Object> map);

    int deleteByIds(String[] ids);

    int deleteById(String id);

    Contacts getContactsById(String id);

    int update(Contacts contacts);

    Contacts detail(String id);

    List<Contacts> getContactsListByName(String contactsName);

    String getIdByName(String contactsId);

    int getTotal();

    List<Map<String, Object>> getCharts();

    List<String> getCustomerList();

    List<Integer> getCountList();
}
