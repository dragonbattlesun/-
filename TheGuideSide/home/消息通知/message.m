//
//  message.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "message.h"

@implementation message
-(instancetype)initWithDataMonth:(NSString *)time andDay:(NSString *)day andInform:(NSString *)inform{
    self = [super init];
    if (self) {
        self.time=time;
        self.inform =inform;
    }
    return self;
}
@end
