//
//  LanguageTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/29.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#import <CoreText/CoreText.h>
#import "LanguageTableViewCell.h"
#import "Language.h"
#import "WPHotspotLabel.h"
#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"

@interface LanguageTableViewCell ()
@property(nonatomic,strong)  UIButton *guide;
@property(nonatomic,strong) UIButton *user;
@property(nonatomic,strong) UILabel *lab1;
//@property(nonatomic,strong) UILabel *content;
@property (weak, nonatomic)  WPHotspotLabel *content;


@end

@implementation LanguageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}
-(void)addView{
//    [NSString getHeightOfLabelText:self.guide lableWidth:<#(CGFloat)#> textFontSize:<#(CGFloat)#>]
    
    
//    UI *guide = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 20)];
//    guide.text = @"dddd";
//    guide.textColor =[UIColor blueColor];
//    guide.font = [UIFont systemFontOfSize:14];
//    guide.numberOfLines = 0;
//    guide.lineBreakMode = NSLineBreakByWordWrapping;
//    [self.contentView addSubview:guide];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(10, 0, 40, 20);
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button setTitle:@"小众" forState:UIControlStateNormal];
//    button.titleLabel.font=[UIFont systemFontOfSize:14];
//    [button addTarget:self action:@selector(guide:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:button];
//    self.guide = button;
//    
//    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(10, 0, 40, 20);
//    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button2 setTitle:@"小xin" forState:UIControlStateNormal];
//    button2.titleLabel.font=[UIFont systemFontOfSize:14];
//    
//    [button2 addTarget:self action:@selector(user:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:button2];
//    self.user =button2;
//    
//    
//    
//
//    UILabel *lab = [[UILabel alloc]init];
//    lab.text = @"回复：";
//    lab.textColor =[UIColor grayColor];
//    lab.font = [UIFont systemFontOfSize:14];
//    [self.contentView addSubview:lab];
//    self.lab1 = lab;
//    
//    
//    UILabel *content = [[UILabel alloc]init];
//    content.text = @"dddde33";
//    content.textColor =[UIColor grayColor];
//    content.font = [UIFont systemFontOfSize:14];
//    content.numberOfLines = 0;
//    content.lineBreakMode = NSLineBreakByWordWrapping;
//    [self.contentView addSubview:content];
//    self.content = content;
    
  

    
    WPHotspotLabel *lab = [[WPHotspotLabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 50)];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
//    lab.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:lab];
    self.content =lab;
    
}


-(void)guideAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:andGuideButton:)]) {
        [self.delegate tableViewCell:self andGuideButton:button];
    }
}
-(void)userAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:andUserButton:)]) {
        [self.delegate tableViewCell:self andUserButton:button];
    }
}

-(void)setData:(Language *)language{
   
 
NSString *allString  = @"";
    if (language.guide.length>0&&language.user.length>0 ) { //显示导游名和用户名
        
     allString = [NSString stringWithFormat:@"<help>%@</help> 回复 <settings>%@</settings> :%@]",language.guide,language.user,language.content];
        
    }else if(language.guide.length>0&&language.user.length == 0) {//只显示导游名
        
    allString = [NSString stringWithFormat:@"<help>%@</help>:%@]",language.guide,language.content];
        

        
    }else if(language.guide.length  ==0 && language.user.length>0){//只显示用户名
        allString = [NSString stringWithFormat:@"<settings>%@</settings> :%@]",language.user,language.content];

        
    }
    NSDictionary* style3 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
                             @"help":[WPAttributedStyleAction styledActionWithAction:^{
                                 NSLog(@"Help action");
                                 [self guideAction:nil];
                             }],
                             @"settings":[WPAttributedStyleAction styledActionWithAction:^{
                                 NSLog(@"Settings action");
                                 [self userAction:nil];
                             }],
                             @"link": WJColor(53, 154, 244)};
    
    
   // self.content.attributedText = [@"Tap <help>王风景</help> to show help or <settings>通天塔</settings> to show settings" attributedStringWithStyleBook:style3];

    self.content.attributedText = [language.content attributedStringWithStyleBook:style3];
    
    
    CGFloat height =[NSString getHeightOfLabelText:language.content lableWidth:kScreenWidth-20 textFontSize:14];
    self.content.frame = CGRectMake(10, 0, kScreenWidth-20, height);
//    [self.guide setTitle:language.guide forState:UIControlStateNormal];
//    [self.user setTitle:language.user forState:UIControlStateNormal];
//    
//    CGSize Gsize =[self returnSizeWithText:language.guide maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:[UIFont systemFontOfSize:14]];
//    
//    
//    self.guide.frame =CGRectMake(10, 0, Gsize.width, 30);
//
//    CGSize size =[self returnSizeWithText:@"回复:" maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:[UIFont systemFontOfSize:14]];
//    self.lab1.text = @"回复：";
//    self.lab1.frame=CGRectMake(CGRectGetMidX(self.guide.frame)+5 , 0, size.width, 30);
//    NSLog(@"-------cc-----%@",NSStringFromCGRect(self.guide.frame));
//    
//    CGSize Usize =[self returnSizeWithText:language.user maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:[UIFont systemFontOfSize:14]];
//    self.user.frame  =CGRectMake(CGRectGetMidX(self.lab1.frame)+5, 0, Usize.width, 30);
//    
//    
//   CGFloat height = [NSString getHeightOfLabelText:self.content.text lableWidth:kScreenWidth-20 textFontSize:14];
//    self.content.frame = CGRectMake(10, 20, kScreenWidth -20 , height);
//   
    
}


@end
