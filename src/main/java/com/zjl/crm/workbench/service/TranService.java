package com.zjl.crm.workbench.service;

import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.Contacts;
import com.zjl.crm.workbench.domain.Tran;
import com.zjl.crm.workbench.domain.TranHistory;
import com.zjl.crm.workbench.domain.TranRemark;

import java.util.List;
import java.util.Map;

public interface TranService {
    PageinationVO<Tran> pageList(Map<String, Object> map);

    boolean save(Tran tran, String customerName);

    Tran detail(String id);

    List<TranHistory> getHistoryListByTranId(String tranId);

    List<TranRemark> getRemarkListByTranId(String tranId);

    boolean saveRemark(TranRemark tranRemark);

    boolean updateRemark(TranRemark tranRemark);

    boolean deleteTranRemarkById(String id);

    boolean changeStage(Tran tran);

    boolean delete(String[] ids);

    boolean update(Tran tran, String customerName);

    Map<String, Object> getCharts();
}
