package com.example.vueDemo.controller;

import com.alibaba.fastjson.JSON;
import com.example.vueDemo.bean.QueryInfo;
import com.example.vueDemo.bean.User;
import com.example.vueDemo.dao.UserDao;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * @author ykongl
 * @version 1.0
 */
@RestController
@RequestMapping("/User")
public class UserController {
    @Resource
    private UserDao userDao;

    /**
     * 获取用户列表
     * @param queryInfo
     * @return
     */

    @GetMapping("/list")
    public String getUserList(QueryInfo queryInfo){
        int number = userDao.getUserCounts(queryInfo.getQuery());//用户数量
        int pageStart = (queryInfo.getPageNum() - 1) * queryInfo.getPageSize();//分页
        List<User> allUser = userDao.getAllUser(queryInfo.getQuery(), pageStart, queryInfo.getPageSize());
        HashMap<String, Object> res = new HashMap<>();
        res.put("number",number);
        res.put("data",allUser);
        //转成String类型
        String s = JSON.toJSONString(res);
        return s;
    }

    /**
     * 修改用户状态
     * @param user
     * @return
     */
    @PostMapping("/updateState")
    public String UpdateState(User user){
        int i = userDao.updateState(user);
        return i > 0 ? "success" : "error";
    }

    /**
     * 添加用户
     * @param user
     * @return
     */
    @PostMapping("/insertUser")
    public String InsertUser(@RequestBody User user){
        user.setRole("普通用户");
        user.setState(false);
        int i = userDao.insertUser(user);
        return i > 0 ? "success":"error";
    }

    /**
     * 删除用户
     * @param user
     * @return
     */
    @PostMapping("/deleteUser")
    public String DeleteUser(User user){
        int i = userDao.deleteUser(user);
        return i > 0 ? "success" : "error";
    }

    @GetMapping("/userId")
    public User selectUserById(int id){
        User user = userDao.selectUserById(id);
        return user;
    }

    @PostMapping("/editUser")
    public String updateUser(@RequestBody User user){
        int i = userDao.updateUser(user);
        return i > 0 ? "success" : "error";
    }

}
