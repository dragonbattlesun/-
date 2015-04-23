//
//  Travel.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "Travel.h"

@implementation Travel
-(instancetype)initWithTitle:(NSString *)title andImagename:(NSString *)imagename andContent :(NSString *)content andLook:(NSString *)look andLike:(NSString *)like andReply:(NSString *)reply{
    self = [super init];
    if (self) {
        self.title = title;
        self.imagename = imagename;
        self.content =content;
        self.look = look;
        self.like = like;
        self.reply = reply;
    }
    return self;
}
@end
