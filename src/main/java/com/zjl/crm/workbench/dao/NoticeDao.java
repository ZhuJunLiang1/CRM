package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.Notice;

import java.util.List;
import java.util.Map;

public interface NoticeDao {

    int save(Notice notice);

    int getTotal();

    List<Notice> getListByPage(Map<String, Object> map);

    int deleteById(String id);
}
