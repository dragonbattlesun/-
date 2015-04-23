//
//  SceneIntr.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SceneModel : JSONModel

@property (nonatomic,assign) NSInteger ID;

@property (nonatomic,assign) NSInteger GuideID;

@property (nonatomic,assign) NSInteger ScenicID;

@property (nonatomic,strong) NSString *Personsign;

@property (nonatomic,assign) float Star;

@property (nonatomic,strong) NSString *HeadImg;

@property (nonatomic,strong) NSString *PicSrc;

@property (nonatomic,strong) NSString *Username;

@property (nonatomic,strong) NSString *TrueName;

@property (nonatomic,strong) NSString *URL;

@property (nonatomic,strong) NSString *Name;

@property (nonatomic,assign) float ScenicRating;

@property (nonatomic,assign) NSInteger PlayCount;

@property (nonatomic,assign) NSInteger LoveCount;

@property (nonatomic,assign) NSInteger PraiseCount;

@property (nonatomic,strong) NSString *Datetime;

@property (nonatomic,strong) NSString *Introduction;

@property (nonatomic,strong) NSString *CreateTime;

@end
