//
//  LanguageViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/26.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneModel.h"
@class AudioStreamer;

@interface LanguageViewController : UIViewController
{
    AudioStreamer *streamer;
    NSTimer *progressUpdateTimer;

}
@property(nonatomic,strong)NSString *currentImageName;
;
@property(nonatomic,strong) SceneModel *DetialModel;

@property(nonatomic,strong)NSMutableParagraphStyle *MutableStyle;
@end
