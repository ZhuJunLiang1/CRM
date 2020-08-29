package com.zjl.crm.exception;

public class AccountErrorException extends LoginException{
    public AccountErrorException() {
    }

    public AccountErrorException(String message) {
        super(message);
    }
}
