//
//  Like.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "Like.h"

@implementation Like
-(instancetype)initWithImagename:(NSString *)imagename andTitle:(NSString *)title andContent:(NSString *)content andTime:(NSString *)time andFloor:(NSString *)floor{
    self = [super init];
    if (self) {
        self.imagename =imagename;
        self.title = title;
        self.content =content;
        self.time =time;
        self.floor =floor;
    }
    return self;
}
@end
