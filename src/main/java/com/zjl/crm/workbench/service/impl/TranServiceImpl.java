package com.zjl.crm.workbench.service.impl;

import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.dao.*;
import com.zjl.crm.workbench.domain.*;
import com.zjl.crm.workbench.service.TranService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TranServiceImpl implements TranService {
    @Resource
    private TranDao tranDao;
    @Resource
    private TranHistoryDao tranHistoryDao;
    @Resource
    private TranRemarkDao tranRemarkDao;
    @Resource
    private CustomerDao customerDao;
    @Resource
    private ActivityDao activityDao;
    @Resource
    private ContactsDao contactsDao;
    @Override
    public PageinationVO<Tran> pageList(Map<String, Object> map) {
        int total = tranDao.getTotalByCondition(map);
        List<Tran> dataList = tranDao.getTranListByCondition(map);
        PageinationVO<Tran> vo = new PageinationVO<>();
        vo.setDataList(dataList);
        vo.setTotal(total);
        return vo;
    }

    @Override
    public boolean save(Tran tran, String customerName) {
        boolean flag = true;
        //判断customer 先处理 客户相关 最后 处理添加
        //判断该客户是否存在  存在则取id 存入tran
        //不存在则创建 将 id 存入tran
        //添加交易完毕后，创建一条交易历史
        Customer customer = customerDao.getCustomerByName(customerName);
        if(customer == null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setCreateBy(tran.getCreateBy());
            customer.setContactSummary(tran.getContactSummary());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setOwner(tran.getOwner());
            int count1 = customerDao.save(customer);
            if(count1 != 1){
                flag = false;
            }
        }
        tran.setCustomerId(customer.getId());
        int count2 = tranDao.save(tran);
        if(count2 != 1){
            flag = false;
        }
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setTranId(tran.getId());
        tranHistory.setStage(tran.getStage());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setCreateBy(tran.getCreateBy());
        tranHistory.setCreateTime(tran.getCreateTime());
        int count3 = tranHistoryDao.save(tranHistory);
        if(count3 != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Tran detail(String id) {
        return tranDao.detail(id);
    }

    @Override
    public List<TranHistory> getHistoryListByTranId(String tranId) {
        return tranHistoryDao.getHistoryListByTranId(tranId);
    }

    @Override
    public List<TranRemark> getRemarkListByTranId(String tranId) {
        return tranRemarkDao.getRemarkListByTranId(tranId);
    }

    @Override
    public boolean saveRemark(TranRemark tranRemark) {
        boolean flag = true;
        int count = tranRemarkDao.save(tranRemark);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean updateRemark(TranRemark tranRemark) {
        boolean flag = true;
        int count = tranRemarkDao.updateRemark(tranRemark);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public boolean deleteTranRemarkById(String id) {
        boolean flag = true;
        int count = tranRemarkDao.deleteTranRemarkById(id);
        if(count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public boolean changeStage(Tran tran) {
        boolean flag = true;
        int count = tranDao.changeStage(tran);
        if(count != 1){
            flag=false;
        }
        //生成一条交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setCreateBy(tran.getEditBy());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setTranId(tran.getId());
        tranHistory.setStage(tran.getStage());
        int count2 = tranHistoryDao.save(tranHistory);
        if(count2 != 1){
            flag=false;
        }
        return flag;
    }
    @Transactional
    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        int count1 = tranDao.deleteByIds(ids);
        if(count1 != ids.length){
            flag = false;
        }
        int count2 = tranHistoryDao.getTotalByTranIds(ids);
        int count3 = tranHistoryDao.deleteByTranIds(ids);
        if(count2 != count3){
            flag = false;
        }
        int count4 = tranRemarkDao.getTotalByTranIds(ids);
        int count5 = tranRemarkDao.deleteByTranIds(ids);
        if(count4 != count5){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean update(Tran tran, String customerName) {
        boolean flag = true;
        Customer customer = customerDao.getCustomerByName(customerName);
        if(customer == null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setCreateBy(tran.getCreateBy());
            customer.setContactSummary(tran.getContactSummary());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setOwner(tran.getOwner());
            int count1 = customerDao.save(customer);
            if(count1 != 1){
                flag = false;
            }
        }
        tran.setCustomerId(customer.getId());
        int count2 = tranDao.update(tran);
        if(count2 != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> getCharts() {
        int total = tranDao.getTotal();
        List<Map<String,Object>> dataList = tranDao.getCharts();
        Map<String, Object> map = new HashMap<>();
        List<String> stageList = tranDao.getStageList();
        List<Integer> countList = tranDao.getCountList();
        map.put("total",total);
        map.put("dataList",dataList);
        map.put("stageList",stageList);
        map.put("countList",countList);
        return map;
    }
}
