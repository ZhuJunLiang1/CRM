package com.zjl.crm.workbench.dao;

import com.zjl.crm.workbench.domain.CustomerRemark;

import java.util.List;

public interface CustomerRemarkDao {

    int save(CustomerRemark customerRemark);

    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    List<CustomerRemark> getRemarkListById(String customerId);

    int deleteById(String id);

    int updateRemark(CustomerRemark customerRemark);

    void deleteByCustomerId(String id);
}
