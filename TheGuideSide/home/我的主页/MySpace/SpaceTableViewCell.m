//
//  SpaceTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "SpaceTableViewCell.h"
#define kSpaceDateFont [UIFont systemFontOfSize:12]
#define kSpaceContentFont [UIFont systemFontOfSize:13]
#define kSpaceFullBtnFont [UIFont systemFontOfSize:13]
@interface SpaceTableViewCell ()
@property(nonatomic,weak) UIView * lineView ;
@property(nonatomic,weak) UILabel * dateLabel;
@property(nonatomic,weak) UIImageView * circleView;
@property(nonatomic,weak) UILabel * contentLabel;
@property(nonatomic,weak) UIButton * fullBtn ;
@property(nonatomic,weak) UIView * containImageView;
@end

@implementation SpaceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)addView{
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.textColor =[UIColor grayColor];
    dateLabel.font = kSpaceDateFont;
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    UIImageView *circleView = [[UIImageView alloc]init];
    circleView.image = [UIImage imageNamed:@"kongjian_yuandian"];
    [self.contentView addSubview:circleView];
    self.circleView = circleView;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = WJColor(43, 147, 248);
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.textColor =[UIColor grayColor];
    contentLabel.font = kSpaceContentFont;
    contentLabel.numberOfLines = 2;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;

    
    UIButton *fullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fullBtn setTitleColor:WJColor(0, 131, 226) forState:UIControlStateNormal];
    [fullBtn setTitle:@"全文" forState:UIControlStateNormal];
    fullBtn.titleLabel.font= kSpaceFullBtnFont;
    [self.contentView addSubview:fullBtn];
    self.fullBtn = fullBtn;
    [fullBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

}


-(void)layoutSubviews{
    self.lineView.frame = CGRectMake(35, 5, 1, self.bounds.size.height-5);
}

#pragma mark 全文点击
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didBtnClick:)]) {
        [self.delegate tableViewCell:self didBtnClick:btn];
    }
}

@end
