package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.TranHistory;

import java.util.List;

public interface TranHistoryDao {

    int save(TranHistory tranHistory);

    List<TranHistory> getHistoryListByTranId(String tranId);

    int getTotalByTranIds(String[] ids);

    int deleteByTranIds(String[] ids);
}
