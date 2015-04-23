//
//  SortViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
@protocol SortViewControllerDelegate <NSObject>
@optional;
-(void)hideSortViewControll:(NSIndexPath * )indexpath;

@end
#import <UIKit/UIKit.h>

@interface SortViewController : UIViewController
@property(nonatomic,weak) id <SortViewControllerDelegate>delegate;

@end
