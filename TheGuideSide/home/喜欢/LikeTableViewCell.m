//
//  LikeTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "LikeTableViewCell.h"
#import "Like.h"
#import "UIImageView+WebCache.h"
@implementation LikeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
    imageV.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:imageV];

    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, kScreenWidth-190, 30)];
    lab.text = @"凡更是我的";
    //lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:15];
//    lab.numberOfLines = 0;
//    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:lab];
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(60, 35, kScreenWidth-80, 45)];
    lab2.text = @"风风光光嘎嘎嘎灌灌灌的奋斗奋斗奋斗奋斗奋斗的奋斗反反复复...";
    lab2.textColor =[UIColor grayColor];
    lab2.font = [UIFont systemFontOfSize:14];
        lab2.numberOfLines = 0;
        lab2.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:lab2];

    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth -110, 5, 100, 30)];
    lab3.text = @"2小时前  233楼";
    lab3.textColor =[UIColor grayColor];
    lab3.font = [UIFont systemFontOfSize:12];
    //    lab.numberOfLines = 0;
    //    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:lab3];

    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(15, 79, kScreenWidth-30, 1)];
    linev.backgroundColor = WJColor(241, 241, 241) ;
    [self.contentView addSubview:linev];
}
-(void)setData:(Like *)like{
    self.title.text = like.title;
    self.content.text = like.content;
    self.timeandfloor.text = [NSString stringWithFormat:@"%@   %@",like.time,like.floor];
   // self.imageV.image = [UIImage imageNamed:like.imagename];
    
    //SD
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:like.imagename] placeholderImage:[UIImage imageNamed:@"tou_03_jiazai"]  ];
}
@end
