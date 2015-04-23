//
//  Space.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "SpaceStatus.h"

@implementation SpaceStatus
-(instancetype)initWithData:(NSString *)Date andContent:(NSString *)content  ImageUrlArrs:(NSString *)ImageUrlArrs{
    self = [super self];
    if (self) {
        
        self.date =[YjlyRequest GetDateTime:Date stringFormat:@"MM.dd"];
        self.content =content;
        self.imgUrls =ImageUrlArrs;
        
    }
    return self;
}





@end
