//
//  HomeViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeViewController : UIViewController<MBProgressHUDDelegate>

@property (nonatomic,strong) NSString *MoblePhone;
@property(nonatomic,strong) MBProgressHUD *HUD;
@property(strong,nonatomic) UIAlertView *DialogBox;
@property (strong,nonatomic)  NSMutableDictionary *URLPartParamter;

@end
