package com.zjl.crm.workbench.web.controller;

import com.zjl.crm.settings.domain.User;
import com.zjl.crm.utils.DateTimeUtil;
import com.zjl.crm.utils.UUIDUtil;
import com.zjl.crm.vo.PageinationVO;
import com.zjl.crm.workbench.domain.Notice;
import com.zjl.crm.workbench.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@SuppressWarnings("unchecked")
@RestController
@RequestMapping("workbench/notice")
public class NoticeController {
    @Autowired
    NoticeService noticeService;

    @GetMapping("/pageList.do")
    public PageinationVO<Notice> pageList(Integer pageNo, Integer pageSize){
        Map<String,Object> map = new HashMap<>();
        Integer skipCount = (pageNo-1)*pageSize;
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        PageinationVO vo = noticeService.pageList(map);
        return vo;
    }

    @PostMapping("/saveNotice.do")
    public HashMap<String,Object> saveRemark(HttpServletRequest request, String noteContent) {
        Notice notice = new Notice();
        notice.setId(UUIDUtil.getUUID());
        notice.setCreateTime(DateTimeUtil.getSysTime());
        notice.setNoteContent(noteContent);
        notice.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        return noticeService.save(notice);
    }
    @PostMapping("/delete.do")
    public Map<String,Object> delete(String id){
        return noticeService.deleteById(id);
    }
}
