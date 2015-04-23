//
//  TravelTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Travel;
@interface TravelTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel * title ;
@property(nonatomic,strong) UIImageView * imageV ;
@property(nonatomic,strong) UILabel * content ;
@property(nonatomic,strong) UILabel * look ;
@property(nonatomic,strong) UILabel * like ;
@property(nonatomic,strong) UILabel * reply ;
-(void)setData:(Travel *)space;

@end
