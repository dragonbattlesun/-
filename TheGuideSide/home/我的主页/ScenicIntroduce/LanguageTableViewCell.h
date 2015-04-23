//
//  LanguageTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/29.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LanguageTableViewCell,Language;
@protocol LanguageTableViewCellDelegate <NSObject>
@optional;
-(void)tableViewCell:(LanguageTableViewCell *)cell andGuideButton:(UIButton *)button;

-(void)tableViewCell:(LanguageTableViewCell *)cell andUserButton:(UIButton *)button;

@end

@interface LanguageTableViewCell : UITableViewCell

@property(nonatomic,weak)id <LanguageTableViewCellDelegate>delegate;
-(void)setData:(Language *)language;
@end
