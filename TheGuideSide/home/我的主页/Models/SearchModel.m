//
//  SearchModel.m
//  TheGuideSide
//
//  Created by sunjames on 15/4/9.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

+(instancetype)initWithSearchModel:(NSInteger)SearchID SearchScenicName:(NSString*)SearchScenicName
{
    
    SearchModel *Model=[[SearchModel alloc] init];

        Model.SearchScenicID =SearchID;
        
        Model.SearchScenicName =SearchScenicName;
    
    
    return  Model;
}

@end
