package com.example.vueDemo.dao;

import com.example.vueDemo.bean.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author ykongl
 * @version 1.0
 */
@Repository
public interface UserDao {
    /**
     * 登录
     * @param username
     * @param password
     * @return
     */
    public User getUserByMassage(@Param("username") String username,@Param("password") String password);

    /**
     * 获取用户列表
     * @param username
     * @param PageStart
     * @param pageSize
     * @return
     */
    public List<User> getAllUser(@Param("username")String username,@Param("pageStart") int PageStart,@Param("pageSize")int pageSize);
    /**
     * 获取所有的用户个数
     */
    public int getUserCounts(@Param("username")String username);

    /**
     * 修改用户状态
     */
    public int updateState(User user);

    /**
     * 添加用户
     */
    public int insertUser(User user);


    /**
     * 删除用户
     */
    public int deleteUser(User user);

    /**
     * 获取用户详情
     */
    public User selectUserById(int id);

    /**
     * 修改用户
     */
    public int updateUser(User user);


}
