//
//  Order.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
@property(nonatomic,strong) NSString * time ;
@property(nonatomic,strong) NSString * title ;
@property(nonatomic,strong) NSString * money ;
@property(nonatomic,strong) NSString * state ;
@property(nonatomic,strong) NSString * price ;

-(instancetype)initWithDataTime:(NSString *)time andTitle:(NSString *)title andPrice:(NSString *)price andMoney:(NSString *)money andState:(NSString *)state;
@end
