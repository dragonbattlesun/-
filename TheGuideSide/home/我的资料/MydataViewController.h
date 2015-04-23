//
//  MydataViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MydataViewController : UIViewController

@property (nonatomic,copy) NSMutableDictionary *MyDataParameter;

/**
 *  绑定数据源
 */
@property (nonatomic,strong)NSMutableArray *MySpaceDataSource;

@end
