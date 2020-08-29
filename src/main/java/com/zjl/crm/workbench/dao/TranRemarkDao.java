package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.TranRemark;

import java.util.List;

public interface TranRemarkDao {
    List<TranRemark> getRemarkListByTranId(String tranId);

    int save(TranRemark tranRemark);

    int updateRemark(TranRemark tranRemark);

    int deleteTranRemarkById(String id);

    int getTotalByTranIds(String[] ids);

    int deleteByTranIds(String[] ids);
}
