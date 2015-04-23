//
//  Order.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "Order.h"

@implementation Order
-(instancetype)initWithDataTime:(NSString *)time andTitle:(NSString *)title andPrice:(NSString *)price  andMoney:(NSString *)money andState:(NSString *)state{
    self = [super init];
    if (self) {
        self.time = time;
        self.title = title;
        self.money = money;
        self.state = state;
        self.price =price;
    }
    return self;
}
@end
