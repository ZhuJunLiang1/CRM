package com.zjl.crm.settings.web.controller;

import com.zjl.crm.settings.domain.DicType;
import com.zjl.crm.settings.domain.DicValue;
import com.zjl.crm.settings.service.DicService;
import com.zjl.crm.utils.UUIDUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/settings/dic")
public class DicController {
    @Resource
    DicService dicService;

    @RequestMapping(value = "/value/pageList.do",method = RequestMethod.GET)
    @ResponseBody
    public List<DicValue> valPageList(){
        return dicService.getValList();
    }

    @RequestMapping(value = "/value/delete.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> deleteDicValue(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = dicService.delete(ids);
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @RequestMapping(value = "/value/getTypeCode.do",method = RequestMethod.GET)
    @ResponseBody
    public List<String> getTypeCode(){
        return dicService.getTypeCode();
    }

    @RequestMapping(value = "/value/saveDicValue.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> saveDicValue(DicValue dicValue ){
        dicValue.setId(UUIDUtil.getUUID());
        boolean flag = dicService.saveDicValue(dicValue);
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @RequestMapping(value = "/value/edit.do",method = RequestMethod.GET)
    public ModelAndView editValue(String id){
        ModelAndView mv = new ModelAndView();
        DicValue dicValue = dicService.getDicValueById(id);
        mv.addObject("dicValue",dicValue);
        mv.setViewName("/workbench/settings/dictionary/value/edit.jsp");
        return mv;
    }
    @RequestMapping(value = "/value/update.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> updateValue(DicValue dicValue){
        Map<String,Boolean> map = new HashMap<>();
        boolean flag = dicService.updateValue(dicValue);
        map.put("success",flag);
        return map;
    }


    @RequestMapping(value = "/type/pageList.do",method = RequestMethod.GET)
    @ResponseBody
    public List<DicType> typePageList(){
        return dicService.getTypeList();
    }

    @RequestMapping(value = "/type/delete.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> deleteType(HttpServletRequest request){
        String codes[] = request.getParameterValues("code");
        boolean flag = dicService.deleteType(codes);
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @RequestMapping(value = "/type/edit.do",method = RequestMethod.GET)
    public ModelAndView editType(String code){
        ModelAndView mv = new ModelAndView();
        DicType dicType = dicService.getDicTypeByCode(code);
        mv.addObject("dicType",dicType);
        mv.setViewName("/workbench/settings/dictionary/type/edit.jsp");
        return mv;
    }
    @RequestMapping(value = "/type/saveDicType.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> saveDicType(DicType dicType ){
        boolean flag = dicService.saveDicType(dicType);
        Map<String,Boolean> map = new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @RequestMapping(value = "/type/update.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> updateType(DicType dicType){
        Map<String,Boolean> map = new HashMap<>();
        boolean flag = dicService.updateType(dicType);
        map.put("success",flag);
        return map;
    }
}
