package com.zjl.crm.workbench.service;

import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.Notice;

import java.util.HashMap;
import java.util.Map;

public interface NoticeService {

    HashMap<String, Object> save(Notice notice);

    PageinationVO pageList(Map<String, Object> map);

    Map<String, Object> deleteById(String id);
}
