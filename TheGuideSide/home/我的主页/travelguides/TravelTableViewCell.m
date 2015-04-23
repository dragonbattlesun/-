//
//  TravelTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "TravelTableViewCell.h"
#import "Travel.h"
@implementation TravelTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}
-(void)addView{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 50, 50)];
    imageV.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:imageV];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, kScreenWidth -70, 20)];
    lab.text = @"青海七日休闲游";
    //  lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:15];
    //    lab.numberOfLines = 0;
    //    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:lab];
    self.title = lab;
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, kScreenWidth  - 70, 40)];
    lab2.text = @"青海景区简介青海地方师傅师傅师傅。。。。";
    lab.textColor =[UIColor grayColor];
    lab2.font = [UIFont systemFontOfSize:14];
    lab2.numberOfLines = 0;
    lab2.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:lab2];
    self.content = lab2;
    
    
    
    NSArray *arr = [NSArray arrayWithObjects:@"ic_login_password",@"ic_login_password",@"ic_login_password", nil];
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(60+i*50, 70, 10, 10)];
        imageV.image = [UIImage imageNamed:[arr objectAtIndex:i]];
        [self.contentView addSubview:imageV];
    }
    
    for (int i = 0; i < 3; i ++) {
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(70+i*50, 70, 40, 10)];
        lab.text = @"8.6万";
        lab.tag = 1000+i;
        lab.textColor =[UIColor grayColor];
        lab.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:lab];
    }
    self.look = (UILabel *) [self viewWithTag:1000];
    self.like = (UILabel *) [self viewWithTag:1001];
    
    self.reply = (UILabel *) [self viewWithTag:1002];
    
}
-(void)setData:(Travel *)space{
    self.title.text = space.title;
    self.content.text =space.content;
    self.imageV.image = [UIImage imageNamed:space.imagename];
    self.look.text = space.look;
    self.like.text =space.like;
    self.reply.text = space.reply;
}
@end
