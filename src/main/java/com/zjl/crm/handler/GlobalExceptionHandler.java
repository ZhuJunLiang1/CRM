package com.zjl.crm.handler;

import com.zjl.crm.exception.AccountErrorException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionHandler {
//    @ExceptionHandler(value = AccountErrorException.class)
//    public ModelAndView loginException(Exception ex){
//        ModelAndView mv = new ModelAndView();
//        return mv;
//    }
}
