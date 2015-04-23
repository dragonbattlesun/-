//
//  UIImage+Graphics.h
//  税务影响
//
//  Created by xingjichao on 14-9-14.
//  Copyright (c) 2014年 Jehovah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Graphics)


- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font andDict:(NSDictionary *)dict;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

- (UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect;

@end
