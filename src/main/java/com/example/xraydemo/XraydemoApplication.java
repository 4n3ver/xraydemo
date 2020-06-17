package com.example.xraydemo;

import com.amazonaws.xray.javax.servlet.AWSXRayServletFilter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.core.Ordered;

import javax.servlet.Filter;

@SpringBootApplication
public class XraydemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(XraydemoApplication.class, args);
    }

    @Bean
    public FilterRegistrationBean<Filter> xrayFilter() {
        FilterRegistrationBean<Filter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new AWSXRayServletFilter("test"));
        registrationBean.setOrder(Ordered.HIGHEST_PRECEDENCE);
        registrationBean.addUrlPatterns("/*");
        return registrationBean;
    }

}
