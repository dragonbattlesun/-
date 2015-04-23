//
//  AppointDetail.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "AppointDetail.h"

@implementation AppointDetail
-(instancetype)initWithTitle:(NSString *)title andContent:(NSString *)content{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
    }
    return self;
}

@end
