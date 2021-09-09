package com.example.vueDemo;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@MapperScan("com.example.vueDemo.dao")
@SpringBootApplication
public class VueDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(VueDemoApplication.class, args);
    }

}
