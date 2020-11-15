package com.zjl.crm.settings.dao;

import com.zjl.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {
    List<DicValue> getListByCode(String code);

    List<DicValue> getValList();

    int delete(String[] ids);

    List<String> getTypeCode();

    int save(DicValue dicValue);

    DicValue getDicValueById(String id);

    int update(DicValue dicValue);
}
