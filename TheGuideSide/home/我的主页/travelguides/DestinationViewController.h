//
//  DestinationViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
@protocol DestinationViewControllerDelegate <NSObject>
@optional;
-(void)hideDestinationViewControll:(NSIndexPath * )indexpath;

@end
#import <UIKit/UIKit.h>

@interface DestinationViewController : UIViewController
@property(nonatomic,weak) id <DestinationViewControllerDelegate>delegate;

@end
