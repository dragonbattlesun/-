//
//  DetailMethodViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "DetailMethodViewController.h"
#import "NSString+AutoHeight.h"
@interface DetailMethodViewController ()
@property(nonatomic,strong)  UIScrollView *bjScro;
@property(nonatomic,strong) UILabel *GuiderTitle;

@property(nonatomic,strong) UILabel *GuiderContent;

@property(nonatomic,strong) UIImage *GuiderImage;

@end

@implementation DetailMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"旅游攻略";
    
    UIScrollView *bjScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 900)];
    bjScro.contentSize = CGSizeMake(kScreenWidth, 1000);
    bjScro.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bjScro];
    self.bjScro= bjScro;
    
#pragma  Title begin
    _GuiderTitle= [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 20)];
    [_GuiderTitle setFont:Font_15_Weight];
    [_GuiderTitle setText:_traveModel.Title];
    [bjScro addSubview:_GuiderTitle];
    
#pragma  Title end
    
    
#pragma  Content begin
    _GuiderContent = [[UILabel alloc]initWithFrame:CGRectMake(10, _GuiderTitle.frame.origin.y+_GuiderTitle.frame.size.height +10, kScreenWidth-20, 20)];
    
    NSMutableParagraphStyle  * ContentParagrephStyle = [[NSMutableParagraphStyle alloc] init];
    ContentParagrephStyle.firstLineHeadIndent = 30;
    ContentParagrephStyle.lineSpacing = 3;//行距
    [ContentParagrephStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    
    NSMutableDictionary  *attribute = [NSMutableDictionary dictionary];
    
    [attribute setObject:Font_15_Weight forKey:NSFontAttributeName];
    [attribute setValue:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [attribute setValue:_ParagrephStyle forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString  *ContentmutableAttr=[[NSMutableAttributedString alloc] initWithString:_traveModel.Mark attributes:attribute];
    
    [_GuiderContent setAttributedText:ContentmutableAttr];
    
    CGSize  ContentSize= [_traveModel.Mark boundingRectWithSize:CGSizeMake(kScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    _GuiderContent.numberOfLines = 0;
    
    [_GuiderContent setSize:ContentSize];
    
    [bjScro addSubview:_GuiderContent];
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_GuiderContent.frame)+10, kScreenWidth-20, 120)];
    imageV.image = [UIImage imageNamed:@"touxiang11"];
    [bjScro addSubview:imageV];
    
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageV.frame)+10, kScreenWidth-20, 120)];
    imageV2.image = [UIImage imageNamed:@"touxiang11"];
    [bjScro addSubview:imageV2];
    
    
    
    UIImageView *imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageV2.frame)+10, kScreenWidth-20, 120)];
    imageV3.image = [UIImage imageNamed:@"touxiang11"];
    [bjScro addSubview:imageV3];
    
    
    
    UIImageView *imageV4 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageV3.frame)+10, kScreenWidth-20, 120)];
    imageV4.image = [UIImage imageNamed:@"touxiang11"];
    [bjScro addSubview:imageV4];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
