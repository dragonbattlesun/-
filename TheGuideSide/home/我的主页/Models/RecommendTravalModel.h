//
//  RecommendTravalModel.h
//  TheGuideSide
//
//  Created by sunjames on 15/4/9.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendTravalModel : NSObject

/**
 *  地址
 */
@property (nonatomic,strong) NSString *Adress;

/**
 *  目的地
 */
@property (nonatomic,strong) NSString *Bdress;

/**
 *  线路特色
 */
@property (nonatomic,strong) NSString *Characteristic;

/**
 *  审核状态
 */
@property (nonatomic,assign) NSInteger CheckStatus;

/**
 *  审核时间
 */
@property (nonatomic,strong) NSString *Checkdatetime;

/**
 *  创建时间
 */
@property (nonatomic,strong) NSString *CreateDate;

/**
 *  创建人
 */
@property (nonatomic,strong) NSString *CreateP;

/**
 *  标识
 */
@property (nonatomic,strong) NSString *CurrentGuid;

/**
 *  天数
 */
@property (nonatomic,assign) NSInteger Dnumnber;

/**
 *  机票价格
 */
@property (nonatomic,assign) NSDecimal FightPrice;

/**
 *  酒店价格
 */
@property (nonatomic,assign) NSDecimal HotelPrice;

/**
 *  ID
 */
@property (nonatomic,assign) NSInteger ID;

/**
 *  是否发票抬头
 */
@property (nonatomic,assign) NSInteger IFinvoice;
/**
 *  图片
 */
@property (nonatomic,strong) NSString *Image;

/**
 *  发票抬头
 */
@property (nonatomic,strong) NSString *InvoiceTitle;

/**
 *  费用需知
 */
@property (nonatomic,strong) NSString *Know;

/**
 *  标题
 */
@property (nonatomic,strong) NSString *MainTitle;

/**
 *  备注
 */
@property (nonatomic,strong) NSString *Mark;

/**
 *  备注2
 */
@property (nonatomic,strong) NSString *Mark2;

/**
 *  <#Description#>
 */
@property (nonatomic,strong) NSString *Mark3;

/**
 *  <#Description#>
 */
@property (nonatomic,strong) NSString *Mark4;

/**
 *  其他价格
 */
@property (nonatomic,assign) NSDecimal *OtherPrice;

/**
 *  产品编码
 */
@property (nonatomic,assign) NSInteger Pcode;

/**
 *  价格时间主见
 */
@property (nonatomic,assign) NSInteger PandD_ID;

/**
 *  报名人数
 */
@property (nonatomic,assign) NSInteger Pnumber;

/**
 *  价格
 */
@property (nonatomic,assign) NSDecimal Price;

/**
 *  团游类型
 */
@property (nonatomic,strong) NSString *QualityType;

/**
 *  副标题
 */
@property (nonatomic,strong) NSString *SubTitle;
/**
 *  旅行贴士
 */
@property (nonatomic,strong) NSString *Trip;
/**
 *  用户ID
 */
@property (nonatomic,assign) NSInteger UserID;
/**
 *  燕京价格
 */
@property (nonatomic,assign) NSDecimal YJPrice;

+(instancetype)initWithRecommendTraval:(NSInteger)ID MainTitle:(NSString*)MainTitle  ImageList:(NSString*)ImageList  CreateTime:(NSString*)CreateTime QualityType:(NSString*)QualityType;
@end



