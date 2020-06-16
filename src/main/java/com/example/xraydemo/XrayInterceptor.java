package com.example.xraydemo;

import com.amazonaws.xray.spring.aop.AbstractXRayInterceptor;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class XrayInterceptor extends AbstractXRayInterceptor {
    @Override
    @Pointcut("@annotation(com.amazonaws.xray.spring.aop.XRayEnabled) || @within(com.amazonaws.xray.spring.aop.XRayEnabled)")
    public void xrayEnabledClasses() {}
}
