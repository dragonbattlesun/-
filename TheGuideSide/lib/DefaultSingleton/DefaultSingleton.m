//
//  DefaultSingleton.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/4/2.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "DefaultSingleton.h"

@implementation DefaultSingleton
static id _instance;

/**
 *alloc 方法内部会调用这个方法  因为它位于最底层
 */
+(id)allocWithZone:(struct _NSZone *)zone{
    if (_instance==nil) {//防止频繁加锁
        
        @synchronized(self){
            if (_instance == nil) {//防止创建多次
                _instance=[super allocWithZone:zone];//调用super方法分配内存
            }
            
        }
        
    }
    return _instance;
}

+(instancetype)sharedInstance{
    if (_instance==nil) {//防止频繁加锁
        @synchronized(self){
            if (_instance == nil) {//防止创建多次
                _instance=[[self alloc]init];
            }
            
        }
        
    }
    return _instance;
    
    //    return [[self alloc]init];
    
}
//copy 有可能会产生新的对象
//copy 方法内部会调用copyWithZone:

-(id)copyWithZone:(NSZone *)zone{
    return _instance;
    
}

-(NSString *)locationCity{
    return @"北京市";
}
@end
