package com.whoiszxl.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * mybatis配置，开启mapper扫描与事务
 *
 * @author whoiszxl
 * @date 2021/7/12
 */
@Configuration
@MapperScan("com.whoiszxl.mapper")
public class MyBatisConfig {


}