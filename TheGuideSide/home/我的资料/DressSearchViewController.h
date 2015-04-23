//
//  DressSearchViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/4/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DressSearchViewControllerDelegate <NSObject>

-(void)changeAdress:(NSString *)adressString;

@end
@interface DressSearchViewController : UIViewController
@property(nonatomic,assign) id<DressSearchViewControllerDelegate> delegate;

@end
