//
//  MethodDetailCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelGuideModel.h"
@interface MethodDetailCell : UITableViewCell
-(void)setCellModel:(TravelGuideModel*) model;

-(void)SetImageList:(NSString *)ImageURL DefaultIcon:(NSString*)DefaultIcon;

@end
