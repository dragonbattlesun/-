//
//  GuiderInfoModel.h
//  TheGuideSide
//
//  Created by sunjames on 15/4/16.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "JSONModel.h"

@interface GuiderInfoModel : JSONModel

@property(nonatomic,strong) NSString *Guid;

@property(nonatomic,assign) NSInteger GId;

@property(nonatomic,assign) NSInteger LoveCount;

@property(nonatomic,assign) NSInteger PraiseCount;

@property(nonatomic,assign) NSInteger OrdersCount;

@property(nonatomic,assign) NSInteger YuyueCount;

@property(nonatomic,assign) float TiCheng;

@property(nonatomic,assign) float Xj;

@property(nonatomic,assign) float Money;

@property(nonatomic,assign) float Star;

@property(nonatomic,strong) NSString *Image;

@property(nonatomic,strong) NSString *HeadImg;

@property(nonatomic,strong) NSString *PaiMing;

@property(nonatomic,strong) NSString *UserName;

@property(nonatomic,strong) NSString *TrueName;

@end
