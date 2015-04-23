//
//  UserComment.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserComment : NSObject
@property(nonatomic,strong)  NSString * imagename ;
@property(nonatomic,strong)  NSString * name ;
@property(nonatomic,strong)  NSString * time ;
@property(nonatomic,strong)  NSString * content ;
@property(nonatomic,strong)  NSString * score ;
@property(nonatomic,strong)  NSString * number ;
@property(nonatomic,strong) NSString *conment;
-(instancetype)initWithDataImage:(NSString *)image andName:(NSString *)name andTime:(NSString *)time andContent:(NSString *)content andSocre:(NSString *)socre andNumber:(NSString *)number andConment:(NSString *)conment;
@end
