//
//  messageTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#define Height 70.0f      // 竖间距

#import "messageTableViewCell.h"
#import "message.h"
@implementation messageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView{
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 50, 50)];
    imageV.image = [UIImage imageNamed:@"xxtz"];
    [self.contentView addSubview:imageV];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, kScreenWidth - 90, 65)];
    label2.text = @"商商品标题商品标题商品商品标题商品标题商品标题商品标题品标题";
    label2.numberOfLines = 0;
    label2.lineBreakMode = NSLineBreakByWordWrapping;
    label2.textColor =[UIColor grayColor];
    label2.font = [UIFont systemFontOfSize:15];
    [self addSubview:label2];
    self.message = label2;

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 70, 150, 10)];
    label.text = @"2013-20-23  18:45";
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor =WJColor(176, 176, 176);
    label.font = [UIFont systemFontOfSize:13];
    self.time = label;
    [self.contentView addSubview:self.time];
    
    
   }
-(void)setData:(message *)message{
    
    self.time.text =message.time;
    self.message.text =message.inform;
}
@end
