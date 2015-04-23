//
//  AppointmentTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#define WJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define Height 20.0f
#import "AppointmentTableViewCell.h"
#import "Appoint.h"
@implementation AppointmentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = WJColor(241, 241, 241);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self addbjView];

        [self initView];
    }
    return self;
}

-(void)addbjView{
     UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 100)];
     self.bjView = bjV;
    [self.contentView addSubview:bjV];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bjV.width, bjV.height)];
    imageV.image =[UIImage imageNamed:@"yuyuebj"];
    [self.bjView addSubview:imageV];

}
- (void)initView{
    UILabel *appoint = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 60, 20)];
    appoint.text = @"预约时间";
    appoint.layer.borderWidth = 0.5;
    appoint.layer.borderColor = [WJColor(205, 205, 205) CGColor];
    appoint.layer.cornerRadius = 5;
    appoint.textColor =[UIColor grayColor];
    appoint.font = [UIFont systemFontOfSize:13];
    [     self.bjView addSubview:appoint];

    
    
    
    
    UILabel *years = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 150, Height)];
    years.text = @"2011/24/23--1313/34/34";
    years.textColor =[UIColor grayColor];
    years.font = [UIFont systemFontOfSize:13];
    [     self.bjView addSubview:years];
    
    self.years = years;
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(260, 0, 60, Height)];
    money.text = @"¥ 123";
    money.textColor =[UIColor grayColor];
    money.font = [UIFont systemFontOfSize:14];
    [     self.bjView addSubview:money];
    self.money = money;
    

    
    
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, 100, Height)];
    name.text = @"欧阳大鹏先生";
    name.textColor =[UIColor grayColor];
    name.font = [UIFont systemFontOfSize:14];
    [     self.bjView addSubview:name];
    self.name = name;
    
    UILabel *age = [[UILabel alloc]initWithFrame:CGRectMake(120, 35, 60, Height)];
    age.text = @"25岁";
    age.textColor =[UIColor grayColor];
    age.font = [UIFont systemFontOfSize:14];
    [     self.bjView addSubview:age];
    self.age = age;
    
    
    UILabel * phone = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 90, Height)];
    phone.text = @"132424353";
    phone.textColor =[UIColor grayColor];
    phone.numberOfLines = 0;
    phone.lineBreakMode =NSLineBreakByTruncatingMiddle;
    phone.font = [UIFont systemFontOfSize:14];
    [     self.bjView addSubview:phone];
    self.phone = phone;
    
    UILabel *date = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-140, 75, 80, Height)];
    date.text = @"04：33";
    date.textColor =[UIColor grayColor];
    date.font = [UIFont systemFontOfSize:14];
    [self.bjView addSubview:date];
    self.date = date;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-110, 47, 15, 15)];
    imageV.image = [UIImage imageNamed:@"shijian"];
    [self.bjView addSubview:imageV];
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(240, 45, 50, 20);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:WJColor(229, 84, 0) forState:UIControlStateNormal];
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    button.layer.borderColor  =[WJColor(229, 84, 0) CGColor];
   // button.backgroundColor =WJColor(51, 149, 243);
    button.layer.cornerRadius = 10;
    [button setTitle:@"接受" forState:UIControlStateNormal];
    [     self.bjView addSubview:button];
    self.accept =button;
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.layer.cornerRadius = 10;
    button2.titleLabel.font = [UIFont systemFontOfSize:13];

    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button2.layer.borderWidth = 1;
    button2.layer.cornerRadius = 10;
    button2.layer.borderColor  =[[UIColor grayColor] CGColor];
    button2.frame = CGRectMake(240,75, 50, 20);
    [button2 setTitle:@"放弃" forState:UIControlStateNormal];
    [     self.bjView addSubview:button2];
    self.giveup =button;
    
    
    
    
    
}
-(void)setData:(Appoint *)appoint{
    self.age.text = appoint.age;
    self.date.text =appoint.date;
    self.money.text =  appoint.money;
    self.phone.text =appoint.phone;
    self.name.text =appoint.name;
    self.years.text =appoint.years;
}

@end
