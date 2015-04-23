//
//  Travel.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Travel : NSObject
@property(nonatomic,strong) NSString * title ;
@property(nonatomic,strong) NSString * imagename ;
@property(nonatomic,strong) NSString * content ;
@property(nonatomic,strong) NSString * look ;
@property(nonatomic,strong) NSString * like ;
@property(nonatomic,strong) NSString * reply ;
-(instancetype)initWithTitle:(NSString *)title andImagename:(NSString *)imagename andContent:(NSString *)content andLook:(NSString *)look andLike:(NSString *)like andReply:(NSString *)reply;
@end
