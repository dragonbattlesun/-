//
//  DefaultSingleton.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/4/2.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultSingleton : NSObject
+(instancetype)sharedInstance;


@property(nonatomic,strong) NSString *locationCity;

@end
