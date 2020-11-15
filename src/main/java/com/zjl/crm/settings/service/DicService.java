package com.zjl.crm.settings.service;

import com.zjl.crm.settings.domain.DicType;
import com.zjl.crm.settings.domain.DicValue;

import java.util.List;
import java.util.Map;

public interface DicService {
    Map<String, List<DicValue>> getAll();

    List<DicValue> getValList();

    boolean delete(String[] ids);

    List<String> getTypeCode();

    boolean saveDicValue(DicValue dicValue);

    DicValue getDicValueById(String id);

    boolean updateValue(DicValue dicValue);

    List<DicType> getTypeList();

    boolean deleteType(String[] codes);

    DicType getDicTypeByCode(String code);

    boolean saveDicType(DicType dicType);

    boolean updateType(DicType dicType);
}
