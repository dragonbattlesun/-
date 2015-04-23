//
//  AppointDetail.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointDetail : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *content;
-(instancetype)initWithTitle:(NSString *)title andContent:(NSString *)content;
@end
