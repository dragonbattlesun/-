//
//  orderTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#define Height 30.0f      // 竖间距

#import "orderTableViewCell.h"
#import "Order.h"
@implementation orderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 20)];
    label.text = @"景点门票";
    label.textColor =[UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    self.lab1 = label;
    
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(80, 0, 1, 20)];
    lineV.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineV];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 70, 20)];
    label2.text = @"已付款";
    label2.textColor =WJColor(127, 192, 155);
    label2.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label2];
    self.lab2 = label2;
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 300, 30)];
    label3.text = @"韩国济州岛4日游-京津接送，泰迪熊";
    label3.textColor =[UIColor grayColor];
    
    NSRange range;
    range = [label3.text rangeOfString:@"-"];
    if (range.location != NSNotFound) {
//     NSLog(@"found at location = %d, length = %d",range.location,range.length);
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label3.text];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,range.location+1)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(range.location+1,label3.text.length-range.location-1)];
        
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0] range:NSMakeRange(0,range.location+1)];

        
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0] range:NSMakeRange(range.location+1,label3.text.length-range.location-1)];

        
        label3.attributedText = str;
    }else{
        NSLog(@"Not Found");
    }
    
    
    
    label3.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:label3];
    self.lab3 = label3;
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 260, 20)];
    label4.text = @"2位成人  2015-05-01";
    label4.textColor =[UIColor grayColor];
    label4.font = [UIFont systemFontOfSize:14];
    [self addSubview:label4];
    self.lab4 = label4;
    
    UIView *lineV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, 1)];
    lineV2.backgroundColor = WJColor(233, 233, 233);
    [self.contentView addSubview:lineV2];
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 75, 60, 20)];
    label5.text = @"￥1888";
    label5.textColor =WJColor(197, 0, 0);
    label5.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:label5];
    
    self.lab5 = label5;
    
    
    
    UIButton *dustbinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dustbinBtn.frame = CGRectMake(kScreenWidth - 30, 80, 20, 15);
    [dustbinBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    [dustbinBtn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:dustbinBtn];
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 10)];
    bjV.backgroundColor = WJColor(242, 242, 242);
    [self.contentView addSubview:bjV];
}
-(void)setData:(Order *)order{
    self.lab1.text =order.time;
    self.lab2.text =order.title;
    self.lab3.text =order.price;
    self.lab4.text = order.money;
    self.lab5.text =order.state;
}
-(void)shanchu:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:sancButton:)]) {
        [self.delegate tableViewCell:self sancButton:button];
    }
}

@end
