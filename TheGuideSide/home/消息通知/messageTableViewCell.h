//
//  messageTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class message;
@interface messageTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel * time ;
@property(nonatomic,strong) UILabel * message ;

-(void)setData:(message *)message;
@end
