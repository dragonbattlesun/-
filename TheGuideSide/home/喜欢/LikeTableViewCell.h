//
//  LikeTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Like;
@interface LikeTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel * title ;
@property(nonatomic,strong) UILabel * content ;
@property(nonatomic,strong) UILabel * timeandfloor ;
@property(nonatomic,strong) UIImageView * imageV ;
-(void)setData:(Like *)like;
@end
