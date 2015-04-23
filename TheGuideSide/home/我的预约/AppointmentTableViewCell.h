//
//  AppointmentTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Appoint;
@interface AppointmentTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel * date ;
@property(nonatomic,strong) UILabel * name ;
@property(nonatomic,strong) UILabel * age ;
@property(nonatomic,strong) UILabel * years ;
@property(nonatomic,strong) UILabel * money ;
@property(nonatomic,strong) UILabel * phone ;
@property(nonatomic,strong) UIButton  *  accept ;
@property(nonatomic,strong) UIButton  *  giveup ;
@property(nonatomic,strong) UIView * bjView ;

-(void)setData:(Appoint *)appoint;

@end
