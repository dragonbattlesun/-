//
//  FlitViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
@protocol FlitViewControllerDelegate <NSObject>
@optional;
-(void)hideFlitViewControll:(NSIndexPath * )indexpath;

@end
#import <UIKit/UIKit.h>

@interface FlitViewController : UIViewController
@property(nonatomic,weak) id <FlitViewControllerDelegate>delegate;

@end
