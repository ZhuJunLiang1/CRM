package com.zjl.crm.workbench.service.impl;

import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.dao.NoticeDao;
import com.zjl.crm.workbench.domain.Notice;
import com.zjl.crm.workbench.service.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Resource
    NoticeDao noticeDao;

    @Override
    public HashMap<String, Object> save(Notice notice) {
        HashMap<String, Object> map = new HashMap<>();
        boolean flag = true;
        int count = noticeDao.save(notice);
        if (count != 1){
            flag = false;
        }
        map.put("success",flag);
        map.put("notice",notice);
        return map;
    }

    @Override
    public PageinationVO pageList(Map<String, Object> map) {
        int total = noticeDao.getTotal();
        List<Notice> dataList = noticeDao.getListByPage(map);
        PageinationVO<Notice> vo = new PageinationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    @Override
    public Map<String, Object> deleteById(String id) {
        Map<String,Object> map = new HashMap<>();
        boolean flag = true;
        int count = noticeDao.deleteById(id);
        if (count != 1){
            flag = false;
        }
        map.put("success",flag);
        return map;
    }
}
