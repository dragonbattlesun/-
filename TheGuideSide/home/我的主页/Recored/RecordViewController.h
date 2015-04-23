//
//  RecordViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneModel.h"
#import "MZTimerLabel.h"
#import "SearchViewController.h"
@interface RecordViewController : UIViewController<SearchViewControllerDelegate>
@property(nonatomic,strong) MZTimerLabel *timer2;
@property(nonatomic ,strong)MZTimerLabel *timer;
@property(nonatomic,strong) NSString *RecordPath;
@property(nonatomic,strong) SceneModel *Scenicmodel;
@property(nonatomic,assign) int RecordTime;
@property(nonatomic,strong) SearchViewController *searchView;


/**
 *  设置参数
 */
@property (nonatomic,copy) NSMutableDictionary *AddToExplain;
@end
