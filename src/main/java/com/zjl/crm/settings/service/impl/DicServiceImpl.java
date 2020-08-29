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
}
