//
//  ScenicIntroduceViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScenicIntroduceViewController : UIViewController

/**
 *  获取分页
 */
@property (nonatomic,assign) NSInteger pageIndex;

/**
 *  设置参数
 */
@property (nonatomic,copy) NSMutableDictionary *Parameter;

/**
 *  绑定数据源
 */
@property (nonatomic,strong)NSMutableArray *MySpaceDataSource;

@property(nonatomic,strong)NSMutableDictionary *IconArray;

@end
