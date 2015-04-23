//
//  GuiderModel.m
//  TheGuideSide
//
//  Created by sunjames on 15/4/3.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "GuiderModel.h"

@implementation GuiderModel

+(GuiderModel*)initWithGuider:(NSInteger)GuiderID GuiderIconURL:(NSString*)GuiderIconURL TrueName:(NSString*)TrueName
        GuiderIDCard:(NSString*)GuiderIDCard Guider:(NSString*)Guider GuiderLanguage:(NSString*)GuiderLanguage
                   GuiderArea:(NSString*)GuiderArea GuiderGendel:(NSInteger)GuiderGendel GuiderIdentity:(NSString*)GuiderIdentity GuiderMoblePhone:(NSInteger)GuiderMoblePhone GuiderBirthDate:(NSString*)GuiderBirthDate GuiderAddress:(NSString*)GuiderAddress GuiderSignature:(NSString*)GuiderSignature GuiderServiceFrees:(float)GuiderServiceFrees GuiderQRCode:(NSString*)GuiderQRCode GuiderFeedBack:(NSString*)GuiderFeedBack GuiderStar:(float)GuiderStar GuiderWorkDate:(NSString*)GuiderWorkDate GuiderExperience:(NSInteger)GuiderExperience LikeCount:(NSInteger)LikeCount RotaryFigureImage:(NSString*)RotaryFigureImage Level_ID:(NSInteger)Level_ID
{
    GuiderModel *Model=[[GuiderModel alloc] init];
    
    Model.GuiderID=GuiderID;
    
    Model.GuiderIconURL=GuiderIconURL;
    
    Model.TrueName=[TrueName  isEqualToString:@""] ?@"未命名":TrueName;
    
    Model.GuiderIDCard=GuiderIDCard;
    
    Model.Guider=Guider;
    
    Model.GuiderLanguage=GuiderLanguage;
    
    Model.GuiderArea=GuiderArea;
    
    Model.GuiderGendel=GuiderGendel;
    
    Model.GuiderIdentity=GuiderIdentity;
    
    Model.GuiderMoblePhone=GuiderMoblePhone;
    
    Model.GuiderBirthDate=GuiderBirthDate;
    
    Model.GuiderAddress=GuiderAddress;
    
    Model.GuiderSignature=GuiderSignature;
    
    Model.GuiderServiceFrees=GuiderServiceFrees;
    
    Model.GuiderQRCode=GuiderQRCode;
    
    Model.GuiderFeedBack=GuiderFeedBack;
    
    Model.GuiderStar=GuiderStar;
    
    Model.GuiderWorkDate=GuiderWorkDate;
    
    Model.GuiderExperience=[YjlyRequest compareCurrentTime:GuiderWorkDate IsSub:YES];
    
    Model.LikeCount=LikeCount;
    
    Model.RotaryFigureImage = RotaryFigureImage;
    
    Model.Level_ID = Level_ID;
    
    return Model;
}



@end
