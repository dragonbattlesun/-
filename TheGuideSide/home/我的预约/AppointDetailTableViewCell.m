//
//  AppointDetailTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "AppointDetailTableViewCell.h"
#import "AppointDetail.h"
@implementation AppointDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // self.backgroundColor = WJColor(241, 241, 241);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addbjView];
        
    }
    return self;
}
-(void)addbjView{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, (kScreenWidth-20)/2, 50)];
    lab.text = @"";
   // lab.backgroundColor = [UIColor redColor];
    //lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:15];
    self.lab1 = lab;
    [self.contentView addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, (kScreenWidth-60)/2, 50)];
    lab1.text = @"";
    lab1.textAlignment = NSTextAlignmentRight;
    //lab.textColor =[UIColor <#lab#>];
    lab1.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:lab1];
    self.lab2 = lab1;

}
-(void)setData :(AppointDetail *)appointDetail{
    self.lab1.text = appointDetail.title;
    self.lab2.text = appointDetail.content;
}
@end
