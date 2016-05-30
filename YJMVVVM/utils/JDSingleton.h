//
//  JDSingleton.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/11/27.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#ifndef JDSingleton_h
#define JDSingleton_h

#pragma mark 接口.h中的定义
//由于宏定义里有需要替换的内容所以定义一个变量className
//##用于分割、连接字符串
#define singleton_interface(className) +(className *)shared##className;

#pragma mark 实现.m
//\在代码中用于连接宏定义,以实现多行定义
#define singleton_implementation(className) \
static className *_instance;\
+(id)shared##className{\
if(!_instance){\
_instance=[[self alloc]init];\
}\
return _instance;\
}\
+(id)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t dispatchOnce;\
dispatch_once(&dispatchOnce, ^{\
_instance=[super allocWithZone:zone];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{return self;}
#endif
