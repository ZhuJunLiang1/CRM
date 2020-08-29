package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerDao {

    Customer getCustomerByName(String company);

    int save(Customer customer);

    int getTotalByCondition(Map<String, Object> map);

    List<Customer> getCustomerListByCondition(Map<String, Object> map);

    int delete(String[] ids);

    Customer getCustomerById(String id);

    int update(Customer customer);

    Customer detail(String id);

    int deleteById(String id);

    List<String> getCustomerName(String name);
}
