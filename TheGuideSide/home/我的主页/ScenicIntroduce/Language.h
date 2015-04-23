//
//  Language.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/29.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject

@property(nonatomic,strong) NSString *descriptionStr;
@property(nonatomic,strong) NSString *Id;



@property(nonatomic,strong) NSString *guide;
@property(nonatomic,strong) NSString *user;
@property(nonatomic,strong) NSString *content;
-(instancetype)initWithGuide:(NSString *)guide andUser:(NSString *)user andContent:(NSString *)content;
@end
