//
//  GuiderModel.h
//  TheGuideSide
//
//  Created by sunjames on 15/4/3.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuiderModel : NSObject

/**
 *  导游ID
 */
@property(nonatomic,assign) NSInteger GuiderID;

/**
 *  导游头像
 */
@property(nonatomic,copy) NSString *GuiderIconURL;

/**
 *  导游真是姓名
 */
@property(nonatomic,copy) NSString *TrueName;

/**
 *  导游证件号
 */
@property(nonatomic,copy) NSString *GuiderIDCard;
/**
 *  导游名称
 */
@property(nonatomic,copy) NSString *Guider;

/**
 *  语种
 */
@property(nonatomic,copy) NSString *GuiderLanguage;

/**
 *  地区
 */
@property(nonatomic,copy) NSString *GuiderArea;

/**
 *  导游性别 1 男 2 女 0 未知
 */
@property(nonatomic,assign) NSInteger GuiderGendel;


/**
 *  导游证件号
 */
@property(nonatomic,copy) NSString *GuiderIdentity;

/**
 *  手机号
 */
@property(nonatomic,assign) NSInteger GuiderMoblePhone;


/**
 *  出生日期
 */
@property(nonatomic,copy) NSString *GuiderBirthDate;


/**
 *  导游地址
 */
@property(nonatomic,copy) NSString *GuiderAddress;


/**
 *  个性签名
 */
@property(nonatomic,copy) NSString *GuiderSignature;

/**
 *  导服费
 */
@property(nonatomic,assign) float GuiderServiceFrees;


/**
 *  二维码
 */
@property(nonatomic,copy) NSString *GuiderQRCode;

/**
 *  意见反馈
 */
@property(nonatomic,copy) NSString *GuiderFeedBack;

/**
 *  导游星级
 */
@property(nonatomic,assign) float GuiderStar;


/**
 *  工作时间
 */
@property(nonatomic,copy) NSString *GuiderWorkDate;


/**
 *  工作年限
 */
@property(nonatomic,copy) NSString *GuiderExperience;


@property (nonatomic,assign) NSInteger Level_ID;

@property (nonatomic,assign) NSInteger RoleID;

@property(nonatomic,copy) NSString *RotaryFigureImage;

/**
 *  评论数量
 */
@property(nonatomic,assign) NSInteger LikeCount;

+(GuiderModel*)initWithGuider:(NSInteger)GuiderID GuiderIconURL:(NSString*)GuiderIconURL TrueName:(NSString*)TrueName
                 GuiderIDCard:(NSString*)GuiderIDCard Guider:(NSString*)Guider GuiderLanguage:(NSString*)GuiderLanguage
                   GuiderArea:(NSString*)GuiderArea GuiderGendel:(NSInteger)GuiderGendel GuiderIdentity:(NSString*)GuiderIdentity GuiderMoblePhone:(NSInteger)GuiderMoblePhone GuiderBirthDate:(NSDate*)GuiderBirthDate GuiderAddress:(NSString*)GuiderAddress GuiderSignature:(NSString*)GuiderSignature GuiderServiceFrees:(float)GuiderServiceFrees GuiderQRCode:(NSString*)GuiderQRCode GuiderFeedBack:(NSString*)GuiderFeedBack GuiderStar:(float)GuiderStar GuiderWorkDate:(NSDate*)GuiderWorkDate GuiderExperience:(NSInteger)GuiderExperience LikeCount:(NSInteger)LikeCount RotaryFigureImage:(NSString*)RotaryFigureImage Level_ID:(NSInteger)Level_ID ;
@end
