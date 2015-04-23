//
//  RoutTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/24.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "RoutTableViewCell.h"
#import "LabelWithLine.h"
@implementation RoutTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}
-(void)addView{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth -10, 120)];
    imageV.image = [UIImage imageNamed:@"banner"];
    [self.contentView addSubview:imageV];
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(5, 80, kScreenWidth-10, 40)];
    bjV.backgroundColor = [UIColor grayColor];
    bjV.alpha = 0.5;
    [self.contentView addSubview:bjV];
    
    
    
    
    double imageSize = 50;
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-60, 50, 50, 50)];
    imageV2.image = [UIImage imageNamed:@"bg2"];
    [self.contentView addSubview:imageV2];
    self.priceV = imageV2;
    //设置uiimageView为圆
    imageV2.layer.masksToBounds = YES;
    // 其實就是設定圓角，只是圓角的弧度剛好就是圖片尺寸的一半
    imageV2.layer.cornerRadius = imageSize / 2.0;
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 50, 25)];
    lab4.text = @"￥1599起";
    lab4.textColor =[UIColor whiteColor];
    lab4.font = [UIFont systemFontOfSize:11];
    [imageV2 addSubview:lab4];
    UIView *bjV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 25, 50, 0.5)];
    bjV2.backgroundColor = [UIColor whiteColor];
    [imageV2 addSubview:bjV2];
    
    LabelWithLine *lab3 = [LabelWithLine initLabelWithLineText:@"￥6300"];
    //WithFrame:CGRectMake(0, imageV2.height/2, 50, 20)];
    lab3.font = [UIFont systemFontOfSize:9];
    lab3.frame = CGRectMake(5, imageV2.height/2-0, 40, 15);
    //    lab3.text = @"￥6000";
    lab3.textColor = [UIColor whiteColor];
    lab3.textAlignment = NSTextAlignmentCenter;
    //    lab3.backgroundColor = [UIColor clearColor];
    //    lab3.textColor =[UIColor whiteColor];
    [imageV2 addSubview:lab3];
    
    
    
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5, 80, bjV.width-10, 20)];
    lab.text = @"泰国5晚7日升级超值游的顶顶顶顶顶";
    lab.textColor =[UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:lab];
    self.title = lab;
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 100, bjV.width-10, 20)];
    lab2.text = @"南京王菲逗贫是第三方的发生地方";
    lab2.textColor =[UIColor whiteColor];
    lab2.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:lab2];
    self.introduce = lab2;
    
}
@end
