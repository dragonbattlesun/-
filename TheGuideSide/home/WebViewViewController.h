//
//  WebViewViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/29.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong) NSString *tempUrl;

@property (nonatomic,assign) BOOL isFirstLoadWeb;


@end
