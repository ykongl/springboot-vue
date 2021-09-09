package com.example.vueDemo.bean;

import lombok.Data;

/**
 * @author ykongl
 * @version 1.0
 */
@Data
public class QueryInfo {
    private String query;//查询信息 username
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
}
