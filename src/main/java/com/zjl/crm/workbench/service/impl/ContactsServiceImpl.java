package com.zjl.crm.workbench.service.impl;

import com.zjl.crm.settings.dao.UserDao;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.dao.*;
import com.zjl.crm.workbench.domain.*;
import com.zjl.crm.workbench.service.ContactsService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ContactsServiceImpl implements ContactsService {
    @Resource
    private ContactsDao contactsDao;
    @Resource
    private ContactsRemarkDao contactsRemarkDao;
    @Resource
    private TranDao tranDao;
    @Resource
    private ActivityDao activityDao;
    @Resource
    private UserDao userDao;
    @Resource
    private ContactsActivityRelationDao contactsActivityRelationDao;
    @Resource
    private CustomerDao customerDao;

    @Override
    public PageinationVO<Contacts> pageList(Map<String, Object> map) {
        int total = contactsDao.getTotalByCondition(map);
        List<Contacts> dataList = contactsDao.getContactsListByCondition(map);
        PageinationVO<Contacts> vo = new PageinationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }
    @Transactional
    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        //关联的备注
        //级联删除备注  查询出需要删除备注的数量
        int countRemark1 = contactsRemarkDao.getCountByContactsIds(ids);
        //级联交易
        int countTran1 = tranDao.getCountByContactsIds(ids);
        //市场活动
        int countActivity1 = contactsActivityRelationDao.getCountByContactsIds(ids);
        //删除备注影响行数
        int countRemark2 = contactsRemarkDao.deleteByContactsIds(ids);
        if(countRemark1 != countRemark2){
            flag = false;
        }
        //删除交易影响行
        int countTan2 = tranDao.deleteByContactsIds(ids);
        if(countTran1 != countTan2){
            flag = false;
        }
        //删除市场活动
        int countActivity2 = contactsActivityRelationDao.deleteByContactsIds(ids);
        if(countActivity1 != countActivity2){
            flag = false;
        }
        //删除联系人
        int count1 = contactsDao.deleteByIds(ids);
        if(count1 != ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean save(Contacts contacts,String customerName) {
        boolean flag  = true;
        Customer customer = customerDao.getCustomerByName(customerName);
        if(customer == null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setCreateBy(contacts.getCreateBy());
            customer.setContactSummary(contacts.getContactSummary());
            customer.setNextContactTime(contacts.getNextContactTime());
            customer.setOwner(contacts.getOwner());
            int count1 = customerDao.save(customer);
            if(count1 != 1){
                flag = false;
            }
        }
        contacts.setCustomerId(customer.getId());
        int count = contactsDao.save(contacts);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndContacts(String id) {
        Contacts contacts = contactsDao.getContactsById(id);
        List<User> userList = userDao.getUserList();
        Map<String,Object> map = new HashMap<>();
        map.put("uList",userList);
        map.put("contacts",contacts);
        return map;
    }

    @Override
    public Map<String, Object> update(Contacts contacts,String customerName) {
        boolean flag  = true;
        Customer customer = customerDao.getCustomerByName(customerName);
        if(customer == null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setCreateBy(contacts.getCreateBy());
            customer.setContactSummary(contacts.getContactSummary());
            customer.setNextContactTime(contacts.getNextContactTime());
            customer.setOwner(contacts.getOwner());
            int count1 = customerDao.save(customer);
            if(count1 != 1){
                flag = false;
            }
        }
        contacts.setCustomerId(customer.getId());
        int count = contactsDao.update(contacts);
        if(count != 1){
            flag = false;
        }
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @Override
    public Contacts detail(String id) {
        Contacts contacts = contactsDao.detail(id);
        return contacts;
    }
    @Transactional
    @Override
    public Map<String, Object> deleteById(String id) {
        boolean flag = true;
        //删除备注

        //删除联系人活动联系
        //删除交易
        Map<String, Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @Override
    public List<ContactsRemark> getRemarkListByContactsId(String contactsId) {
        return contactsRemarkDao.getRemarkListByContactsId(contactsId);
    }

    @Override
    public Map<String, Object> deleteRemarkById(String id) {
        boolean flag = true;
        int count = contactsRemarkDao.deleteRemarkById(id);
        if(count != 1){
            flag = false;
        }
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @Override
    public Map<String, Object> saveRemark(ContactsRemark contactsRemark) {
        boolean flag = true;
        int count = contactsRemarkDao.save(contactsRemark);
        if(count != 1){
            flag = false;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("success",flag);
        map.put("contactsRemark",contactsRemark);
        return map;
    }

    @Override
    public Map<String, Object> updateRemark(ContactsRemark contactsRemark) {
        boolean flag = true;
        int count = contactsRemarkDao.updateRemark(contactsRemark);
        if(count != 1){
            flag = false;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("success",flag);
        map.put("contactsRemark",contactsRemark);
        return map;
    }

    @Override
    public List<Tran> getTranListByContactsId(String contactsId) {
        List<Tran> tranList = tranDao.getTranListByContactsId(contactsId);
        return tranList;
    }

    @Override
    public Map<String, Object> deleteTranById(String id) {
        boolean flag = true;
        int count = tranDao.deleteTranById(id);
        if(count != 1){
            flag = false;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @Override
    public List<Activity> getActivityListByContactsId(String contactsId) {
        return activityDao.getActivityListByContactsId(contactsId);
    }

    @Override
    public Map<String, Object> unbundActivity(String activityId,String contactsId) {
        boolean flag = true;
        Map<String, Object> param = new HashMap<>();
        param.put("activityId",activityId);
        param.put("contactsId",contactsId);
        int count = contactsActivityRelationDao.unbundActivity(param);
        if(count != 1){
            flag = false;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @Override
    public List<Activity> getActivityListByNameAndNotByContactsId(Map<String, Object> map) {
        return activityDao.getActivityListByNameAndNotByContactsId(map);
    }

    @Override
    public boolean bund(String contactsId, String[] aids) {
        boolean flag = true;
        for(String aid:aids){
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setContactsId(contactsId);
            contactsActivityRelation.setActivityId(aid);
            int count = contactsActivityRelationDao.save(contactsActivityRelation);
            if(count != 1){
                flag = false;
            }
        }
        return flag;
    }
    @Override
    public List<Contacts> getContactsListByName(String contactsName) {
        return contactsDao.getContactsListByName(contactsName);
    }
    @Override
    public boolean addContact(Contacts contacts) {
        boolean flag = true;
        int count = contactsDao.addContact(contacts);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public String getIdByName(String contactsId) {
        return contactsDao.getIdByName(contactsId);
    }
}
