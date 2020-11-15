package com.zjl.crm.settings.dao;

import com.zjl.crm.settings.domain.Dept;

import java.util.List;
import java.util.Map;

public interface DeptDao {
    List<Dept> getDept();
    List<String> getDeptName(String name);

    String getDeptNoByName(String dept);

    int getTotal();

    List<Dept> getDeptList(Map<String, Object> map);

    int save(Dept dept);

    int delete(String[] ids);

    Dept getDetailByNo(String no);

    int update(Dept dept);
}
