//
//  LoginViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/24.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "FindPasswordViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController : UIViewController<MBProgressHUDDelegate>
@property (strong,nonatomic)HomeViewController *Home;
@property(strong,nonatomic) UIAlertView *DialogBox;
@property(strong,nonatomic) UIButton *doneInKeyboardButton;
@property(strong,nonatomic) UIImageView *loginImageView;
@property(strong,nonatomic) UIView *loginLeftView;
@property(strong,nonatomic) UIImageView *PwdImageView;
@property(strong,nonatomic) UIView *PwdLeftView;
@property(strong,nonatomic)NSString *loginURL;
@property(strong,nonatomic)UITextField *tf_MoblePhone;
@property(strong,nonatomic)UITextField *tf_UserPwd;
@property(strong,nonatomic)NSMutableDictionary *loginParames;
@property(strong,nonatomic) UIButton *btn_Login;
@end
