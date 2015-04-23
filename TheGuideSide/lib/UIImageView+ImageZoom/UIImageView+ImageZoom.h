
//
//  UIImageView+ImageZoom.h
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-7.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface UIImageView (ImageZoom)<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>


@property (nonatomic, strong, readwrite) id myCustomProperty;
- (void)pictureBecomeBig;

@end
