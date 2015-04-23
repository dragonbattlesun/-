//
//  message.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface message : NSObject
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *inform;
-(instancetype)initWithDataMonth:(NSString *)month  andInform:(NSString *)inform;
@end
