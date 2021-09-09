package com.example.vueDemo.controller;

import com.alibaba.fastjson.JSON;
import com.example.vueDemo.bean.User;
import com.example.vueDemo.dao.UserDao;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;


/**
 * @author ykongl
 * @version 1.0
 */
@RestController
public class LoginController {
    @Resource
    private UserDao userDao;
    @RequestMapping("/login")
    public String login(@RequestBody User user){
        String flag = "error";
        User us = userDao.getUserByMassage(user.getUsername(), user.getPassword());
        HashMap<String,Object> res = new HashMap<>();
        if (us!=null){
            flag = "ok";
        }
        res.put("flag",flag);
        res.put("user",user);
        String res_json = JSON.toJSONString(res);
        return res_json;
    }

}
