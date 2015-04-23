//
//  orderTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class orderTableViewCell;
@protocol orderTableViewCellDelegate <NSObject>
@optional;
-(void)tableViewCell:(orderTableViewCell *)cell sancButton:(UIButton *)button;

@end


@class Order;
@interface orderTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel * lab1 ;
@property(nonatomic,strong) UILabel * lab2 ;
@property(nonatomic,strong) UILabel * lab3 ;
@property(nonatomic,strong) UILabel * lab4 ;
@property(nonatomic,strong) UILabel * lab5 ;
@property(nonatomic,weak)  id <orderTableViewCellDelegate> delegate;

-(void)setData:(Order *)order;
@end
