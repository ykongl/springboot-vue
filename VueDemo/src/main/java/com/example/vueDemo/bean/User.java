package com.example.vueDemo.bean;


import lombok.Data;

/**
 * @author ykongl
 * @version 1.0
 *
 * 用户实体
 */
 @Data
public class User {
    private int id;
    private String username;//用户名
    private String password;//密码
    private String email;//邮箱
    private String role;//角色
    private boolean state;//状态
    private String query;//查询信息 username
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int roleId;
    private boolean isVip;//是否是會員

}
