//
//  Appoint.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "Appoint.h"

@implementation Appoint
-(instancetype)initWithDataName:(NSString *)name andDate:(NSString *)date andAge:(NSString *)age andYears:(NSString *)years andPhone:(NSString *)phone andMoney:(NSString *)money{
    self = [super init];
    if (self) {
        self.name = name;
        self.date = date;
        self.age = age;
        self.years = years;
        self.phone = phone;
        self.money = money;
    }
    return self;
}
@end
