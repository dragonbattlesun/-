//
//  RoutViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RoutViewController : UIViewController

//
@property (nonatomic,strong)UITableView *RoutTable;


@property (nonatomic,strong)NSMutableDictionary *RoutParameter;

@property (nonatomic,strong) NSMutableArray *RoutDataSource;

@property (nonatomic,assign) NSInteger pageIndex;

@end
