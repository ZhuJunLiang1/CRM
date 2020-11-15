package com.zjl.crm.workbench.service.impl;

import com.zjl.crm.settings.dao.UserDao;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.dao.*;
import com.zjl.crm.workbench.domain.*;
import com.zjl.crm.workbench.service.ClueService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {
    @Resource
    private ClueDao clueDao;
    @Resource
    private ClueRemarkDao clueRemarkDao;
    @Resource
    private ClueActivityRelationDao clueActivityRelationDao;
    @Resource
    private CustomerDao customerDao;
    @Resource
    private CustomerRemarkDao customerRemarkDao;
    @Resource
    private ContactsDao contactsDao;
    @Resource
    private ContactsRemarkDao contactsRemarkDao;
    @Resource
    private ContactsActivityRelationDao contactsActivityRelationDao;
    @Resource
    private TranDao tranDao;
    @Resource
    private TranHistoryDao tranHistoryDao;
    @Resource
    private UserDao userDao;

    @Override
    public boolean save(Clue clue) {
        boolean flag = true;
        int count = clueDao.save(clue);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public PageinationVO<Clue> pageList(Map<String, Object> map) {
        //取total
        int total = clueDao.getTotalByCondition(map);
        //取得dataList 封装到vo返回
        List<Clue> dataList = clueDao.getClueListByCondition(map);
        PageinationVO<Clue> vo = new PageinationVO<>();
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
        int count1 = clueRemarkDao.getCountByAids(ids);
        //删除备注影响行数
        int count2 = clueRemarkDao.deleteByAids(ids);
        if(count1 != count2){
            flag = false;
        }
        int count3 = clueDao.delete(ids);
        if(count3 != ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndClue(String id) {
        //取uList
        List<User> uList = userDao.getUserList();
        //取activity
        Clue clue = clueDao.getById(id);
        //封装进map 中
        Map<String,Object> map = new HashMap<>();
        map.put("uList",uList);
        map.put("clue",clue);
        return map;
    }

    @Override
    public boolean update(Clue clue) {
        boolean flag = true;
        int count = clueDao.update(clue);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Clue detail(String id) {
        return clueDao.detail(id);
    }

    @Override
    public List<ClueRemark> getRemarkListById(String clueId) {
        List<ClueRemark> remarkList = clueRemarkDao.getRemarkListById(clueId);
        return remarkList;
    }
    @Override
    public boolean deleteRemark(String id) {
        boolean flag = true;
        int count = clueRemarkDao.deleteById(id);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean saveRemark(ClueRemark clueRemark) {
        boolean flag = true;
        int count = clueRemarkDao.saveRemark(clueRemark);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public boolean updateRemark(ClueRemark clueRemark) {
        boolean flag = true;
        int count = clueRemarkDao.updateRemark(clueRemark);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public boolean unbund(String id) {
        boolean flag = true;
        int count =clueActivityRelationDao.deleteById(id);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean bund(String clueId, String[] aids) {
        boolean flag = true;
        for (String aid:aids){
            ClueActivityRelation car = new ClueActivityRelation();
            car.setId(UUIDUtil.getUUID());
            car.setClueId(clueId);
            car.setActivityId(aid);
            int count = clueActivityRelationDao.bund(car);
            if(count != 1){
                flag = false;
            }
        }
        return flag;
    }

    @Transactional
    @Override
    public boolean convert(String clueId,Tran tran, String createBy) {
        String createTime = DateTimeUtil.getSysTime();
        boolean flag = true;
        //1、通过线索id获取线索对象（线索的详情信息）
        Clue clue = clueDao.getById(clueId);
        //2、通过线索对象提取客户信息，若客户不存在，新建客户
        String company = clue.getCompany();
        Customer customer = customerDao.getCustomerByName(company);
        if(customer == null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setAddress(clue.getAddress());
            customer.setOwner(clue.getOwner());
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setName(company);
            customer.setDescription(clue.getDescription());
            customer.setCreateTime(createTime);
            customer.setCreateBy(createBy);
            customer.setContactSummary(clue.getContactSummary());
            int count1 = customerDao.save(customer);
            if (count1 != 1){
                flag = false;
            }
        }
        //第二步处理后已经得到了 客户的信息
        //3、通过线索对象 提取联系人信息，保存联系人
        Contacts contacts = new Contacts();
        contacts.setId(UUIDUtil.getUUID());
        contacts.setSource(clue.getSource());
        contacts.setOwner(clue.getOwner());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(clue.getJob());
        contacts.setFullname(clue.getFullname());
        contacts.setEmail(clue.getEmail());
        contacts.setDescription(clue.getDescription());
        contacts.setCustomerId(customer.getId());
        contacts.setCreateTime(createTime);
        contacts.setCreateBy(createBy);
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setAppellation(clue.getAppellation());
        contacts.setAddress(clue.getAddress());
        //添加联系人
        int count2 = contactsDao.save(contacts);
        if(count2 != 1){
            flag = false;
        }
        //经过第三步处理， 已经拥有联系人信息， 若使用联系人ID 直接 get
        //4、线索备注转换到客户备注以及联系人备注
        //查询出与该线索关联的备注信息列表
        List<ClueRemark> clueRemarkList = clueRemarkDao.getRemarkListById(clueId);
        for (ClueRemark clueRemark : clueRemarkList){
            //取出备注信息(主要转换到客户备注和联系人备注的是备注信息)
            String noteContent = clueRemark.getNoteContent();
            //创建客户备注
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCreateBy(createBy);
            customerRemark.setCreateTime(createTime);
            customerRemark.setCustomerId(customer.getId());
            customerRemark.setEditFlag("0");
            customerRemark.setNoteContent(noteContent);
            int count3 = customerRemarkDao.save(customerRemark);
            if(count3 != 1){
                flag = false;
            }
            //创建联系人备注
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setCreateTime(createTime);
            contactsRemark.setContactsId(contacts.getId());
            contactsRemark.setEditFlag("0");
            contactsRemark.setNoteContent(noteContent);
            int count4 = contactsRemarkDao.save(contactsRemark);
            if(count4 != 1){
                flag = false;
            }
        }
        //5、线索和市场活动关联关系转移到 联系人和市场活动关系
        //查询出与该条线索关联的市场活动
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationDao.getListByClueId(clueId);
        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList){
            //取出activityId 与联系人相关联
            String activityId = clueActivityRelation.getActivityId();
            //创建联系人 与市场活动的关联关系
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setActivityId(activityId);
            contactsActivityRelation.setContactsId(contacts.getId());
            int count5 = contactsActivityRelationDao.save(contactsActivityRelation);
            if(count5 != 1){
                flag = false;
            }
        }
        //6、若有创建交易需求，需要创建一条交易
        if(tran.getId() != null){
            //已经封装好的：  id,name,money,expectedDate stat----
            //从CLUE中取出部分信息完善tran
            tran.setSource(clue.getSource());
            tran.setOwner(clue.getOwner());
            tran.setNextContactTime(clue.getNextContactTime());
            tran.setDescription(clue.getDescription());
            tran.setCustomerId(customer.getId());
            tran.setContactSummary(clue.getContactSummary());
            tran.setContactsId(contacts.getId());
            //添加交易
            int count6 = tranDao.save(tran);
            if(count6 != 1){
                flag = false;
            }
            //7、如果创建了交易，则创建一条该交易下的交易历史
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(UUIDUtil.getUUID());
            tranHistory.setCreateBy(createBy);
            tranHistory.setCreateTime(createTime);
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setStage(tran.getStage());
            tranHistory.setTranId(tran.getId());
            int count7 = tranHistoryDao.save(tranHistory);
            if(count7 != 1){
                flag = false;
            }
        }
        //8、删除线索备注
        for (ClueRemark clueRemark : clueRemarkList){
            int count8 = clueRemarkDao.deleteById(clueRemark.getId());
            if(count8 != 1){
                flag = false;
            }
        }
        //9、删除线索和市场活动的关联关系
        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList){
            int count9 = clueActivityRelationDao.deleteById(clueActivityRelation.getId());
            if(count9 != 1){
                flag = false;
            }
        }
        //10、删除线索
        int count10 = clueDao.deleteById(clueId);
        if(count10 != 1){
            flag = false;
        }
        return flag;
    }
    @Override
    public Map<String, Object> getCharts() {
        int total = clueDao.getTotal();
        List<Map<String,Object>> dataList = clueDao.getCharts();
        Map<String, Object> map = new HashMap<>();
        List<String> clueList = clueDao.getClueSourceList();
        List<Integer> countList = clueDao.getCountList();
        map.put("total",total);
        map.put("dataList",dataList);
        map.put("clueList",clueList);
        map.put("countList",countList);
        return map;
    }
}
