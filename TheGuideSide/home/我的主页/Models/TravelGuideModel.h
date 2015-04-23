//
//  TravelGuideModel.h
//  TheGuideSide
//
//  Created by sunjames on 15/4/10.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelGuideModel : JSONModel

/**
 *  主键
 */
@property (nonatomic,assign) NSInteger ID;

/**
 *  标题
 */
@property (nonatomic,strong) NSString *Title;

/**
 *  图片
 */
@property (nonatomic,strong) NSString *Image;

/**
 *  备注
 */
@property (nonatomic,strong) NSString *Mark;

/**
 *  备注
 */
@property (nonatomic,assign) NSInteger Status;

/**
 *  导游ID
 */
@property (nonatomic,strong) NSString *GuideID;

/**
 *  创建时间
 */
@property (nonatomic,strong) NSString *CreateCreatetime;

/**
 *  创建时间
 */
@property (nonatomic,strong) NSString *CheckTime;

/**
 *  审核人ID
 */
@property (nonatomic,strong) NSString *SystemUserID;

/**
 *  状态
 */
@property (nonatomic,assign) NSInteger CheckStatus;

//+(instancetype)initWithRecommendTraval:(NSInteger)ID Title:(NSString*)Title  Mark:(NSString*)Mark  Image:(NSString*) Image;
@end
