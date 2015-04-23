//
//  StaraddressViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
@protocol StaraddressViewControllerDelegate <NSObject>
@optional;
-(void)hideViewControll:(NSIndexPath * )indexpath;

@end
//#import "HideViewControllDelegate.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface StaraddressViewController : UIViewController
@property(nonatomic,weak) id <StaraddressViewControllerDelegate>delegate;
@end
