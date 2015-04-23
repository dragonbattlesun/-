//
//  userCommentTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWStarRateView;
@class UserComment;
@class userCommentTableViewCell;
@protocol userCommentTableViewCellDelegate <NSObject>

@optional
-(void)tableViewCell:(userCommentTableViewCell *)cell andButton:(UIButton *)button height:(CGFloat)height;
@end
@interface userCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)  UIImageView * imageV ;
@property(nonatomic,strong)  UILabel * name ;
@property(nonatomic,strong)  UILabel * time ;
@property(nonatomic,strong)  UILabel * content ;
@property(nonatomic,strong)  UILabel * score ;
@property(nonatomic,strong)  UILabel * number ;
@property(nonatomic,strong) UILabel *conmentlab;

@property(nonatomic,strong) CWStarRateView * starRateView ;
@property(nonatomic,weak)  id<userCommentTableViewCellDelegate> delegate;

-(void)setData:(UserComment *)userComment;

@end
