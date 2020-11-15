package com.zjl.crm.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
@Data
public class PageinationVO<T> {
    private int total;
    private List<T> dataList;
}
