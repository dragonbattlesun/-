//
//  HideViewControll.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/24.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

//定义一个协议
@protocol HideViewControllDelegate <NSObject>

@required //必须实现的方法
//-(void)eat;

@optional //可选实现的方法
-(void)hideViewControll:(NSIndexPath * )indexpath;
