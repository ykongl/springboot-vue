package com.example.vueDemo.controller;

import com.alibaba.fastjson.JSON;
import com.example.vueDemo.bean.MainMenu;
import com.example.vueDemo.bean.User;
import com.example.vueDemo.dao.MenuDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * @author ykongl
 * @version 1.0
 */

@RestController
public class MenuController {
    @Autowired
    private MenuDao menuDao;

    @RequestMapping("/menus")
    public String getAllMenus(){
        System.out.println("访问成功");
        HashMap<String,Object> data = new HashMap<>();
        int status = 404;//错误404 成功200
        List<MainMenu> menus = menuDao.getMenus();
        if(menus!=null){
            data.put("menus",menus);
            data.put("flag",200);
        }else{
            data.put("flag",404);
        }
        String s = JSON.toJSONString(data);
        return s;

    }
}
