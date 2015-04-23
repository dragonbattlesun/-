//
//  SearchModel.h
//  TheGuideSide
//
//  Created by sunjames on 15/4/9.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic,strong) NSString *SearchScenicName;

@property (nonatomic,assign) NSInteger SearchScenicID;

+(instancetype)initWithSearchModel:(NSInteger)SearchID SearchScenicName:(NSString*)SearchScenicName;
@end
