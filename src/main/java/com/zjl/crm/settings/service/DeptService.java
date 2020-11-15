package com.zjl.crm.settings.service;

import com.zjl.crm.settings.domain.Dept;
import com.zjl.crm.vo.PageinationVO;

import java.util.List;
import java.util.Map;

public interface DeptService {
    List<String> getDeptName(String name);

    String getDeptNoByName(String dept);

    PageinationVO pageList(Map<String, Object> map);

    boolean save(Dept dept);

    boolean delete(String[] nos);

    Dept getDetailByNo(String no);

    boolean update(Dept dept);
}
