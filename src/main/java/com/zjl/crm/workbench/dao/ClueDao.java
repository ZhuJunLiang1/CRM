package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.Activity;
import com.zjl.crm.workbench.domain.Clue;

import java.util.List;
import java.util.Map;

public interface ClueDao {


    int save(Clue clue);

    int getTotalByCondition(Map<String, Object> map);

    List<Clue> getClueListByCondition(Map<String, Object> map);

    int delete(String[] ids);

    Clue getById(String id);

    int update(Clue clue);

    Clue detail(String id);

    int deleteById(String clueId);

    int getTotal();

    List<Map<String, Object>> getCharts();

    List<String> getClueSourceList();

    List<Integer> getCountList();
}
