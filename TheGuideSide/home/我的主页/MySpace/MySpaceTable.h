//
//  MySpaceTable.h
//  TheGuideSide
//
//  Created by sunjames on 15/4/5.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySpaceTable : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,copy) NSMutableDictionary *Parameter;
/**
 *  绑定数据源
 */
@property (nonatomic,strong)NSMutableArray *MySpaceDataSource;


@property (nonatomic,strong) UITableView *MJTableView;
@end
