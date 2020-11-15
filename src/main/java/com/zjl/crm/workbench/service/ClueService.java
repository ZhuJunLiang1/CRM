package com.zjl.crm.workbench.service;

import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.Clue;
import com.zjl.crm.workbench.domain.ClueRemark;
import com.zjl.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface ClueService {


    boolean save(Clue clue);

    PageinationVO<Clue> pageList(Map<String, Object> map);

    boolean delete(String[] ids);

    Map<String, Object> getUserListAndClue(String id);

    boolean update(Clue clue);

    Clue detail(String id);

    List<ClueRemark> getRemarkListById(String clueId);

    boolean deleteRemark(String id);

    boolean saveRemark(ClueRemark clueRemark);

    boolean updateRemark(ClueRemark clueRemark);

    boolean unbund(String id);

    boolean bund(String clueId, String[] aids);

    boolean convert(String clueId, Tran tran, String createBy);

    Map<String, Object> getCharts();
}
