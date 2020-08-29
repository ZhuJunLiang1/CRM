package com.zjl.crm.workbench.web.controller;

import com.zjl.crm.settings.domain.User;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.*;
import com.zjl.crm.workbench.service.ContactsService;
import com.zjl.crm.workbench.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/workbench/customer")
public class CustomerController {
    @Resource
    private CustomerService customerService;
    @Resource
    private ContactsService contactsService;

    @RequestMapping("/pageList.do")
    @ResponseBody
    public Object pageList(Customer customer, Integer pageNo, Integer pageSize){
        Map<String,Object> map = new HashMap<>();
        Integer skipCount = (pageNo-1)*pageSize;
        map.put("customer",customer);
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        PageinationVO<Customer> vo = customerService.pageList(map);
        return vo;
    }
    @RequestMapping("/getUserList.do")
    @ResponseBody
    public List<User> getUserList(){
        List<User> userList = customerService.getUserList();
        return userList;
    }
    @RequestMapping("/save.do")
    @ResponseBody
    public Map<String,Object> save(Customer customer, HttpServletRequest request){
        //创建人 当前登录用户
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        customer.setId(UUIDUtil.getUUID());
        customer.setCreateTime(DateTimeUtil.getSysTime());
        customer.setCreateBy(createBy);
        boolean flag = customerService.save(customer);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/delete.do")
    @ResponseBody
    public Map<String,Object> delete(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = customerService.delete(ids);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/getUserListAndCustomer.do")
    @ResponseBody
    public Map<String,Object> getUserListAndCustomer(String id){
        Map<String,Object> map = customerService.getUserListAndCustomer(id);
        return map;
    }
    @RequestMapping("/update.do")
    @ResponseBody
    public Map<String,Object> update(Customer customer, HttpServletRequest request){
        //修改人 当前登录用户
        customer.setEditTime(DateTimeUtil.getSysTime());
        customer.setEditBy(((User)request.getSession().getAttribute("user")).getName());
        boolean flag = customerService.update(customer);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @RequestMapping("/detail.do")
    public String detail(String id,HttpServletRequest request){
        Customer customer = customerService.detail(id);
        request.setAttribute("customer",customer);
        return "/workbench/customer/detail.jsp";
    }
    @RequestMapping("/detail1.do")
    @ResponseBody
    public Customer detail1(String id){
        return customerService.detail(id);
    }
    @RequestMapping("/deleteById.do")
    @ResponseBody
    public Map<String,Object> deleteById(String id){
        boolean flag = customerService.deleteById(id);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/getRemarkListById.do")
    @ResponseBody
    public List<CustomerRemark> getRemarkListById(String customerId){
        List<CustomerRemark> remarkList = customerService.getRemarkListById(customerId);
        return remarkList;
    }
    @RequestMapping("/deleteRemark.do")
    @ResponseBody
    public Map<String,Object> deleteRemark(String id){
        boolean flag = customerService.deleteRemark(id);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/saveRemark.do")
    @ResponseBody
    public Map<String,Object> saveRemark(CustomerRemark customerRemark,HttpServletRequest request){
        customerRemark.setId(UUIDUtil.getUUID());
        customerRemark.setCreateTime(DateTimeUtil.getSysTime());
        customerRemark.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        customerRemark.setEditFlag("0");
        boolean flag = customerService.saveRemark(customerRemark);
        Map<String,Object> map = new HashMap<>();
        map.put("customerRemark",customerRemark);
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/updateRemark.do")
    @ResponseBody
    public Map<String,Object> updateRemark(CustomerRemark customerRemark,HttpServletRequest request){
        customerRemark.setEditTime(DateTimeUtil.getSysTime());
        customerRemark.setEditBy(((User)request.getSession().getAttribute("user")).getName());
        customerRemark.setEditFlag("1");
        Map<String,Object> map = new HashMap<>();
        boolean flag = customerService.updateRemark(customerRemark);
        map.put("success",flag);
        map.put("customerRemark",customerRemark);
        return map;
    }
    @RequestMapping("/getTranListByCustomerId.do")
    @ResponseBody
    public List<Tran> getTranListByCustomerId(String customerId,HttpServletRequest request){
        List<Tran> tranList = customerService.getTranListByCustomerId(customerId);
        Map<String,String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        for (Tran tran: tranList){
            tran.setPossibility(pMap.get(tran.getStage()));
        }
        return tranList;
    }
    @RequestMapping("/deleteTranById.do")
    @ResponseBody
    public Map<String,Object> deleteTranById(String id){
        boolean flag = customerService.deleteTranById(id);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/getContactsListByCustomerId.do")
    @ResponseBody
    public List<Contacts> getContactsListByCustomerId(String customerId){
        List<Contacts> contactsList = customerService.getContactsListByCustomerId(customerId);
        return contactsList;
    }
    @RequestMapping("/deleteContactById.do")
    @ResponseBody
    public Map<String,Object> deleteContactById(String id){
        boolean flag = customerService.deleteContactById(id);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/addContact.do")
    @ResponseBody
    public Map<String,Object> addContact(Contacts contacts,HttpServletRequest request){
        contacts.setId(UUIDUtil.getUUID());
        contacts.setCreateTime(DateTimeUtil.getSysTime());
        contacts.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        boolean flag = contactsService.addContact(contacts);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }
    @RequestMapping("/getCharts.do")
    @ResponseBody
    public Map<String ,Object> getCharts(){
        return customerService.getCharts();
    }
}
