//
//  TravelGuidesViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewViewController.h"
@interface TravelGuidesViewController : UIViewController

@property (nonatomic,strong)UITableView *TravelTable;

@property (nonatomic,strong)NSMutableDictionary *TravelParameter;

@property (nonatomic,strong)NSMutableDictionary *RoutParameter;

@property (nonatomic,strong) NSMutableArray *TravelDataSource;

@property (nonatomic,strong) NSMutableArray *RoutDataSource;

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,assign) NSInteger RoutpageIndex;

@property (nonatomic,assign) NSInteger TravelpageIndex;

@property (nonatomic,assign) NSInteger SetSelected;

@property(nonatomic,strong) WebViewViewController *WebView;
@end
