package com.example.vueDemo.controller;

import com.alibaba.fastjson.JSON;
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
     * @param user
     * @return
     */

    @GetMapping("/list")
    public String getUserList(User user){
        int number = userDao.getUserCounts(user.getQuery());//用户数量
        int pageStart = (user.getPageNum() - 1) * user.getPageSize();//分页
        List<User> allUser = userDao.getAllUser(user.getUsername(),pageStart,user.getPageSize());
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

    /**
     * 詳情
     * @param user
     * @return
     */
    @GetMapping("/userId")
    public User selectUserById(User user){
        User user1 = userDao.selectUserById(user);
        return user1;
    }

    /**
     * 保存更新
     * @param user
     * @return
     */
    @PostMapping("/editUser")
    public String updateUser(@RequestBody User user){
        int i = userDao.updateUser(user);
        return i > 0 ? "success" : "error";
    }

    /**
     * 角色下拉框
     * @param user
     * @return
     */
    @GetMapping("/role")
    public String selectRole(User user){
        List<User> users = userDao.selectRole(user);
        HashMap<String, Object> res = new HashMap<>();
        res.put("data",users);
        String s = JSON.toJSONString(res);
        return s;
    }

}
