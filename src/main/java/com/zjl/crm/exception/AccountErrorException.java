package com.zjl.crm.exception;

import javax.servlet.http.HttpServlet;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeSet;

public class AccountErrorException extends LoginException{
    public AccountErrorException() {
    }

    public AccountErrorException(String message) {
        super(message);
    }
}
