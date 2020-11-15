package com.zjl.crm.settings.service.impl;

import com.zjl.crm.settings.dao.DicTypeDao;
import com.zjl.crm.settings.dao.DicValueDao;
import com.zjl.crm.settings.domain.DicType;
import com.zjl.crm.settings.domain.DicValue;
import com.zjl.crm.settings.service.DicService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DicServiceImpl implements DicService {
    @Resource
    private DicTypeDao dicTypeDao;

    @Resource
    private DicValueDao dicValueDao;

    @Override
    public Map<String, List<DicValue>> getAll() {
        Map<String, List<DicValue>> map = new HashMap<>();
        //字典类型列表取出
        List<DicType> dtList = dicTypeDao.getTypeList();
        //将字典类型列表遍历
        for (DicType dt:dtList){
            String code = dt.getCode();
            //根据每一个字典类型取得字典值列表
            List<DicValue> dvList = dicValueDao.getListByCode(code);
            map.put(code,dvList);
        }
        return map;
    }

    @Override
    public List<DicValue> getValList() {
        return dicValueDao.getValList();
    }

    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        int count = dicValueDao.delete(ids);
        if(count != ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public List<String> getTypeCode() {
        return dicValueDao.getTypeCode();
    }

    @Override
    public boolean saveDicValue(DicValue dicValue) {
        boolean flag = true;
        int count = dicValueDao.save(dicValue);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public DicValue getDicValueById(String id) {
        return dicValueDao.getDicValueById(id);
    }

    @Override
    public boolean updateValue(DicValue dicValue) {
        boolean flag = true;
        int count = dicValueDao.update(dicValue);
        if (count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public List<DicType> getTypeList() {
        return dicTypeDao.getTypeList();
    }

    @Override
    public boolean deleteType(String[] codes) {
        boolean flag = true;
        int count = dicTypeDao.delete(codes);
        if (count != codes.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public DicType getDicTypeByCode(String code) {
        return dicTypeDao.getDicTypeByCode(code);
    }

    @Override
    public boolean saveDicType(DicType dicType) {
        boolean flag = true;
        int count = dicTypeDao.save(dicType);
        if (count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean updateType(DicType dicType) {
        boolean flag = true;
        int count = dicTypeDao.update(dicType);
        if (count != 1){
            flag = false;
        }
        return flag;
    }
}
