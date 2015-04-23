//
//  Space.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaceStatus : NSObject
@property(nonatomic,strong) NSString * date;
@property(nonatomic,strong) NSString  * imgUrls;
@property(nonatomic,strong) NSString * content;
-(instancetype)initWithData:(NSString *)Date andContent:(NSString *)content  ImageUrlArrs:(NSString *)ImageUrlArrs;
@end
