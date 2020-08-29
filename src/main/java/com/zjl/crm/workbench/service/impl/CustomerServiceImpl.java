package com.zjl.crm.workbench.service.impl;

import com.zjl.crm.settings.dao.UserDao;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.dao.ContactsDao;
import com.zjl.crm.workbench.dao.CustomerDao;
import com.zjl.crm.workbench.dao.CustomerRemarkDao;
import com.zjl.crm.workbench.dao.TranDao;
import com.zjl.crm.workbench.domain.*;
import com.zjl.crm.workbench.service.CustomerService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
public class CustomerServiceImpl implements CustomerService {
    @Resource
    private CustomerDao customerDao;
    @Resource
    private CustomerRemarkDao customerRemarkDao;
    @Resource
    private UserDao userDao;
    @Resource
    private TranDao tranDao;
    @Resource
    private ContactsDao contactsDao;
    @Override
    public PageinationVO<Customer> pageList(Map<String, Object> map) {
        int total = customerDao.getTotalByCondition(map);
        List<Customer> dataList = customerDao.getCustomerListByCondition(map);
        PageinationVO<Customer> vo = new PageinationVO<>();
        vo.setDataList(dataList);
        vo.setTotal(total);
        return vo;
    }

    @Override
    public List<User> getUserList() {
        List<User> userList = userDao.getUserList();
        return userList;
    }

    @Override
    public boolean save(Customer customer) {
        boolean flag = true;
        int count = customerDao.save(customer);
        if(count != 1){
            flag = false;
        }
        return flag;
    }
    @Transactional
    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        //关联的备注
        //级联删除备注  查询出需要删除备注的数量
        int count1 = customerRemarkDao.getCountByAids(ids);
        //删除备注影响行数
        int count2 = customerRemarkDao.deleteByAids(ids);
        if(count1 != count2){
            flag = false;
        }
        tranDao.deleteByCustomerIds(ids);
        int count3 = customerDao.delete(ids);
        if(count3 != ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndCustomer(String id) {
        List<User> userList = userDao.getUserList();
        Customer customer = customerDao.getCustomerById(id);
        Map<String, Object> map = new HashMap<>();
        map.put("uList",userList);
        map.put("customer",customer);
        return map;
    }

    @Override
    public boolean update(Customer customer) {
        boolean flag = true;
        int count = customerDao.update(customer);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Customer detail(String id) {
        Customer customer = customerDao.detail(id);
        return customer;
    }
    @Transactional
    @Override
    public boolean deleteById(String id) {
        boolean flag = true;

        int count1 = tranDao.getTotalByCustomerId(id);
        int count2 = tranDao.deleteByCustomerId(id);
        if(count1 != count2){
            flag = false;
        }
        int count3 = customerDao.deleteById(id);
        customerRemarkDao.deleteByCustomerId(id);
        if(count3 != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public List<CustomerRemark> getRemarkListById(String customerId) {
        List<CustomerRemark> remarkList = customerRemarkDao.getRemarkListById(customerId);
        return remarkList;
    }

    @Override
    public boolean saveRemark(CustomerRemark customerRemark) {
        boolean flag = true;
        int count = customerRemarkDao.save(customerRemark);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean deleteRemark(String id) {
        boolean flag = true;
        int count = customerRemarkDao.deleteById(id);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean updateRemark(CustomerRemark customerRemark) {
        boolean flag = true;
        int count = customerRemarkDao.updateRemark(customerRemark);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public List<Tran> getTranListByCustomerId(String customerId) {
        List<Tran> tranList = tranDao.getTranListByCustomerId(customerId);
        return tranList;
    }

    @Override
    public boolean deleteTranById(String id) {
        boolean flag = true;
        int count = tranDao.deleteTranById(id);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public List<Contacts> getContactsListByCustomerId(String customerId) {
        List<Contacts> contactsList = contactsDao.getContactsListByCustomerId(customerId);
        return contactsList;
    }

    @Override
    public boolean deleteContactById(String id) {
        boolean flag = true;
        int count = contactsDao.deleteContactById(id);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public List<String> getCustomerName(String name) {
        return customerDao.getCustomerName(name);
    }
    @Override
    public Map<String, Object> getCharts() {
        int total = contactsDao.getTotal();
        List<Map<String,Object>> dataList = contactsDao.getCharts();
        Map<String, Object> map = new HashMap<>();
        List<String> customerList = contactsDao.getCustomerList();
        List<Integer> countList = contactsDao.getCountList();
        map.put("total",total);
        map.put("dataList",dataList);
        map.put("customerList",customerList);
        map.put("countList",countList);
        return map;
    }
}
