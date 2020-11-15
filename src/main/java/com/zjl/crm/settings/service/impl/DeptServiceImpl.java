package com.zjl.crm.settings.service.impl;

import com.zjl.crm.settings.dao.DeptDao;
import com.zjl.crm.settings.domain.Dept;
import com.zjl.crm.settings.domain.User;
import com.zjl.crm.settings.service.DeptService;
import com.zjl.crm.vo.PageinationVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class DeptServiceImpl implements DeptService {
    @Resource
    private DeptDao deptDao;
    @Override
    public List<String> getDeptName(String name) {
        return deptDao.getDeptName(name);
    }

    @Override
    public String getDeptNoByName(String dept) {
        return deptDao.getDeptNoByName(dept);
    }

    @Override
    public PageinationVO pageList(Map<String, Object> map) {
        //取得total
        int total = deptDao.getTotal();
        //取得dataList 封装到vo 返回
        List<Dept> dataList = deptDao.getDeptList(map);
        PageinationVO<Dept> vo = new PageinationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    @Override
    public boolean save(Dept dept) {
        boolean flag = true;
        int count = deptDao.save(dept);
        if (count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean delete(String[] nos) {
        boolean flag = true;
        int count = deptDao.delete(nos);
        if (count != nos.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public Dept getDetailByNo(String no) {
        return deptDao.getDetailByNo(no);
    }

    @Override
    public boolean update(Dept dept) {
        boolean flag = true;
        int count = deptDao.update(dept);
        if (count != 1){
            flag = false;
        }
        return flag;
    }
}
