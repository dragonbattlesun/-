//
//  QRcodeViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/4/13.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "QRcodeViewController.h"
#import "UIImage+MDQRCode.h"

@interface QRcodeViewController ()
@property (nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong) UIImageView *makeImage;
@end

@implementation QRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的二维码";
    
    
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(90, 30, 60, 20)];
//    lab.text = @"肖景光";
//    //lab.textColor =[UIColor <#lab#>];
//    lab.font = [UIFont boldSystemFontOfSize:15  ];
//    [self.view addSubview:lab];
//    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 50, 80, 20)];
//    lab2.text = @" 北京 丰台";
//    lab.textColor =[UIColor grayColor];
//    lab2.font = [UIFont boldSystemFontOfSize:13  ];
//    [self.view addSubview:lab2];
//    
    
    
    
    
    
    
    self.makeImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, 50, 100, 100)];
    
    [self.view addSubview:self.makeImage];
    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 200, 30, 30)];
    //    _imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_imageView];
    
    UIImage *qrImage=[UIImage mdQRCodeForString:@"http://www.baidu.com"
                                           size:100
                                      fillColor:[UIColor blackColor]];
    
    self.makeImage.image=qrImage;
    
    //  设置icon
    UIImage *iconImage=[UIImage imageNamed:@"108*108"];
    self.imageView.image=iconImage;
    
    //  添加边框
    CALayer * layer = [self.imageView layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 1.0f;
    layer.cornerRadius = 5.0f;
    
    //  icon的尺寸
    CGFloat height=20;
    CGFloat width=20;
    
    //  icon的位置
    CGRect frame=self.imageView.frame;
    frame.size.height=height;
    frame.size.width=width;
    
    CGPoint center=self.makeImage.center;
    
    frame.origin.x=center.x-width/2;
    frame.origin.y=center.y-height/2;
    
    self.imageView.frame=frame;

    

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
