//
//  SceneIntrTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#import <UIKit/UIKit.h>




@class SceneModel;
@class CWStarRateView;
@class SceneIntrTableViewCell;

@protocol SceneIntrTableViewCellDelegate <NSObject>

@optional
-(void)tableViewCell:(SceneIntrTableViewCell *)cell  Player:(UIButton *)button ;

@end


@interface SceneIntrTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView * IconImage ;
@property(nonatomic,strong) UILabel * ScenicName ;
@property(nonatomic,strong) CWStarRateView * starRate;
@property(nonatomic,strong) UILabel * ScenicDesc ;
@property(nonatomic,strong) UILabel * PublishDate ;
@property(nonatomic,strong) UILabel * PlayCount ;
@property(nonatomic,strong) UILabel * LikeCount ;
@property(nonatomic,strong) UILabel * CommentCount ;
@property(nonatomic,strong) UILabel * PlayTime;
@property(nonatomic,strong) UIButton * PlayBegin;
@property(nonatomic,strong) UIImageView * SmallIcon;
@property(nonatomic,strong) UILabel *Mp3URL;

@property(nonatomic,weak)id<SceneIntrTableViewCellDelegate>delegate;
-(void)setData:(SceneModel *)Model;

- (void)configWithIcon:(NSString *)iconImageUrl;
- (void)configWithIconUseAnimate:(UIImage *)DownloadImage;
@end
