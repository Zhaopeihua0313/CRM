package com.alex.crm.utils;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class JsonResult {

    private boolean success = true;
    private String msg;

    public void mark(String msg){
        this.success = false;
        this.msg = msg;
    }

}
