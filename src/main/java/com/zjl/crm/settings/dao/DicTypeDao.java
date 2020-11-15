package com.zjl.crm.settings.dao;

import com.zjl.crm.settings.domain.DicType;

import java.util.List;

public interface DicTypeDao {
    List<DicType> getTypeList();

    int delete(String[] codes);

    DicType getDicTypeByCode(String code);

    int save(DicType dicType);

    int update(DicType dicType);
}
