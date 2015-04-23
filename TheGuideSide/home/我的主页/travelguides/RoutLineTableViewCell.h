//
//  RoutLineTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendTravalModel.h"
@interface RoutLineTableViewCell : UITableViewCell

-(void)SetCellValue:(RecommendTravalModel *) model;

-(void)SetImageList:(NSString *)ImageURL;
@end
