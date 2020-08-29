package com.zjl.crm.workbench.service;

import com.zjl.crm.settings.domain.User;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.Contacts;
import com.zjl.crm.workbench.domain.Customer;
import com.zjl.crm.workbench.domain.CustomerRemark;
import com.zjl.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface CustomerService {


    PageinationVO<Customer> pageList(Map<String, Object> map);

    List<User> getUserList();

    boolean save(Customer customer);

    boolean delete(String[] ids);

    Map<String, Object> getUserListAndCustomer(String id);

    boolean update(Customer customer);

    Customer detail(String id);

    boolean deleteById(String id);

    List<CustomerRemark> getRemarkListById(String customerId);

    boolean saveRemark(CustomerRemark customerRemark);

    boolean deleteRemark(String id);

    boolean updateRemark(CustomerRemark customerRemark);

    List<Tran> getTranListByCustomerId(String customerId);

    boolean deleteTranById(String id);

    List<Contacts> getContactsListByCustomerId(String customerId);

    boolean deleteContactById(String id);

    List<String> getCustomerName(String name);

    Map<String, Object> getCharts();
}
