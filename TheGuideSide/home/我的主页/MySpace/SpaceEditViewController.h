//
//  SpaceEditViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SpaceEditViewController : UIViewController<MBProgressHUDDelegate>
@property (nonatomic,copy) NSMutableDictionary *Parameter;
@property (nonatomic,copy) NSMutableDictionary *picList;
@end
