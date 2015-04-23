//
//  userCommentTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//



#import "userCommentTableViewCell.h"
#import "UserComment.h"
#import "CWStarRateView.h"

@interface userCommentTableViewCell ()
@property(nonatomic,strong)  UILabel *label5;
@property(nonatomic,strong) UIButton *messagebutton;


@end
@implementation userCommentTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
    imageV.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:imageV];
    self.imageV = imageV;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 80, 30)];
    label.text = @"多啦A梦";
    label.textColor =WJColor(114, 112, 112);
    label.font = [UIFont boldSystemFontOfSize:15 ];
    [self.contentView addSubview:label];
    self.name =label;
//    label.numberOfLines = 0;
//    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(170, 5, 100, 30)];
    label2.text = @"2015年1月26日";
    label2.textColor =[UIColor grayColor  ];
    label2.font = [UIFont systemFontOfSize:14 ];
    [self.contentView addSubview:label2];
    self.time = label2;
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, kScreenWidth -70, 80)];
    label3.text = @"这才的方式发生的方式等丰富的非师范生DVD深V的vvvvfdfsfsfdfef对方的答复。";
    label3.textColor =[UIColor grayColor  ];
    label3.numberOfLines = 0;
    label3.lineBreakMode = NSLineBreakByWordWrapping;
    label3.font = [UIFont systemFontOfSize:14 ];
    [self.contentView addSubview:label3];
    self.content =label3;
    
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(70, 105, 40, 20)];
    label5.text = @"评分:";
    label5.textColor =WJColor(114, 112, 112);
    label5.font = [UIFont systemFontOfSize:14 ];
    [self.contentView addSubview:label5];
    self.label5 = label5;
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(110, 105, 40, 20)];
    label4.text = @"好评";
    label4.textColor =WJColor(232, 94, 96);
    label4.font = [UIFont systemFontOfSize:14 ];
    [self.contentView addSubview:label4];
    self.score = label4;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-50, 115, 15, 15);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:@"plhui_@3x"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"pllan_@3x"] forState:UIControlStateSelected];
    button.selected  =NO;
    [button addTarget:self action:@selector(reply:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    self.messagebutton = button;
    
//    
//    UIButton *messagebutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    messagebutton.frame = CGRectMake(kScreenWidth, 0, 50, 20);
//    [messagebutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    
//    [messagebutton setImage:[UIImage imageNamed:@"xingxing_08"] forState:UIControlStateNormal];
//    
//    [messagebutton addTarget:self action:@selector(messagebutton) forControlEvents:UIControlEventTouchUpInside];
//    
//    //星星
//    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(110, 115, 60, 20) numberOfStars:5 imageName:@"b27_icon_star_yellow@2x"];
//    //    self.starRateView.scorePercent = 0.3;
//    self.starRateView.allowIncompleteStar = YES;
//    // self.starRateView.hasAnimation = YES;
//    [self.contentView addSubview:self.starRateView];
//    self.starRateView.scorePercent=1.0;
//
    
    UILabel *conmentlab = [[UILabel alloc]init];
     conmentlab.textColor =[UIColor grayColor];
    
    conmentlab.backgroundColor = WJColor(240, 240, 240);
    conmentlab.font = [UIFont systemFontOfSize:14];
    conmentlab.numberOfLines = 0;
    conmentlab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:conmentlab];
    self.conmentlab= conmentlab;
    
    
   
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(70, 135, 190, 20)];
    label6.text = @"订单编号：123333333";
    label6.textColor =WJColor(168, 167, 167);
    label6.font = [UIFont systemFontOfSize:14 ];
    [self.contentView addSubview:label6];
    self.number = label6;


}
-(void)reply:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:andButton: height:)]) {
        [self.delegate tableViewCell:self andButton:button height:CGRectGetMaxY(self.label5.frame)];
    }
}
//-(void)messagebutton{
//    
//}
-(void)setData:(UserComment *)userComment{
    [self.imageV setImage:[UIImage imageNamed:userComment.imagename]];
    self.name.text = userComment.name;
    self.time.text = userComment.time;
    self.content.text =userComment.content;
    self.score.text =userComment.score;
    
    
    if ([userComment.score isEqualToString:@"好评"]) {
        self.score.textColor = [UIColor redColor];
    }else{
        self.score.textColor = WJColor(93, 162, 243);

    }
    self.number.text = userComment.number;
    
    
    NSLog(@"---11--%@",userComment.conment);
    
    NSRange range =[userComment.conment rangeOfString:@":"];
    if ([userComment.conment rangeOfString:@":"].location != NSNotFound) {
        NSLog(@"这个字符串中有:");
        NSLog(@"%@",NSStringFromRange(range));
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:userComment.conment];
        [str addAttribute:NSForegroundColorAttributeName value:WJColor(93, 162, 243) range:NSMakeRange(0,range.location)];
        self.conmentlab.attributedText = str;

    }
    

    
    CGFloat height1=[NSString getHeightOfLabelText:self.content.text lableWidth:kScreenWidth-80 textFontSize:14];
    
    self.content.frame = CGRectMake(70, 35, kScreenWidth-80, height1);
    
    self.label5.frame = CGRectMake(70, CGRectGetMaxY(self.content.frame), 40, 20);
    self.score.frame = CGRectMake(110, CGRectGetMaxY(self.content.frame), 40, 20);
 
    if (userComment.conment.length>0) {
        self.conmentlab.hidden  = NO;

    }else{
        self.conmentlab.text = @"";
        self.conmentlab.hidden = YES;
    }
    

    CGFloat height=[NSString getHeightOfLabelText:self.conmentlab.text lableWidth:kScreenWidth-80 textFontSize:14];
    self.conmentlab.frame = CGRectMake(70, CGRectGetMaxY(self.score.frame)+10, kScreenWidth - 80, height);
    self.number.frame =CGRectMake(70, CGRectGetMaxY(self.conmentlab.frame)+10, 190, 20);
 
    self.messagebutton.frame = CGRectMake(kScreenWidth-50,  CGRectGetMaxY(self.content.frame), 15, 15);
    
    NSLog(@"-------1--1-1--1--%@",NSStringFromCGRect(self.messagebutton.frame));
    NSLog(@"-------1--1-1--1--%@",NSStringFromCGRect(self.conmentlab.frame));

}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//   }
@end
