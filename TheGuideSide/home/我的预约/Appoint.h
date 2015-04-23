//
//  Appoint.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appoint : NSObject
@property(nonatomic,strong) NSString * date ;
@property(nonatomic,strong) NSString * name ;
@property(nonatomic,strong) NSString * age ;
@property(nonatomic,strong) NSString * years ;
@property(nonatomic,strong) NSString * phone ;
@property(nonatomic,strong) NSString * money ;
-(instancetype)initWithDataName:(NSString *)name andDate:(NSString *)date andAge:(NSString *)age andYears:(NSString *)years andPhone:(NSString *)phone andMoney:(NSString *)money;
@end
