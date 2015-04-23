//
//  AppointDetailTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointDetail;
@interface AppointDetailTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
-(void)setData:(AppointDetail *)appointDetail;

@end
