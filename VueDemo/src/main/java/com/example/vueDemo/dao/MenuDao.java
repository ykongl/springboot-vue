package com.example.vueDemo.dao;

import com.example.vueDemo.bean.MainMenu;

import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author ykongl
 * @version 1.0
 */
@Repository
public interface MenuDao {
    public List<MainMenu> getMenus();

}
