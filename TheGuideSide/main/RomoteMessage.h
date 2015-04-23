//
//  Message.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/4/14.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RomoteMessage : NSObject
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *senderName;
@property(nonatomic,strong) NSString *text;

@end
