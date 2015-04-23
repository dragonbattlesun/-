//
//  SpaceTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpaceStatus,SpaceTableViewCell;

@protocol SpaceTableViewCellDelegate <NSObject>
@optional
- (void)tableViewCell:(SpaceTableViewCell *)tableViewCell didBtnClick:(UIButton *)btn;
@end

@interface SpaceTableViewCell : UITableViewCell


@property(nonatomic,weak) id<SpaceTableViewCellDelegate> delegate ;
//@property(nonatomic,strong) SpaceFrame *statusFrame;
@end
