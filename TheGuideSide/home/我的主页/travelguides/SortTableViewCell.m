//
//  SortTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "SortTableViewCell.h"

@implementation SortTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}
-(void)addView{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 60)];
    lab.text = @"精品推荐";
    lab.textColor =[UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:lab];
    self.lab =lab;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 59, kScreenWidth, 1)];
    self.line =line;
    [self.contentView addSubview:line];
}

@end
