package com.example.vueDemo.bean;

import lombok.Data;

import java.util.List;

/**
 * @author ykongl
 * @version 1.0
 * 主导航
 */
@Data
public class MainMenu {
    private int id;
    private String title;//标题
    private String path;
    private List<SubMenu> sList;//分支导航

}
