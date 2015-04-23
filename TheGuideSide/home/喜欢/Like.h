//
//  Like.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Like : NSObject
@property(nonatomic,strong) NSString  * imagename ;
@property(nonatomic,strong) NSString  * title ;

@property(nonatomic,strong) NSString  * content ;
@property(nonatomic,strong) NSString  * time ;
@property(nonatomic,strong) NSString  * floor ;
-(instancetype)initWithImagename:(NSString *)imagename andTitle:(NSString *)title andContent:(NSString *)content andTime:(NSString *)time andFloor:(NSString *)floor;
@end
