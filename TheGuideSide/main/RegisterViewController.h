//
//  RegisterViewController.h
//  YjlyUserSide
//
//  Created by yanjinglvyou on 15/3/22.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (strong,nonatomic)  NSMutableDictionary *RegesterParamter;

@property (strong,nonatomic)  NSMutableDictionary *SendCodeParamter;
@property(strong,nonatomic) UIButton *doneInKeyboardButton;
@property(nonatomic,assign) NSInteger CheckStatus;
@end
