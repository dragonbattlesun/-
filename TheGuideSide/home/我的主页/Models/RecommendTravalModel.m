//
//  RecommendTravalModel.m
//  TheGuideSide
//
//  Created by sunjames on 15/4/9.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "RecommendTravalModel.h"

@implementation RecommendTravalModel

+(instancetype)initWithRecommendTraval:(NSInteger)ID MainTitle:(NSString*)MainTitle ImageList:(NSString*)ImageList CreateTime:(NSString*)CreateTime QualityType:(NSString*)QualityType
{
    RecommendTravalModel *RecommendModel=[[RecommendTravalModel alloc] init];
   
    
    RecommendModel.ID =ID;
    
    RecommendModel.MainTitle = MainTitle;

    RecommendModel.Image = ImageList;
    RecommendModel.QualityType =QualityType;
    
    RecommendModel.CreateDate =[YjlyRequest GetDateTime:CreateTime stringFormat:@"MM.dd"];
    
    return RecommendModel; 
}

@end
