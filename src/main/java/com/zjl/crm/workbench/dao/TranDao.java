package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {

    int save(Tran tran);

    List<Tran> getTranListByCustomerId(String customerId);

    int deleteTranById(String id);

    int getCountByContactsIds(String[] ids);

    int deleteByContactsIds(String[] ids);

    List<Tran> getTranListByContactsId(String contactsId);

    int getTotalByCondition(Map<String, Object> map);

    List<Tran> getTranListByCondition(Map<String, Object> map);

    Tran detail(String id);

    int changeStage(Tran tran);

    int deleteByIds(String[] ids);

    int update(Tran tran);

    int getTotal();

    List<Map<String, Object>> getCharts();

    List<String> getStageList();

    List<Integer> getCountList();

    int getTotalByCustomerId(String id);

    int deleteByCustomerId(String id);

    void deleteByCustomerIds(String[] ids);
}
