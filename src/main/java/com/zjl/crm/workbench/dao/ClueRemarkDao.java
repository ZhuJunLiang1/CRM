package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.ClueRemark;

import java.util.List;

public interface ClueRemarkDao {

    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    List<ClueRemark> getRemarkListById(String clueId);

    int deleteById(String id);

    int saveRemark(ClueRemark clueRemark);

    int updateRemark(ClueRemark clueRemark);
}
