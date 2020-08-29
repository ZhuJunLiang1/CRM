package com.zjl.crm.settings.dao;

import com.zjl.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {
    List<DicValue> getListByCode(String code);
}
