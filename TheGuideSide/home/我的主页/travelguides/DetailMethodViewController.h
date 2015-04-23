//
//  DetailMethodViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelGuideModel.h"
@interface DetailMethodViewController : UIViewController

@property(nonatomic,strong) TravelGuideModel *traveModel;

@property(nonatomic,strong) NSMutableParagraphStyle *ParagrephStyle;
@end
