//
//  MyhomeViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GuiderModel.h"
@interface MyhomeViewController : UIViewController

@property(nonatomic,assign) NSInteger selectedTag ;
@property(strong,nonatomic) UIAlertView *DialogBox;
@property (strong,nonatomic)NSString *GuiderURL;
@property(strong,nonatomic) GuiderModel *guiderModel;
@property (strong,nonatomic) NSMutableDictionary *Parameters;
@property(nonatomic,strong) NSString *seleteSpace;

@end
